# Master's Thesis — Agent Context

You are assisting Felix with his master's thesis. Read this file fully before doing anything.

## Communication
- Talk to Felix in **German**. The thesis itself is written in **English**, so all thesis text, findings and notes meant for the thesis are in English.
- Felix prefers safe, completable scope over ambitious expansion. If a task drifts outside the locked scope (see `docs/methodology.md`), say so instead of silently expanding.
- Felix keeps **one working document as the single source of truth** for the thesis structure: `docs/thesis-struktur.md`. Update it incrementally; never fork it into parallel versions.

## The thesis
- Program: Web Engineering & IT Solutions (part-time), FH Kufstein
- Title: *Evaluation of IoT Communication Protocols for Home-Based Energy Monitoring Systems: A Comparative Analysis of MQTT, HTTP Polling, and WebSockets*
- Submission window: roughly mid-November to mid-May
- Novelty argument: four metric dimensions evaluated within **one consistent hardware experiment**

Details: `docs/overview.md` (topic, RQs, hardware, state) and `docs/methodology.md` (locked decisions, fair-comparison method).

## Research questions (short)
- **RQ1** Latency and packet loss across MQTT, HTTP polling, WebSockets
- **RQ2** CPU/RAM consumption on the Raspberry Pi (psutil)
- **RQ3** Payload format: JSON vs. CBOR / Protobuf
- **RQ4** Protocol overhead and efficiency ratio (Wireshark/tcpdump; per-message headers + full connection incl. handshakes, keep-alives)
- Optional RQ5: resilience under controlled disruption (`tc`/netem) — only if RQ1–4 are done

## Hard scope boundaries
- No ML / anomaly detection (removed deliberately).
- Thread and Matter are **out of scope** (different network layer) — they appear only in Related Work as a boundary.
- No physical wall/distance tests — reproducible netem simulation instead.
- ESP32 is not a substitute for the Raspberry Pi.

## Repository layout
```
docs/                 overview, methodology, thesis structure, notes
literature/RULES.md   rules every literature agent must follow  <-- read before any literature work
literature/findings/  one findings file per RQ (+ related-work.md, existing-sources.md)
literature/search-logs/<agent>.md   per-agent search logs   ┐
literature/bib/<agent>.bib          per-agent BibTeX        ├ merged by scripts/merge-literature.sh into
literature/to-acquire.d/<agent>.md  per-agent paywall list  ┘ search-log.md, references.bib, to-acquire.md
literature/sources-existing.md      sources already used in the thesis
literature/pdfs/      downloaded full texts (git-ignored)
scripts/              helpers (pdf page extraction, parallel Codex runs)
.claude/agents/       Claude Code subagents: lit-rq1..lit-rq4, lit-related-work, lit-verifier
```

## Literature work
Before any literature task, read `literature/RULES.md`. The non-negotiables:
1. Every search is logged (per-agent files, merged with `scripts/merge-literature.sh`).
2. Page numbers only from a full text you actually read. Never guess or invent a page, a quote, a DOI or an author.
3. Paywalled sources go to the to-acquire list; Felix downloads them and drops them into `literature/pdfs/`.

## Citation style
Default to **APA 7** (`(Author, Year, p. X)`) until Felix confirms the style required by his FH Kufstein study guide. Keep BibTeX keys as `firstauthorYEARkeyword` (e.g. `dizdarevic2019survey`).
