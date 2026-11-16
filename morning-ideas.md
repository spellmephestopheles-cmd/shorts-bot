# Morning task: send 5 YouTube Short ideas to Telegram

Assumes .env (TELEGRAM_TOKEN, TELEGRAM_CHAT_ID) already exists in the repo root. Never commit or print it. Helper: `bash tg.sh` (see its header).

1. Read `.claude/skills/short-script-writer/SKILL.md` and follow its structure (Paradox -> Rapid Tension -> "You see," Pivot -> Final Twist) for the "Explained." channel.
2. Read `history.txt` and avoid repeating any topic in it. Use WebSearch for news from the last few days.
3. Mandatory mix, every day:
   - At least 1 idea is a CREATIVE, unexpected take on a current topical/news story (a surprising angle, not a recap). Tag it [TOPICAL].
   - At least 1 idea is India/Asia-specific but framed so a global audience finds it fascinating (universal hook, no insider jargon, doesn't feel local-only). Tag it [INDIA/ASIA].
   - EVERY idea must pass a virality check: score 1-5 on scroll-stopping hook in the first 2 seconds, curiosity gap, broad relatability, shareability, rewatch/twist payoff, timeliness. Replace any idea averaging below 4. Show one line per idea: `Virality: x/5 (strongest: ...)`.
4. For each idea: number (1-5), title, one line each for Paradox hook, Tension, Pivot, Twist, then the virality line. Plain text, no markdown, whole message under 3500 characters.
5. End with: `Reply with a number (1-5) to get the full script + the 3 best video styles.`
6. Save as ideas.txt. Run `bash tg.sh ack`, then `bash tg.sh sendpin ideas.txt`. Retry once if it fails.
7. Append today's date and the 5 titles to history.txt, then commit and push history.txt only. If the push fails, ignore it.

Send nothing else to Telegram.
