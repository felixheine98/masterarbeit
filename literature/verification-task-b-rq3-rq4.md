# Task B verification — RQ3 and RQ4

Verifier: lit-verifier-rq3-rq4 · Date: 2026-10-03

Scope: every numbered finding in `rq3-payload.md` and `rq4-overhead.md`, plus numerical synthesis, overhead-definition rows, derived framing formulas and related methodological-gap assertions. Bibliographic existence/DOI checks and the central merge/report are owned by the coordinating verifier, not this worker.

| File | Findings audited | ✔ checked without material error | ✘ corrected/problem explained | ✘ missing full text |
|---|---:|---:|---:|---:|
| rq3-payload.md | 29 | 20 | 9 | 0 |
| rq4-overhead.md | 18 (F1–F17 plus F5b) | 12 | 5 | 1 |
| Total | 47 | 32 | 14 | 1 |

The cross marks preserve audit history even where the finding was corrected successfully. They do not mean that the corrected text still contains the original error. Forty-six findings have a full-text/documentation basis checked in this audit; only Thangavel F6 is not cleared. No abstract was promoted to full-text evidence. Foundational RFC abstract passages were read in the complete RFC, not a database abstract record.

Four external primary-source retrievals were executed and logged in `search-logs/lit-verifier-rq3-rq4.md`: RFC 6455, RFC 6202, RFC 8446 and Wireshark Ethernet. All succeeded; four existing sources screened, zero new research sources included, zero PDFs downloaded and zero new acquisition items created. Thangavel was already on the acquisition list. Existing Google Protobuf snapshots were read locally. Twenty-eight distinct local PDFs were extracted, including empirical sources and normative RFC/OASIS PDFs; RFC 8259 was read in its existing plain-text copy. No new topics, formats or experiments were added.

Important corrections:

- RQ3 F3: the RFC 8949 shortest-float MUST quotation is Sec. 4.2.1, printed p. 26. Sec. 4.1, p. 25 defines preferred serialization without requiring every implementation to enforce it. Preferred and core deterministic behavior are now distinguished.
- RQ3 F6: the SchemaStore population contains 400+ documents, but Viotti benchmarks 27 selected cases. The 9.1 % figure in Table 64 is the average of the individual format medians, not the median for every schema-less format or a pooled document median. CBOR itself has a 22.5 % median and MessagePack 22.7 %; the schema-driven average of medians is 50.6 %, with Protobuf itself 70.6 %. Finding and synthesis corrected.
- RQ3 F11: Kumar Table 2 byte counts are witnessed, but three printed percentages are inconsistent with the displayed 418 B baseline: CBOR 298 B gives 28.7 % (reported 28.4 %), Protobuf 138 B gives 67.0 % (reported 66.7 %), struct+zlib 127 B gives 69.6 % (reported 69.2 %). The finding distinguishes source reports from arithmetic; synthesis uses recomputed values.
- RQ3 F23: Lenders reports a 9.1 s saving (13.8 %) for the object with the largest absolute improvement, plus 13.5 ms at the 99th percentile. This does not establish 13.8 % as a universal maximum relative improvement or prove smaller objects never benefit. Scope corrected.
- RQ3 F24: Maltsev's 81.10 % Protobuf / 23.17 % CBOR savings belong to the smaller-message 15-epoch variant; the larger 30-epoch variant gives 33.06 % / 14.98 %. Both variants now contextualize the selected result.
- RQ3 F1, F7, F18 and F21: softened JSON interoperability restriction, corrected subsection locators, and distinguished Thrift's off-device Java size test from MCU timing.
- RQ4 F3: CONNECT Properties is MQTT 5.0 Sec. 3.1.2.11 on p. 34; the old Sec. 3.1.2.10 pointed to Keep Alive.
- RQ4 F5b: protected TLS 1.3 records contain a 5 B outer header, an encrypted inner content-type byte, optional padding and AEAD expansion. Common lower-layer framing mechanisms do not guarantee identical traffic totals across protocols.
- RQ4 F8: Hong's non-ping MQTT case has 39/113 = 34.5 % payload share, whereas the mean including ping traffic gives 39/124.2 = 31.4 %. Bases separated.
- RQ4 F10: largest displayed TLS increment is 4685−1560 = 3125 B (QoS 2/PKI); the old approximately 2900 B title ceiling was too low. Exact totals remain as the source reports.
- RQ4 F12: Appelqvist p. 41 has internal arithmetic errors. 494/38 is 1300 % of SSE traffic, hence 1200 % more. With a 5000 B payload, 464 B long-poll framing gives 5464 B, not 5494 B, and 9.1 % more than 5008 B SSE, not 9.7 %. WebSocket's 2 B framing is specification-derived, rather than a measured table entry.

Checks and retained limitations:

- Friesel Fig. 1 was rendered and read: mean labels JSON 111 B, CBOR/MessagePack 85 B, Protobuf 40 B. Mean/median and source datasets are distinguished. Petersen Figs. 2–3 were rendered and read: the previously corrected uncompressed/compressed series and all timing/byte transcriptions are confirmed.
- All six RQ3 synthesis rows were checked against their tables/figures and percentage baselines. Selected payload results are not universal bounds. Process-memory figures from Proos include libraries and input structures; no pure-library-footprint claim is inferred.
- All ten RQ4 overhead-definition rows were checked. Thangavel's row is provisional. Năstase's documented useful-byte total 3514 B exceeds ten × 212 B raw JSON messages (2120 B), and the source does not explain the extra numerator bytes; its operational ratio therefore must not automatically be identified with the thesis telemetry-payload numerator.
- Enache Table 5 and quote match the paper, but the measurements are secondary from references [8]/[13]. The underlying Craggs measurement and counted layer remain unverified. This is MQTT over WebSocket, not native WebSocket telemetry.
- All five RQ4 framing-formula rows and example/boundary arithmetic were checked. MQTT acknowledgment additions are 0/4/12 B for QoS 0/1/2; unfragmented WebSocket framing is 2/4/10 B server-to-client and adds 4 B client-to-server; Ping plus corresponding Pong is 8+2K B. Valid protocol lengths, direction, single-hop scope, extensions and fragmentation assumptions remain explicit. HTTP message and chunked framing were checked from RFC 9112 Secs. 2.1/7.1.
- Broad gap assertions were narrowed: Appelqvist discusses HTTP persistence and expects connection reuse; Năstase includes an HTTP querying client; Sasaki models traffic over increasing message counts; Proos explicitly defines a link-frame counting boundary. These sources do not establish universal absences of polling, persistent connections, message-count analysis or explicit layers. The remaining gap is the thesis' common matched testbed and measured dimensions.
- Petersen's Pi latency is derived by returning data and dividing elapsed time by two; this was added to F26. Tusa's fixed-window delivery counts detect backlog and are not independently measured packet loss. Paper-specific latency/resource findings remain scoped to their hardware and implementation.

Unverifiable item needing Felix's attention:

`thangavel2014performance`, RQ4 F6: no full text is stored locally or available from the imported Task A worktree. The prior batch used an unsaved Clemson-hosted copy. Its quotation, pages and ratio definition cannot be verified in this Task B audit. Page/citation fields and synthesis row are now explicitly UNVERIFIED; obtain the IEEE or legal author full text before using that page-level finding in the thesis. No speculative retrieval or new research expansion was attempted.

Every numbered finding carries its own `Verification (Task B, 2026-10-03)` line documenting exact witnesses and corrections. Whitespace, typesetting ligatures and line-break hyphens were normalized only for matching; no source wording was silently rewritten as a direct quotation. Accepted/arXiv versions continue to use sections when final publication pagination was not witnessed.
