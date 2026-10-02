#!/usr/bin/env bash
# Explicit existing-token helper. No signup, host override or automatic retry.
set -euo pipefail
command -v jq >/dev/null || { echo 'jq is required' >&2; exit 1; }
key="${FORMBUILDER_API_KEY:-}"
[[ "$key" =~ ^fbpat_[A-Za-z0-9_-]{20,200}$ ]] || { echo 'Configure an existing FormBuilder API token outside the conversation.' >&2; exit 1; }
publish="${PUBLISH:-false}"
[[ "$publish" == true || "$publish" == false ]] || { echo 'PUBLISH must be true or false.' >&2; exit 1; }
fields="${FIELDS_JSON:-}"
if [[ -z "$fields" ]]; then
  fields='[{"label":"Name","type":"text","required":true},{"label":"Email","type":"email","required":true},{"label":"Message","type":"textarea"}]'
fi
body=$(jq -en --arg title "${TITLE:-Contact us}" --argjson fields "$fields" --argjson publish "$publish" 'if ($fields|type)!="array" or ($fields|length)==0 then error("Fields must be a nonempty array") else {title:$title,fields:$fields,publish:$publish} end')
# Pass the authorization header through stdin so it is absent from curl's arguments.
response=$(printf 'header = "Authorization: Bearer %s"\n' "$key" | curl --config - --silent --show-error --connect-timeout 5 --max-time 30 --proto '=https' --max-redirs 0 --request POST 'https://api.formbuilder.com/api/v1/forms' --header 'Content-Type: application/json' --data-binary "$body" --write-out $'\n%{http_code}') || { echo 'The create result is uncertain. Check your forms before trying again.' >&2; exit 1; }
status="${response##*$'\n'}"
payload="${response%$'\n'*}"
[[ "$status" == 201 ]] || { echo "Form creation was not confirmed (HTTP $status). Check your forms before retrying." >&2; exit 1; }
printf '%s' "$payload" | jq -er 'if .id and (.status=="draft" or .status=="published") then "Created \(.title) (\(.status))\nEdit: \(.edit_url)" + (if .status=="published" and .public_url then "\nPublic: \(.public_url)" else "" end) + (if .publish_blocked_reasons then "\nHeld: \(.publish_blocked_reasons|join("; "))" else "" end) else error("Unrecognized create response") end'
