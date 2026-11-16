# Hourly task: deliver the full script for an approved idea

Assumes .env (TELEGRAM_TOKEN, TELEGRAM_CHAT_ID) already exists in the repo root. Never commit or print it. Helper: `bash tg.sh`. Be quick, and stop early when there's nothing to do.

1. Run `bash tg.sh pinned`. If it prints nothing, STOP: no ideas are waiting for approval.
2. Run `bash tg.sh replies`. If no message picks an idea 1-5 (e.g. "3", "idea 2", "go with 4"), STOP and do nothing. Do NOT ack.
3. Take the most recent choice and find that idea in the pinned text.
4. Read `.claude/skills/short-script-writer/SKILL.md` and write the FULL Short script for that idea, following it exactly.
5. WebFetch https://www.futurepedia.io/resources/ai-style-atlas/view and read its list of video/visual styles. Pick the TOP 3 that best fit this script: give each style's name exactly as it appears on the site, plus 1-2 lines on why it fits and how to use it in this script's scenes. If the page can't be read, say so in the message instead of inventing style names.
6. Write script.txt: the script, then a "Top 3 video styles" section with the picks. Plain text. Run `bash tg.sh send script.txt`.
7. Run `bash tg.sh ack`, then `bash tg.sh unpin`.
8. Save a copy as scripts/<YYYY-MM-DD>-<short-title>.txt, then commit and push it. If the push fails, ignore it.

Send only that one message to Telegram.
