# Stripe Local Webhook Tunnel

Notes and sample commands for receiving Stripe webhooks on your laptop using the Stripe CLI and/or ngrok.

No secrets belong in this repo. Use test-mode keys only.

## Files

- `NOTES.md` — ngrok + Stripe CLI workflow
- `commands.sh` — copy-paste sample commands
- `sample-events.md` — useful event types for digital products
- `LICENSE` — MIT

## Quick path (Stripe CLI — preferred)

```bash
stripe login
stripe listen --forward-to localhost:4242/webhook
# In another terminal:
stripe trigger checkout.session.completed
```

## License

MIT
