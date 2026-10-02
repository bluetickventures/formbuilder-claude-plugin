# FormBuilder for Claude

Build, preview, edit, publish and analyze forms and surveys in your [FormBuilder](https://formbuilder.com) account without leaving Claude. This plugin connects Claude to FormBuilder's hosted MCP server and adds a form-design skill so Claude builds well-structured forms.

## What you can do

- **Create forms from a description.** "Make an RSVP form for our product launch with name, email, number of guests and dietary needs." FormBuilder saves a private draft and shows a live preview of the form in the conversation.
- **Edit drafts.** Add, change, delete and reorder questions. Supported question types include short and long text, email, phone, number, date, time, dropdowns, multiple choice, checkboxes, ranking, file upload, star rating, NPS, slider, signature, name, address and section headings.
- **Publish and unpublish** when you ask. Publication may be held for an automated safety review.
- **Review responses** in an in-chat table, filter them by date or answer, and have Claude summarize feedback, applications, RSVPs and more.
- **Webhooks.** Send new responses to an HTTPS destination you choose, and list or delete those webhooks.

## Setup

1. Install the plugin. The bundled MCP server is `https://api.formbuilder.com/mcp`.
2. When Claude first uses FormBuilder, sign in to your FormBuilder account (a free account works) and approve the requested permissions. Access is limited to your own account.

## Limits

The plugin cannot delete forms or responses, edit published forms (unpublish first), or configure payments and conditional logic. Use the FormBuilder editor for those.

## Privacy and support

- Privacy policy: https://formbuilder.com/privacy
- Terms: https://formbuilder.com/terms
- Developer docs: https://formbuilder.com/developers
- Support: support@formbuilder.com

The optional `skills/formbuilder-forms/scripts/create_form.sh` helper is for developers who prefer the REST API with their own existing API token (set `FORMBUILDER_API_KEY` in the environment; never paste a token into chat). The normal flow uses OAuth sign-in.

## License

MIT. See [LICENSE](LICENSE).
