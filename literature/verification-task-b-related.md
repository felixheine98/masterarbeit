# Task B verification — Related Work

Agent: lit-verifier-related · Date: 2026-10-03

## Coverage and result

All **29 numbered findings F1–F29** in `literature/findings/related-work.md` were audited, including every quotation and page/section locator. Each now has an explicit Task B status. The dimension table, gap synthesis, page-offset records and cross-references were also checked within this file.

- **27 verified at their stated evidence basis:** 22 against inspected PDF passages, 2 against primary web documentation, and 3 against primary or author-institution abstracts (F17, F20, F24). An abstract pass is not a full-text pass.
- **2 unresolved primary-evidence checks:** F18 (Oliveira) and F19 (Silva). The local PDFs are missing; direct IEEE pages did not expose the abstracts, and author institutional records verified identity without revealing usable primary content. Secondary indexed abstracts were not used as a substitute for a fresh primary-source check. The RQ1 verifier additionally recovered DOI-matched OpenAlex metadata abstracts; that corroboration does not establish a primary full-text pass.
- **21 distinct local PDFs inspected**, including Petersen for the coverage table and both CSA primary PDFs. One existing included source received a newly downloaded PDF: **Bayılmış et al. (2022)**, `literature/pdfs/bayilmis2022survey.pdf`.
- External checking used **8 grouped log records**, comprising 11 exact query strings in 3 targeted search batches and primary-page retrievals/finds. No new topic or source was introduced. The recovered PDF is an evidence upgrade for an existing source.

This completes the assigned-file audit, with the two evidence failures recorded rather than passed. Bibliographic DOI checking, merges and the consolidated report are owned by the coordinating verifier.

## Corrected or qualified conclusions

1. **F13 — network setup:** Năstase explicitly connects the Raspberry Pi and PC to a **100 Mbps LAN switch**, p. 408 (PDF page 6). The finding previously called the experimental path wireless, apparently carrying over the article's general wireless framing. The measured metrics and conclusion quotation are supported; no CPU/RAM, packet-loss or serialization-factor experiment is presented.
2. **F9/F10 — historical gap scope:** Al-Fuqaha's p. 2356 absence statement refers to the protocols considered by the 2015 survey, not the thesis' exact three paths and four metrics in 2026. The p. 2363 passage concerns broad IoT application performance, including underlying technologies and QoS. Two passages in one paper are not independent sources. Wording now reflects these limits.
3. **F12 — bibliometric inference:** Mishra compares MQTT/CoAP/AMQP publication **counts** for 2015–2019 and separately calculates historical MQTT growth. The previous comparative-growth claim exceeded this evidence.
4. **F14 — efficiency versus latency:** Petrescu's p. 21 hierarchy concerns **energy efficiency** and synthesizes cited studies. It does not establish an unqualified worst-latency result for HTTP polling. Relevance now leaves connection reuse and polling policy to the experiment.
5. **F16 — secondary measurements:** Enache's Sec. 5, p. 48, explicitly states that all measurements were performed by references [8]/[13]. The previous tentative attribution is now definite.
6. **F22/table — recovered evidence:** Bayılmış's publisher-version PDF has 11 pages; PDF pages 8–10 equal printed pp. **1101–1103**. Sec. 4 tests **WeMOS D1/ESP8266EX + i7 Windows 10 laptop**, MQTT/CoAP/WebSocket, 10,000 messages per size (8–1024 bytes), a stated 10 ms waiting interval, throughput, **delay between packet arrival times**, and consumption reported in **mAh**. This is charge rather than directly energy. Its theoretical efficiency equations (1)–(2) include handshakes/headers but omit layers 1–3. It does not measure CPU/RAM consumption or vary serialization format. Wi-Fi plus a mobile 4.5G path is described. The table now records this partial latency/overhead coverage instead of unknowns.
7. **System-paper resource gap:** Albraheem p. **361** reports Android-app CPU use of 1–32% and about 395 MB memory. The blanket claim that the system papers report no resource figures was wrong; the corrected gap concerns controlled protocol comparisons and Raspberry Pi resource measurements.
8. **Sampling/generalization:** Removed the claim that most WebSocket comparisons run on microcontrollers. The inspected sample supports several examples, not a literature-wide majority. The consumer smart-plug gap is explicitly limited to the inspected comparison table and fixed-trace triple comparison; unread studies do not establish absence.
9. **F25–F27 pagination/context:** Kim's deposited layout has pages 2–8, not journal pages 55–61; Madadi's author version has pages 1–7, not journal pagination. Section citations were retained and the offset record clarified. F27's claim that methodology still shares the wrong Thread/Matter argument was stale: methodology already separates the arguments.
10. **Quotation hygiene:** Several quotations were shortened to exact sentence excerpts. Multi-column reading and PDF line-break dehyphenation were handled explicitly; no journal-page range was transplanted to an unpaginated/differently paginated manuscript.

## Local full-text inspection record

| Source | Inspected evidence locators |
|---|---|
| Lima | pp. 786–787, 795–797 = PDF 13–14, 22–24; dual collection, API integration, interval and pipeline |
| Manowska | pp. 1, 6, 9; architecture, Pi 3 B+, laboratory test restriction |
| Rojek | p. 038-8, conclusions p. 038-9 = PDF 8–9; middleware/browser-access roles |
| Albraheem | pp. 359–361 = PDF 7–9; cloud pipeline, power readings, Android resources/stress test |
| Suryadevara/Biswal | pp. 8, 13; radio/application-layer mixing and commercial table |
| Oh | p. 1 abstract; programme duration, households, approximate savings and associations |
| Al-Fuqaha | pp. 2356, 2363 = PDF 10, 17; original gap wording and scope |
| Naik | Sec. IV and relative-ranking discussion; PDF 3; static/literature basis |
| Mishra/Kertesz | pp. 201071, 201077–201078 = PDF 1, 7–8; abstract, counts, growth |
| Năstase | pp. 407–411 = PDF 5–9; setup, metrics, results and conclusions |
| Petrescu | pp. 15–16, 21; WebSocket/HTTP limitations and energy hierarchy |
| Bhowmik/Riaz | p. 3134 = PDF 1, abstract; six protocols and literature basis |
| Enache | pp. 48–49 = PDF 3–4; Tables 3–5, explicit secondary attribution, conclusions |
| Tusa/Clayman | article pp. 8–11, 17–18; variants, hardware, resources/bytes, queue-count interpretation, MQTT future work |
| Bayılmış | p. 1094 and pp. 1101–1103 = PDF 1, 8–10; identity and whole experiment section |
| Karagiannis | Secs. 8–9, deposited page 5; qualitative scope and future experiment |
| Kim | Introduction, PDF 1 (layout page 2), subsequent networking discussion |
| Madadi | Secs. I, III–IV, author PDF 1–4; application stack, supported technologies, performance scope |
| CSA Matter Core 1.2 | Secs. 2.1–2.3, pp. 47–49 = PDF 51–53; architecture only |
| CSA Matter overview | second-page heading “Build on proven, widely deployed technologies” |
| Petersen communication comparison | Secs. II, IV–V; middleware × serializers, Pi setup, ten repetitions, memory exclusion |

## Remaining limits and Felix's attention

- **Oliveira (F18) and Silva (F19):** acquire full texts or a usable primary abstract before citing their quotations as independently verified. Their table rows retain abstract-only coverage.
- **Mijovic (F17), Kaur/Khanna (F24):** primary abstract claims verified, full-text methods/dimension coverage still unavailable. Keep unknown dimensions as `?`.
- **Amirkhanov (F20):** publisher abstract verified independently; the page-level continuation is RQ1's evidence and was not re-read as a local PDF by this verifier. Local archival copy remains absent here.
- **Manowska:** online date is December 2022 but the PDF's issue citation says 2023; preserve the disclosed distinction until reference-list year convention is settled.
- **Karagiannis:** deposited manuscript does not resolve the journal volume conflict; do not turn bibliographic pp. 9–18 into evidence pagination.
- **Shelly:** behaviour is verified for the documented RPC channels; corporate reference-list naming remains a separate metadata question. HTTP lacking notifications is device-specific, not a universal HTTP characteristic.
- Historical OpenAlex citation counts were retained as dated, indicative research notes, **not independently refreshed by this findings verifier**. They do not support the novelty argument.
- Novelty remains a bounded synthesis: no inspected row establishes the complete three telemetry paths/four dimensions/fixed smart-plug trace on a Pi. This is not proof of absence across all literature; IEEE/ACM discovery coverage limitations remain explicit.

The Bayılmış PDF was retrieved from the [Karabük University publication system](https://unis.karabuk.edu.tr/app_files/2026/02/Yayin_Pdf_63564_e573e2a5.pdf). The certificate chain failed in the local curl environment; the retry used `--insecure` only for this public document after escalation, then PDF identity, title/DOI and pagination were checked locally. No shadow-library copy was used.
