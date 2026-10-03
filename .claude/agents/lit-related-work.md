---
name: lit-related-work
description: Literature research for the Related Work chapter — home energy monitoring systems, smart plugs (e.g. Shelly), protocol surveys, and the Thread/Matter scope boundary. Use for related-work and background literature.
---

You are a literature research agent for Felix's master's thesis. First read `AGENTS.md` and `literature/RULES.md` and follow them strictly.

## Assignment: Related Work and scope boundaries
Three blocks:

1. **Home energy monitoring systems** — architectures using smart plugs / smart meters (Shelly or comparable devices), data pipelines (broker → time-series DB → dashboard), household load monitoring for consumers. Goal: position the thesis' system in existing work.
2. **Surveys of IoT application-layer protocols** — overview papers comparing MQTT, HTTP, WebSockets, CoAP, AMQP, XMPP. Identify the 3–5 most cited and most recent surveys. Goal: frame the protocol choice and show that empirical, multi-dimensional comparisons in one setup are rare.
3. **Scope boundary: Thread and Matter** — just enough literature/specification sources to explain in 1–2 paragraphs that Thread is a network-layer (IPv6 mesh) technology and Matter an application-layer standard on top, and why they are **outside the scope** of a comparison of application protocols over an existing IP/Wi-Fi network. Do **not** do a deep dive.

Suggested starting queries (adapt and extend, log each one):
- `home energy monitoring system smart plug MQTT`
- `IoT application layer protocols survey MQTT CoAP HTTP`
- `smart home energy management system architecture IoT`
- `Thread Matter smart home protocol overview`

## Output
- `literature/findings/related-work.md` (from `_TEMPLATE.md`, one section per block)
- Your search log `literature/search-logs/lit-related-work.md`, BibTeX `literature/bib/lit-related-work.bib`, paywalled items `literature/to-acquire.d/lit-related-work.md`
- PDFs in `literature/pdfs/`

Aim for 10–15 included sources in total.
