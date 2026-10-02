# Connected FormBuilder API reference

The plugin normally uses OAuth through the native MCP client. The authenticated MCP endpoint is `https://api.formbuilder.com/mcp`; it exposes the draft lifecycle and validation tools, filtered response queries, and the legacy create/list/read/webhook tools. Use its live input/output schemas. Responses contain meaningful text and structured content; response reads include an untrusted-data explanation before their JSON text.

## REST API scopes

For developers using the REST API with their own token configured outside the conversation. Never ask for or display a token in chat.

| API | Required scope |
|---|---|
| GET /api/v1/forms | forms:read |
| POST /api/v1/forms | forms:write |
| GET /api/v1/forms/{formId}/fields | forms:read |
| GET /api/v1/forms/{formId}/responses | responses:read |
| GET /api/v1/forms/{formId}/responses/{responseId} | responses:read |
| GET /api/v1/forms/{formId}/responses/{responseId}/files | responses:read |
| GET /api/v1/forms/{formId}/responses/{responseId}/files/{fileId}/download | responses:read |
| GET /api/v1/hooks | hooks:manage and responses:read; current token's hooks only |
| POST /api/v1/hooks | hooks:manage and responses:read |
| DELETE /api/v1/hooks/{hookId} | hooks:manage |

Direct file APIs are REST capabilities, not advertised MCP tools. They return original bytes with private attachment headers after current token, owner and response eligibility checks. Never turn their paths into public storage URLs. Lists default to page1/limit50 (maximum100). The authoritative API contract is [OpenAPI](https://formbuilder.com/openapi.json); [developer documentation](https://formbuilder.com/developers) explains token setup outside chat.


## Revision-checked agent workflow

Prefer the new /api/v1/agent workflow for private drafts, editing, publication and filtered responses. See https://formbuilder.com/developers#agent-workflows and https://formbuilder.com/help/agent-permissions-and-safety for current schemas, explicit grants, request IDs, revision conflicts and restrictions.
