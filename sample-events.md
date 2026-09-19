# Sample event types (digital downloads)

| Event | When to handle |
|-------|----------------|
| `checkout.session.completed` | Fulfill download / send license email |
| `payment_intent.succeeded` | Backup fulfillment signal |
| `charge.refunded` | Revoke license / disable download |
| `checkout.session.expired` | Clean up pending orders |
| `invoice.paid` | Subscription renewals |

## Minimal handler sketch (pseudo)

```
on POST /webhook:
  event = construct_event(raw_body, signature, whsec)
  if seen(event.id): return 200
  switch event.type:
    case checkout.session.completed: fulfill(event.data.object)
  mark_seen(event.id)
  return 200
```
