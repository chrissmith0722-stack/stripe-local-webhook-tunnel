#!/usr/bin/env bash
# Sample commands — edit ports/paths to match your app.
# Do not put live secrets in this file.

set -euo pipefail

PORT="${PORT:-4242}"
PATH_SUFFIX="${PATH_SUFFIX:-/webhook}"

echo "== Stripe CLI listen (preferred) =="
echo "stripe listen --forward-to localhost:${PORT}${PATH_SUFFIX}"
echo
echo "== Trigger common fixtures =="
echo "stripe trigger checkout.session.completed"
echo "stripe trigger payment_intent.succeeded"
echo "stripe trigger charge.refunded"
echo
echo "== ngrok http tunnel (optional) =="
echo "ngrok http ${PORT}"
echo "# then set Dashboard webhook to https://<id>.ngrok-free.app${PATH_SUFFIX}"
echo
echo "== Useful inspect =="
echo "stripe events list --limit 10"
echo "stripe logs tail"
