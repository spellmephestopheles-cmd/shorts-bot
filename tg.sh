#!/usr/bin/env bash
# Telegram helper for @Meralekhak_bot (cloud version - state lives in Telegram itself)
#   bash tg.sh send <file>     send file text (split at 4000 chars)
#   bash tg.sh sendpin <file>  send file text and pin it (today's ideas)
#   bash tg.sh pinned          print the pinned ideas message (empty = nothing awaiting)
#   bash tg.sh unpin           unpin all (marks ideas as handled)
#   bash tg.sh replies         print user's unread messages (does not mark them read)
#   bash tg.sh ack             mark all current messages as read
DIR="$(cd "$(dirname "$0")" && pwd)"
# Token/chat id come from .env (not in git) or env vars TELEGRAM_TOKEN / TELEGRAM_CHAT_ID
[ -f "$DIR/.env" ] && source <(tr -d '\r' < "$DIR/.env")
API="https://api.telegram.org/bot$TELEGRAM_TOKEN"
CID="$TELEGRAM_CHAT_ID"

send_text() {
  local text="$1" first=""
  while [ -n "$text" ]; do
    local chunk="${text:0:4000}"; text="${text:4000}"
    local r; r=$(curl -s -X POST "$API/sendMessage" --data-urlencode "chat_id=$CID" --data-urlencode "text=$chunk")
    echo "$r" | grep -q '"ok":true' || { echo "SEND FAILED: $r"; exit 1; }
    [ -z "$first" ] && first=$(echo "$r" | grep -o '"message_id":[0-9]*' | head -1 | grep -o '[0-9]*$')
  done
  MSG_ID="$first"
}

case "$1" in
  send) send_text "$(cat "$2")"; echo SENT ;;
  sendpin)
    send_text "$(cat "$2")"
    curl -s -X POST "$API/unpinAllChatMessages" -d "chat_id=$CID" >/dev/null
    curl -s -X POST "$API/pinChatMessage" -d "chat_id=$CID" -d "message_id=$MSG_ID" -d "disable_notification=true" | grep -q '"ok":true' && echo "SENT+PINNED" || echo "SENT (pin failed)" ;;
  pinned)
    curl -s "$API/getChat?chat_id=$CID" | python3 -c 'import sys,json; d=json.load(sys.stdin)["result"]; print(d.get("pinned_message",{}).get("text",""))' ;;
  unpin) curl -s -X POST "$API/unpinAllChatMessages" -d "chat_id=$CID" >/dev/null; echo UNPINNED ;;
  replies)
    curl -s "$API/getUpdates" | python3 -c '
import sys,json
for u in json.load(sys.stdin)["result"]:
    m=u.get("message",{})
    if str(m.get("chat",{}).get("id"))==sys.argv[1] and "text" in m: print(m["text"])' "$CID" ;;
  ack)
    last=$(curl -s "$API/getUpdates" | grep -o '"update_id":[0-9]*' | tail -1 | grep -o '[0-9]*$')
    [ -n "$last" ] && curl -s "$API/getUpdates?offset=$((last+1))" >/dev/null; echo ACKED ;;
  *) echo "usage: tg.sh send|sendpin <file> | pinned | unpin | replies | ack" ;;
esac
