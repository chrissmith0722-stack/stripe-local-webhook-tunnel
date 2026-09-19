# Local Stripe webhooks: Stripe CLI vs ngrok

## Option A — Stripe CLI (recommended)

The Stripe CLI opens a secure tunnel to Stripe and forwards events to your local server. You do **not** need ngrok for the common case.

1. Install: https://stripe.com/docs/stripe-cli
2. `stripe login` (opens browser; test mode)
3. Run your app on a local port (example `4242`)
4. `stripe listen --forward-to localhost:4242/webhook`
5. Copy the webhook signing secret (`whsec_...`) the CLI prints into your local env (never commit it)
6. Trigger fixtures: `stripe trigger payment_intent.succeeded`

### Digital product events to forward

- `checkout.session.completed`
- `payment_intent.succeeded`
- `charge.refunded`
- `customer.subscription.updated` (if subscriptions)

## Option B — ngrok (when you need a public URL)

Use ngrok if a third party must POST to you, or you're debugging a Dashboard endpoint URL.

1. Install ngrok; authenticate with your ngrok account
2. Run your local server: e.g. `localhost:4242`
3. `ngrok http 4242`
4. Copy the `https://….ngrok-free.app` URL
5. In Stripe Dashboard → Developers → Webhooks → Add endpoint
   URL: `https://YOUR_SUBDOMAIN.ngrok-free.app/webhook`
6. Select events; reveal signing secret → local env only

**Caveats**

- Free ngrok URLs change on restart → update the Dashboard endpoint
- Don't commit ngrok auth tokens or Stripe secrets
- Prefer test mode until the handler is idempotent

## Security checklist

- [ ] Verify `Stripe-Signature` on every request
- [ ] Reject replayed / old timestamps
- [ ] Treat webhook handlers as idempotent (store `event.id`)
- [ ] Never log full request bodies with PII in production logs
