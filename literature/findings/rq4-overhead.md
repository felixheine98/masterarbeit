# Findings — RQ4: Protocol overhead and efficiency ratio (MQTT, HTTP polling, WebSockets)

Agent: lit-rq4 · Last updated: 2026-10-03

## Summary
The specifications define MQTT and WebSocket framing precisely; HTTP/1.1 overhead depends on the actual serialized request and response. The studies examined use incompatible counting boundaries, and only Năstase et al. (2017) report a payload-to-total-bytes efficiency ratio for HTTP, MQTT and native WebSocket together, using ten messages with protocol-specific layouts. The continuation adds Proos and Carlsson (2020): their Wireshark-based metric distributes heartbeat traffic across messages but explicitly excludes transport retransmissions. No source examined reports a separate keep-alive byte breakdown and session-length amortisation for all three thesis protocols with identical payloads. These limitations support measuring application framing and full-session captured traffic separately; they establish a gap in the reviewed sample, not an exhaustive claim about all published work.

Sources already recorded for RQ4 in `sources-existing.md` (Sarafov, TUM NET-2018-03-1; arXiv:1409.3367, identified in this session from its PDF title page as G. L. Muller's Cranfield MSc thesis on the WebSocket protocol; IJRASET 2026) were **not** re-analysed here; Sarafov's reference list was used for backward snowballing only.

Task B evidence status (2026-10-03): all 18 findings (F1–F17 plus F5b), all overhead-definition rows and all five derived-framing rows were audited. Seventeen findings have a checked full-text basis, including corrected items; F6 remains unverifiable because its PDF is absent. The audit preserves source errors and limitations in individual verification lines.

## Findings

### A. What the specifications fix (exact header sizes)

### F1: MQTT fixed header is 2 bytes minimum; Remaining Length is variable (1–4 bytes)
- **Claim:** Every MQTT control packet starts with a fixed header consisting of one type/flags byte and a variable-length Remaining Length field; the Remaining Length counts variable header plus payload but not its own encoding bytes. Per-message MQTT overhead for a PUBLISH therefore depends on topic length and QoS, not just on the "2-byte header" quoted in most papers.
- **Source:** [@banks2014mqtt]
- **Page / section:** Sec. 2.2 (p. 16) and Sec. 2.2.3 (p. 18)
- **Evidence:** "The Remaining Length does not include the bytes used to encode the Remaining Length."
- **Basis:** full text
- **Relevance:** supports — normative basis for computing the expected per-message MQTT header bytes that the Wireshark measurement must reproduce.
- **Cite as (APA 7):** (Banks & Gupta, 2014, Sec. 2.2.3)
- **Verification (Task B, 2026-10-03):** ✔ verified — local MQTT 3.1.1 pp. 16, 18 and PUBLISH pp. 35–36 read; quote matches after removing PDF margin line numbers, and Remaining Length excludes its own encoding.

### F2: MQTT keep-alive is client-driven; PINGREQ and PINGRESP are 2-byte packets
- **Claim:** The nonzero Keep Alive value (16-bit, seconds) is set in CONNECT; if the client sends no other control packet within that interval it must send a PINGREQ, and the server disconnects after 1.5 times the interval without a client control packet. PINGREQ has only the fixed header with Remaining Length 0 (i.e. 2 bytes at the MQTT layer) and no payload. Regular publishing can satisfy the mandatory keep-alive requirement, but the standard also permits PINGREQ at any time; actual ping traffic depends on the client implementation. Keep Alive = 0 disables the inactivity mechanism.
- **Source:** [@banks2014mqtt]
- **Page / section:** Sec. 3.1.2.10 (p. 27); Secs. 3.12–3.13 incl. Figures 3.33–3.34 (pp. 48–49); conformance statement MQTT-3.1.2-23 (p. 72)
- **Evidence:** "In the absence of sending any other Control Packets, the Client MUST send a PINGREQ Packet."
- **Basis:** full text
- **Relevance:** method inspiration — document Keep Alive, send interval and observed PINGREQ/PINGRESP counts; do not infer zero ping traffic solely from regular publishing. **Correction verified in this continuation:** Sec. 3.1.2.10 explicitly permits discretionary PINGREQ.
- **Cite as (APA 7):** (Banks & Gupta, 2014, Sec. 3.1.2.10)
- **Verification (Task B, 2026-10-03):** ✔ verified — pp. 27, 48–49, 72; discretionary PINGREQ, 1.5× inactivity, zero Keep Alive and both 2 B ping packets checked. Locator extended to PINGRESP Sec. 3.13/pp. 48–49.

### F3: MQTT 5.0 adds a Properties field to most packets; MQTT over WebSocket is specified
- **Claim:** MQTT 5.0 keeps the fixed-header structure and adds a Properties block (Property Length + properties) to CONNECT, CONNACK and PUBLISH. The minimum additional Property Length byte for those packets must not be generalized to every MQTT control packet. Report the protocol version and enabled properties with overhead figures. MQTT 3.1.1 also specifies transport over WebSocket binary frames, which stacks WebSocket framing on top of MQTT.
- **Source:** [@banks2019mqtt]; [@banks2014mqtt]
- **Page / section:** MQTT 5.0 Sec. 2.2.2 (p. 25), Sec. 3.1.2.11 (CONNECT Properties, p. 34); MQTT 3.1.1 Sec. 6 (p. 65)
- **Evidence:** "The set of Properties is composed of a Property Length followed by the Properties." (MQTT 5.0, Sec. 2.2.2); "MQTT Control Packets MUST be sent in WebSocket binary data frames." (MQTT 3.1.1, Sec. 6)
- **Basis:** full text
- **Relevance:** extends — state the MQTT version configured in the client and accepted by Mosquitto; the additional Property Length byte for CONNECT/CONNACK/PUBLISH is field-size arithmetic, not a quoted blanket rule for all control packets.
- **Cite as (APA 7):** (Banks et al., 2019, Sec. 2.2.2); (Banks & Gupta, 2014, Sec. 6)
- **Verification (Task B, 2026-10-03):** ✘ CONNECT Properties section locator — MQTT 5.0 p. 34 labels it Sec. 3.1.2.11, not Keep Alive Sec. 3.1.2.10; corrected. Both quotes verified at p. 25 / MQTT 3.1.1 p. 65; 1 B empty-property length is packet-specific.

### F4: WebSocket frame header is 2–14 bytes; client-to-server frames always carry a 4-byte mask
- **Claim:** A WebSocket frame has a 2-byte base header; payload lengths of 126–65,535 bytes add 2 bytes, larger ones add 8 bytes, and every client-to-server frame adds a 4-byte masking key. For one unfragmented frame without extensions, payloads of 0–125 bytes cost 6 bytes of framing client→server or 2 bytes server→client; payloads of 126–65,535 bytes cost 8 or 4 bytes, respectively. Ping/Pong control frames (payload ≤ 125 bytes) can serve as a keep-alive.
- **Source:** [@fette2011websocket]
- **Page / section:** Sec. 5.2 (Base Framing Protocol); Sec. 5.5 and 5.5.2 (control frames, Ping); Sec. 1.2/4.1 (HTTP Upgrade opening handshake)
- **Evidence:** "All frames sent from the client to the server are masked by a 32-bit value that is contained within the frame." (Sec. 5.2); "A Ping frame may serve either as a keepalive or as a means to verify that the remote endpoint is still responsive." (Sec. 5.5.2)
- **Basis:** full text
- **Relevance:** supports — gives the expected per-message WebSocket overhead; direction of the data flow (masking) must be stated in the thesis. The byte totals (6/8/2/4) are this agent's arithmetic from the field sizes in Sec. 5.2.
- **Cite as (APA 7):** (Fette & Melnikov, 2011, Sec. 5.2)
- **Verification (Task B, 2026-10-03):** ✔ verified — official RFC 6455 retrieved and Secs. 5.2, 5.3, 5.5.2–5.5.3 read; both quotes, direction-dependent masking and 2/4/10 B base-plus-length framing verified. Formulas below checked independently.

### F5: HTTP/1.1 has no fixed header size; persistent connections are the default; long polling repeats full headers
- **Claim:** HTTP defines no universal fixed header size or protocol-wide maximum header size, so HTTP polling overhead depends on the client, server and serialized header set rather than a generic byte constant. HTTP/1.1 connections are persistent by default, so whether the polling client reuses the TCP connection decides if a TCP (and TLS) handshake is paid per poll or once. RFC 6202 names header overhead as a known issue of long polling.
- **Source:** [@fielding2022semantics]; [@fielding2022http11]; [@loreto2011known]
- **Page / section:** RFC 9110 Sec. 5.4; RFC 9112 Sec. 9.3; RFC 6202 Sec. 2.2
- **Evidence:** "HTTP/1.1 defaults to the use of \"persistent connections\", allowing multiple requests and responses to be carried over a single connection." (RFC 9112, Sec. 9.3); "For small, infrequent messages, the headers can represent a large percentage of the data transmitted." (RFC 6202, Sec. 2.2)
- **Basis:** full text
- **Relevance:** supports / method inspiration — the thesis must fix and report the exact HTTP header set and the connection-reuse policy (keep-alive vs. new connection per poll); these are the main confounders of HTTP overhead.
- **Cite as (APA 7):** (Fielding et al., 2022a, Sec. 5.4); (Fielding et al., 2022b, Sec. 9.3); (Loreto et al., 2011, Sec. 2.2)
- **Verification (Task B, 2026-10-03):** ✔ verified — local RFC 9110 Sec. 5.4 and RFC 9112 Sec. 9.3, plus official RFC 6202 Sec. 2.2 retrieved; both quotes/claims match. Persistence is a default, not proof the measured implementation reuses connections.

### F5b: Transport and TLS layers add their own per-segment/per-record and handshake overhead
- **Claim:** TCP uses a three-way connection handshake and a variable header length expressed by the Data Offset field in 32-bit words; optional TCP keep-alives must be switchable. Each protected TLS 1.3 record has a 5-byte outer header plus an encrypted inner content-type byte, optional padding and AEAD expansion. These framing mechanisms can be shared across all three selected protocols, but their packet/record counts, batching and handshake costs are workload- and implementation-dependent; the resulting byte totals need not be identical.
- **Source:** [@eddy2022tcp]; [@rescorla2018tls]
- **Page / section:** RFC 9293 Sec. 3.1, 3.5, 3.8.4; RFC 8446 Sec. 5.2
- **Evidence:** "The \"three-way handshake\" is the procedure used to establish a connection." (RFC 9293, Sec. 3.5)
- **Basis:** full text (relevant sections only; RFC 8446 handshake message sizes were not extracted — they depend on certificates and cipher suites)
- **Relevance:** method inspiration — the thesis' definition must say at which layer bytes are counted (frame, IP, TCP payload, application).
- **Cite as (APA 7):** (Eddy, 2022, Sec. 3.5); (Rescorla, 2018, Sec. 5.2)
- **Verification (Task B, 2026-10-03):** ✘ incomplete protected-record overhead / equal-total implication — RFC 8446 Sec. 5.2 includes encrypted inner content type and optional padding in addition to outer header/AEAD expansion; corrected, and common framing mechanisms distinguished from potentially different byte totals. TCP Secs. 3.1, 3.5, 3.8.4 checked.

### B. How empirical studies define and measure overhead

### F6: "Overhead" as ratio of total transferred bytes to message size, measured with Wireshark
- **Claim:** Thangavel et al. measure total bytes transferred per message with Wireshark — explicitly including protocol overhead and retransmissions — and use the ratio total data / message size as overhead indicator; the ratio is large for small messages because acknowledgements are comparable in size to the message. This is the inverse of the thesis' efficiency ratio and the earliest definition of this kind found.
- **Source:** [@thangavel2014performance]
- **Page / section:** UNVERIFIED in Task B: prior batch recorded pp. 3–5 (Secs. III–IV.C) from a Clemson-hosted copy; that copy is not stored locally, and the IEEE full text remains on the acquisition list.
- **Evidence:** UNVERIFIED prior-batch transcription: "The ratio of the total data transferred to the total message size is an indicator of the overheads involved in the data transfer."
- **Basis:** UNVERIFIABLE full-text-dependent finding in Task B; prior batch states a third-party full text was read, but no copy is available for this verifier. Retained provisionally, not cleared for page-level citation.
- **Relevance:** method inspiration — precedent for a ratio-based, capture-based overhead definition; covers only MQTT vs. CoAP.
- **Cite as (APA 7):** UNVERIFIED — use (Thangavel et al., 2014) provisionally; confirm the quotation/page against full text before thesis use.
- **Verification (Task B, 2026-10-03):** ✘ unverifiable — cited full text is absent from the main library and the Task A import; no page or quotation can be cleared in this audit. Prior transcription retained explicitly as UNVERIFIED; acquire the IEEE/legal author full text before thesis citation.

### F7: "Protocol efficiency" = useful bytes / total bytes, measured for six protocols incl. HTTP, MQTT and WebSocket on a Raspberry Pi 3
- **Claim:** Năstase et al. capture traffic of AMQP, CoAP, HTTP (REST), MQTT, WebSocket and XMPP with Wireshark between a Raspberry Pi 3 client and a PC server and report data bytes vs. total bytes, their ratio ("protocol efficiency", a term they attribute to their reference [4]), data vs. total packets and average packet size. WebSocket had the lowest totals (3,514 useful bytes in 9,800 total bytes, i.e. about 36 % — own calculation); XMPP had the lowest efficiency (28.11 %). Ratios for HTTP and MQTT are shown only in figures, not as numbers in the text.
- **Source:** [@nastase2017experimental]
- **Page / section:** p. 407 (metric definitions, hardware), p. 408 (payload, Wireshark), pp. 410–411 (results)
- **Evidence:** "Ratio between the useful bytes (i.e. actual information sent over the network) and the total number of bytes exchanged, also called protocol efficiency in [4]."
- **Basis:** full text
- **Relevance:** supports — closest precedent for the RQ4 efficiency ratio and for the protocol triple on Raspberry Pi hardware; see gaps (ten messages, protocol-specific message layout, no keep-alive/handshake breakdown, no TLS).
- **Cite as (APA 7):** (Năstase et al., 2017, p. 407)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 407–408, 410–411 / PDF pp. 5–6, 8–9; quote, six protocols, hardware and 3514/9800 B (35.86 %) / XMPP 28.11 % checked. Caution: source-defined useful bytes include more than ten × 212 B raw messages (2120 B); this unexplained numerator discrepancy prevents treating its ratio as identical to the proposed telemetry-payload metric.

### F8: HTTP vs. MQTT measured with Wireshark — 448 bytes vs. 113 bytes per transmission of a 39-byte payload
- **Claim:** Hong et al. send a 39-byte sensor string every 5 s from an ESP8266-based Arduino to an AWS server and report Wireshark data amounts: HTTP 448 B, HTTPS mean 1407.4 B, MQTT normally 113 B and mean 124.2 B including third/seventh-transmission ping outliers. Own payload-share arithmetic is 8.7 % for HTTP, 2.8 % for HTTPS, 34.5 % for the MQTT 113 B non-ping case, or 31.4 % for its 124.2 B mean. The source does not define the counted layers or handshake inclusion.
- **Source:** [@hong2023performance]
- **Page / section:** p. 12 (payload), p. 13 (method), p. 14 (results)
- **Evidence:** "Pings are sent regularly for the 3rd and 7th transmissions to check the connection with the broker server."
- **Basis:** full text
- **Relevance:** supports — only study read in which keep-alive traffic is visible in the per-message byte counts; n = 10 transmissions, no WebSocket. Hardware is a microcontroller, so it supports the method, not the platform.
- **Cite as (APA 7):** (Hong et al., 2023, p. 14)
- **Verification (Task B, 2026-10-03):** ✘ baseline/mean percentage basis mixed — original approximately 35 % MQTT share used 113 B whereas the mean is 124.2 B; both now labeled (34.5 % vs. 31.4 %). Printed pp. 12–15 / PDF pp. 4–7 verify payload, interval, byte figures, pings, dispersion and time cross-reference.

### F9: HTTP vs. MQTT traffic computed from a model, not captured
- **Claim:** Sasaki and Yokotani compare HTTP and MQTT traffic by summing assumed packet sizes along the message sequence: HTTP request and response are set to 300 bytes each with 0 bytes payload, MQTT packets use header sizes from a table (CONNECT 14, CONNACK 4, PUBLISH 6 + topic, PUBACK 4, SUBSCRIBE 7 + topic, SUBACK 5 bytes). After 30 communications MQTT traffic is about one fifth of HTTP. Wireshark is used in this paper only for access-delay measurement.
- **Source:** [@sasaki2019performance]
- **Page / section:** pp. 24–25 (Sec. 4.2–4.4, Table 1, Fig. 8); p. 26 (Sec. 5.2)
- **Evidence:** "Here, the size of HTTP request/response packets is set to 300 Bytes each."
- **Basis:** full text
- **Relevance:** contradicts as method / supports as result — the widely cited "HTTP has large overhead" result rests on an assumed HTTP size and on HTTP's per-request connection handling; the thesis measures instead of assuming.
- **Cite as (APA 7):** (Sasaki & Yokotani, 2019, pp. 24–25)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 24–26 / PDF pp. 4–6; 300 B HTTP assumptions, zero payload, MQTT Table 1 fields and about-one-fifth prose result checked. Wireshark access-delay use is distinct from traffic modeling.

### F10: Application-layer vs. captured exchange bytes: short-lived MQTT costs 1057–1560 B; TLS adds 952–3125 B in the stated cases
- **Claim:** Seoane et al. combine an analytical model with Wireshark captures (Raspberry Pi 3 testbed). They list MQTT message lengths both at application layer and on the wire assuming Ethernet (IEEE 802.3), IPv4 and TCP with timestamp option (e.g. CONNACK 4 vs. 70 bytes; PUBLISH 4 + topic + data vs. 70 + topic + data), and count TCP segments without data (SYN, FIN, ACKs). For a publisher that opens a TCP connection, connects, publishes once and closes, they measure 1,057 / 1,204 / 1,560 bytes for QoS 0 / 1 / 2 without loss; with TLS these rise to 2,009 / 2,280 / 2,713 bytes (PSK) and 3,978 / 4,281 / 4,685 bytes (certificates, PKI).
- **Source:** [@seoane2021performance]
- **Page / section:** p. 12 (Table 12, model assumptions), p. 13 (Table 13), p. 15 (measured bytes per message)
- **Evidence:** "For this calculation we have taken into account the TCP segments that do not contain any data (such as SYN and FIN), as well as the acknowledgements (ACK), which we have assumed are not delayed."
- **Basis:** full text
- **Relevance:** method inspiration — best template for a two-level definition (application-layer header bytes vs. bytes on the wire incl. TCP/IP/Ethernet and pure-ACK segments) and for reporting TLS separately; but one connection per message (worst case), no HTTP, no WebSocket, no long-lived session.
- **Cite as (APA 7):** (Seoane et al., 2021, pp. 12–15)
- **Verification (Task B, 2026-10-03):** ✘ title understated maximum TLS increment — zero-loss totals verified at p. 15, but PKI QoS 2 adds 4685−1560=3125 B, above the old approximately-2900 B ceiling. Tables 12–13 and quote checked at pp. 12–13; title corrected to the observed range.

### F11: Connection-establishment overhead counted in packets; MQTT pings deliberately excluded
- **Claim:** Kumar and Dezfouli define connection overhead as the number of packets exchanged during connection establishment (TCP handshake, TLS handshake, MQTT CONNECT) and report that MQTT over QUIC reduces it by up to 56.25 % relative to MQTT over TCP/TLS. Keep-alive pings are excluded from the evaluation.
- **Source:** [@kumar2019implementation]
- **Page / section:** Sec. IV-A (Overhead of Connection Establishment; Figs. 8–9, Table II) — arXiv v2, cited by section
- **Evidence:** "In addition, MQTT ping packets are excluded to simplify the evaluations."
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** supports the gap — shows that handshake overhead is a recognised metric, measured in packets rather than bytes, and that keep-alives are left out.
- **Cite as (APA 7):** (Kumar & Dezfouli, 2019, Sec. IV-A)
- **Verification (Task B, 2026-10-03):** ✔ verified — arXiv Sec. IV-A, PDF pp. 12–14; quotation at p. 13, packet-count definition and up-to-56.25 % Table II result checked. These are packets, not measured byte savings.

### F12: WebSocket vs. polling — overhead defined as HTTP headers / framing only; TCP explicitly excluded
- **Claim:** With a 30 B payload, Appelqvist and Örnmyr measured request/response HTTP headers of 281/191 B (XHR polling) and 273/191 B (long polling) via Firefox's network tool; their WebSocket framing is the specification-derived expected 2 B for server-to-client payloads <126 B, while SSE adds 8 B. TCP is excluded. The source p. 41 reports 1300 % more traffic for long polling versus SSE at 30 B, but 494/38 equals 1300 % of SSE traffic, i.e. 1200 % more. At 5000 B, its 5494 B long-poll total/9.7 % statement conflicts with 5000+464=5464 B; the consistent increase versus 5008 B SSE is 9.1 %. The qualitative conclusion that framing matters proportionally less for larger payloads is supported.
- **Source:** [@appelqvist2017performance]
- **Page / section:** pp. 7–8 (WebSocket framing analysis), p. 13 (exclusion of TCP overhead), p. 20 (Sec. 5.4, measured header sizes), p. 41 (payload dependence)
- **Evidence:** "The overhead data used by TCP is not considered as a performance factor in this study."
- **Basis:** full text (bachelor thesis, grey literature)
- **Relevance:** extends — concrete header-size figures for polling and a clear statement that efficiency ratios depend on payload size; its header-only definition is the counter-position to the wire-level definition in F10.
- **Cite as (APA 7):** (Appelqvist & Örnmyr, 2017, p. 20)
- **Verification (Task B, 2026-10-03):** ✘ source arithmetic and framing-measurement attribution — p. 20 header table is measured, WebSocket 2 B is expected from the specification; clarified. Printed p. 41 contains the 1300 %-more/5494 B/9.7 % errors; corrected arithmetic is 1200 % more at 30 B and 9.1 % at 5000 B. Exclusion quote verified at printed p. 13 / PDF p. 16.

### F13: Long polling messages about 300 bytes longer than socket-based messages
- **Claim:** Babovic et al. evaluate web protocols (WebSocket, long polling, HTTP streaming, sockets) for IoT applications mainly by latency, but note that long-polling messages were about 300 bytes longer than with the socket protocol in their Silverlight test and attribute WebSocket's latency advantage partly to long polling's header overhead.
- **Source:** [@babovic2016web]
- **Page / section:** p. 6986 (message sizes); p. 6985 (header overhead remark)
- **Evidence:** "We can also notice that message sizes for long-polling are approximately 300 bytes longer than with the socket protocol."
- **Basis:** full text
- **Relevance:** supports — independent, peer-reviewed order-of-magnitude figure for polling header overhead (consistent with F9 and F12); overhead is a side observation, not systematically measured.
- **Cite as (APA 7):** (Babovic et al., 2016, p. 6986)
- **Verification (Task B, 2026-10-03):** ✔ verified — main-library PDF pp. 12–13 = printed pp. 6985–6986; Silverlight socket/long-poll difference and separate HTML5 WebSocket header-overhead explanation read. Platform distinctions preserved.

### F14: MQTT over WebSocket costs more bytes than MQTT over TCP, mainly at connection establishment
- **Claim:** Enache et al. tabulate bytes for MQTT over TCP vs. MQTT over WebSocket without TLS: establish connection 512 vs. 1,161 bytes, subscription request 291 vs. 299, disconnect 334 vs. 418, a 256-byte QoS 1 publish 545 vs. 555 bytes. The extra cost is therefore dominated by the HTTP Upgrade handshake, while the per-message difference is about 10 bytes.
- **Source:** [@enache2023mqttws]
- **Page / section:** p. 48 (Table 5 and discussion)
- **Evidence:** "WebSockets consistently uses more data, which is largely due to the protocol's intrinsic overhead."
- **Basis:** full text — **secondary data**: the paper states that the measurements were performed by its references [8] (I. Craggs, a non-peer-reviewed source) and [13]; no own experiment, layer of byte counting not stated.
- **Relevance:** supports with caveat — only tabulated handshake-vs-message byte split found for WebSocket transport; weak evidence, should be cited cautiously and superseded by the thesis' own capture. Note: this is MQTT *tunnelled* in WebSocket, not a plain WebSocket application protocol as in the thesis.
- **Cite as (APA 7):** (Enache et al., 2023, p. 48)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 48 / PDF p. 3; all four Table 5 pairs and quotation match. Table labels [8] and discussion [8]/[13] confirm secondary data; original measurements and layer boundary remain unverified.

### F15: Qualitative ranking — HTTP highest, MQTT low header but TCP connection overhead
- **Claim:** Naik's comparison, based on the literature rather than own measurement, ranks HTTP highest in message size and overhead and lists header sizes of 2 bytes (MQTT), 4 bytes (CoAP), 8 bytes (AMQP) and "undefined" (HTTP); he stresses that MQTT's small header is offset by TCP connection overhead and that the ranking ignores retransmissions and dynamic network conditions.
- **Source:** [@naik2017choice]
- **Page / section:** Sec. III (Table I); Sec. IV-A (Message Size vs. Message Overhead) — author-accepted manuscript, cited by section
- **Evidence:** "MQTT is lightweight and has the least header size of 2-byte per message but its requirement of TCP connection increases the overall overhead"
- **Basis:** full text (author-accepted manuscript)
- **Relevance:** supports — frequently cited justification that header size alone is not the overhead; motivates the thesis' two-level metric. Not experimental.
- **Cite as (APA 7):** (Naik, 2017, Sec. IV-A)
- **Verification (Task B, 2026-10-03):** ✔ verified — accepted manuscript Sec. III Table I / Sec. IV-A, PDF pp. 3–4; qualitative ranking, 2/4/8/undefined header row, TCP-overhead quotation and retransmission caveat checked. This is a literature synthesis, not own measurement.

## Overhead definitions found (for justifying the thesis' own definition)

### Continuation findings — 2026-10-03

### F16: Captured frames can feed a metric that still excludes TCP retransmissions
- **Claim:** Proos and Carlsson capture MQTT traffic with Wireshark on a Raspberry Pi 3B over Ethernet. Their overhead sums link-layer frame sizes associated with application messages, subtracts the message size, and allocates heartbeat/failed-transfer traffic equally across messages. They nevertheless explicitly exclude transport retransmissions. This metric therefore does not represent all captured session bytes; no separate heartbeat breakdown is reported.
- **Source:** [@proos2020performance]
- **Page / section:** p. 13 (testbed); pp. 15–16, Sec. VI-A (overhead definition)
- **Evidence:** "these retransmissions are not captured by the application-level overhead metric."
- **Basis:** full text; existing PDF reread, printed pagination verified
- **Relevance:** method inspiration — specify included packet categories, even when the tool and starting unit are Wireshark and link-layer frames.
- **Cite as (APA 7):** (Proos & Carlsson, 2020, pp. 15–16)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 13, 15–16 / PDF pp. 4, 6–7; link-frame summation, heartbeat/failed-transfer allocation and explicit transport-retransmission exclusion match. Quote spans a PDF line break.

### F17: Ethernet capture bytes are not automatically physical-medium bytes
- **Claim:** Wireshark's Ethernet documentation explains that hardware removes the preamble and most interfaces do not supply the frame check sequence (FCS). A capture-based denominator must therefore identify its observed layer and FCS handling, rather than claim to count every byte transmitted on the physical medium. The stated Ethernet behaviour cannot be transferred to an arbitrary Wi-Fi capture without checking its link type.
- **Source:** [@wireshark2026ethernet]
- **Page / section:** "Packet format"; "Allowed Packet Lengths" (undated technical documentation)
- **Evidence:** "As the Ethernet hardware filters the preamble, it is not given to Wireshark or any other application."
- **Basis:** full text, primary tool documentation
- **Relevance:** method inspiration — label observed frame-byte or IP-byte totals precisely.
- **Cite as (APA 7):** (Wireshark, n.d., "Packet format")
- **Verification (Task B, 2026-10-03):** ✔ verified — official Wireshark Ethernet page retrieved; Packet format quote and FCS/preamble caveats match. No assertion about arbitrary Wi-Fi capture was inferred.

| Source | What is counted as overhead / efficiency | Layer | Handshake included | Keep-alive included | Capture tool |
|---|---|---|---|---|---|
| thangavel2014performance | UNVERIFIED prior-batch report: total bytes / message size | full-text basis unavailable in Task B | unverified | unverified | prior report: Wireshark |
| nastase2017experimental | source-defined useful bytes / total bytes; raw-message numerator mismatch unresolved | capture traffic (ACK, RST, FIN mentioned); precise byte layer unstated | inferred from documented session, not separately counted | not discussed | Wireshark |
| seoane2021performance | bytes and packets per message exchange; application-layer vs. on-wire length | Ethernet + IPv4 + TCP + MQTT, incl. data-less segments | yes (TCP, MQTT CONNECT, TLS) | no (one connection per message) | Wireshark |
| hong2023performance | "data amount" per transmission | undefined | undefined | visible as outliers (MQTT ping) | Wireshark |
| sasaki2019performance | sum of assumed packet sizes per communication | application layer, modelled | MQTT CONNECT/CONNACK yes; TCP not stated | no | none for traffic (model) |
| kumar2019implementation | number of packets during connection establishment | packets, all layers | yes (this is the metric) | explicitly excluded | not extracted |
| appelqvist2017performance | HTTP headers / framing bytes per message | application layer only; TCP explicitly excluded | no | no | browser network tool; server rx/tx counters |
| enache2023mqttws | bytes per phase (connect, subscribe, publish, disconnect) | not stated (secondary data) | yes, as separate row | no | not stated |
| naik2017choice | header size + qualitative "message overhead" | conceptual | conceptual (TCP connection overhead) | no | none |
| proos2020performance | link-layer frame sizes associated with application messages minus message size; transport retransmissions excluded | selected link-layer frames, not complete traffic | not specified as a separate category | heartbeat bytes distributed across messages | Wireshark on Pi 3B |

**Implication for the thesis (agent's suggestion, not from a source):** report two clearly separated metrics, as RQ4 already plans — (1) per-message protocol overhead at the application layer (bytes of MQTT/HTTP/WebSocket framing per payload, checked against F1–F5), and (2) session efficiency = useful application payload bytes / total observed traffic bytes for a whole capture, with the counted layer stated explicitly (e.g. IP packet length vs. observed Ethernet frame length). Break out connection setup, data, acknowledgements, keep-alives and teardown, using mutually exclusive classification rules to avoid double counting frames carrying data and TCP acknowledgements together. F16 shows why a capture tool alone does not establish the included traffic categories; F17 shows why observed frame bytes should not be equated with physical-medium bytes.

### Exact framing checks for the locked experiment — continuation 2026-10-03

These are the agent's arithmetic and proposed reporting conventions, not additional experimental scope or measured results. `P` is serialized payload length in bytes; `T` is MQTT topic length in UTF-8 bytes. All framing totals exclude TCP/IP, link-layer and TLS bytes.

| Protocol or exchange | Expected application-level overhead | Verified normative basis |
|---|---|---|
| MQTT 3.1.1 PUBLISH, one hop | `1 + v(P + 2 + T + I) + 2 + T + I`; `I=0` at QoS 0, `I=2` at QoS 1/2; `v(x)` is Remaining Length encoding size, 1–4 bytes | Banks & Gupta (2014), Secs. 1.5.3, 2.2.3, 3.3.2 |
| MQTT 3.1.1 acknowledgement exchange, one hop, no repeats | Add 0 bytes at QoS 0, 4 bytes for PUBACK at QoS 1, or 12 bytes for PUBREC/PUBREL/PUBCOMP at QoS 2, beyond the PUBLISH above | Banks & Gupta (2014), Secs. 3.4–3.7 |
| Native WebSocket, one unfragmented frame without extensions | Server→client: 2 / 4 / 10 bytes for `P≤125` / `126≤P≤65535` / `65536≤P≤2^63−1`; client→server adds 4 masking bytes | Fette & Melnikov (2011), Secs. 5.2–5.4 |
| WebSocket Ping plus corresponding Pong | `8 + 2K` bytes for identical control payload of `K≤125` bytes; 8 bytes if both are empty | Fette & Melnikov (2011), Secs. 5.2, 5.5.2–5.5.3; derived for one masked and one unmasked frame |
| HTTP/1.1 poll with bodyless request | Request start-line/fields/CRLF + response start-line/fields/CRLF + any transfer-coding framing; determine from the serialized exchange, not a generic header constant | Fielding et al. (2022b), Secs. 2.1 and 7.1; serialized fields and chunked-transfer framing read in Task B |

**Verification (Task B, 2026-10-03):** ✔ verified — all five formula-table rows checked against the stated normative fields; MQTT QoS 0/1/2 acknowledgment totals are 0/4/12 B, WebSocket Ping/Pong is `(6+K)+(2+K)=8+2K`. Formulas assume valid protocol lengths and a single hop/frame as stated; WebSocket's 64-bit length has its most significant bit zero. HTTP chunk framing was checked against RFC 9112 Sec. 7.1. The overhead-definition table was audited row by row; Thangavel remains unverifiable and unstated layers/categories are not promoted to explicit facts.

Example sanity checks: with `P=100` and `T=10`, MQTT 3.1.1 QoS 0 framing is 14 bytes; QoS 1 framing plus PUBACK is 20 bytes. Native WebSocket framing is 2 bytes server→client or 6 bytes client→server. These are illustrative derived values, not the thesis payload or an overall performance ranking. A payload change can also cross a length-encoding boundary: with `T=10`, MQTT QoS 0 grows from 14 to 15 framing bytes between `P=115` and `P=116`; WebSocket grows by two framing bytes between `P=125` and `P=126`.

For session efficiency, count each successfully delivered telemetry sample once in the useful-payload numerator, and include request, response, setup, teardown, pure ACK, keep-alive and repeat traffic in the selected network boundary's denominator. Document that boundary: observing sensor→broker only differs from observing both publisher→broker and broker→subscriber, where the same useful sample traverses two network legs. Native WebSocket is a separate application transport from MQTT-over-WebSocket (F14). Fix the WebSocket role/direction, negotiated extensions and fragmentation policy; record actual MQTT ping traffic and HTTP connection reuse. Dividing a fixed setup cost by the number of useful messages gives its amortized contribution without requiring a new RQ.

## Methodological gaps in related work
- **Protocol triple under one definition is rare.** Only [@nastase2017experimental] measures HTTP, MQTT and WebSocket in one capture-based setup; all other studies read cover pairs (HTTP–MQTT: [@hong2023performance], [@sasaki2019performance]; WebSocket–polling: [@appelqvist2017performance], [@babovic2016web]; MQTT–MQTT/WS: [@enache2023mqttws]; MQTT–CoAP: [@seoane2021performance], [@thangavel2014performance]).
- **Payload not held constant across protocols.** In [@nastase2017experimental] MQTT and CoAP split the message over four topics while WebSocket sends it in one piece (p. 411), so ratios are not strictly comparable; [@sasaki2019performance] uses 0 bytes payload and an assumed 300-byte HTTP size.
- **Limited dispersion reporting for byte counts.** Ten messages in [@nastase2017experimental] and [@hong2023performance]. The additional [@proos2020performance] distinguishes message-size cases and packet-loss settings, but its explicitly discussed 95% confidence intervals apply to latency (p. 15); those intervals must not be cited as overhead uncertainty.
- **Keep-alive breakdown missing in the reviewed sample.** [@proos2020performance] allocates heartbeat bytes across messages; [@hong2023performance] notices MQTT pings as outliers; [@kumar2019implementation] excludes them. None of these separately reports measured MQTT PINGREQ/PINGRESP, WebSocket Ping/Pong and TCP keep-alive byte contributions for the thesis' protocol triple.
- **No long-lived-session view.** Handshake cost is either folded into a single short exchange ([@seoane2021performance]: connect–publish–disconnect per message) or reported in isolation ([@kumar2019implementation], [@enache2023mqttws]); none provides measured session-efficiency convergence across the thesis protocol trio. Sasaki models traffic over up to 30 communications (F9), which is a message-count precedent, not a measured captured-session efficiency curve.
- **HTTP connection handling incompletely measured.** Appelqvist explicitly discusses persistence (printed pp. 8, 13) and expects 100 TCP connections for 100 clients at the first test's intervals (p. 23 / PDF p. 26); its per-header byte metric nevertheless excludes TCP and does not measure handshake amortisation. Năstase describes one HTTP client writing and another querying the PC server (p. 410), while Appelqvist studies browser polling of a server. These are polling/query precedents, but neither reverses the deployment into collector polling a smart-energy device under the thesis' matched conditions. Thus an absolute absence of polling or persistence discussion is unsupported.
- **Counting layer often unspecified.** [@hong2023performance] and [@enache2023mqttws] do not say whether bytes are frame, IP or application bytes; [@appelqvist2017performance] excludes TCP; [@seoane2021performance] gives explicit Ethernet/IPv4/TCP assumptions, and [@proos2020performance] starts from selected link-layer frames; a sole-source claim for explicit layers would be incorrect.
- **TLS only for MQTT/CoAP.** Byte cost of TLS is quantified for MQTT ([@seoane2021performance]) and loosely for HTTPS ([@hong2023performance]); nothing comparable was found for WebSocket Secure, and no study compares all three protocols with and without TLS.
- **Model-based or secondary numbers circulate as measurements.** [@sasaki2019performance] computes traffic from assumed sizes; [@enache2023mqttws] reproduces figures from a non-peer-reviewed source; [@naik2017choice] is qualitative.
- **Platform.** Raspberry Pi appears as client/gateway in [@nastase2017experimental] (Pi 3) and [@seoane2021performance] (Pi 3), but none combines overhead with latency, CPU/RAM and payload format in the same experiment — which is the thesis' novelty argument.

## PDF page offsets
| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| sasaki2019performance | 21 (journal pp. 21–29) |
| hong2023performance | 9 (journal pp. 9–17) |
| seoane2021performance | 1 (article no. 108338, pages 1–22; offset 0) |
| nastase2017experimental | 403 (journal pp. 403–412) |
| babovic2016web | 6974 (journal pp. 6974–6992); Task B checked main-library PDF pp. 12–13 = printed pp. 6985–6986 |
| enache2023mqttws | 46 (journal pp. 46–49) |
| appelqvist2017performance | printed p. 1 = PDF page 4 (PDF page = printed + 3; front matter unnumbered/roman) |
| thangavel2014performance | UNVERIFIED; no locally available full text in Task B; old 1–6 offset not cleared |
| banks2014mqtt | 1 (PDF "Page n of 81"; offset 0) — cite by section |
| banks2019mqtt | 1 (PDF "Page n of 137"; offset 0) — cite by section |
| kumar2019implementation | arXiv v2 pagination 1–19 ≠ journal pp. 28–45 — cite by section |
| naik2017choice | author-accepted manuscript without printed page numbers — cite by section |
| proos2020performance | 10 (printed pp. 10–18; PDF page = printed page − 9), verified on extracted pages 1, 4, 6–7 |
| wireshark2026ethernet | undated web documentation — cite heading; accessed 2026-10-03 |
| fette2011websocket, rescorla2018tls, loreto2011known | plain-text RFCs — cite by section |
| fielding2022semantics, fielding2022http11, eddy2022tcp | RFC PDFs — cite by section |

## Cross-references (for other RQs)
- [RQ1] `seoane2021performance` — delay of MQTT QoS 0–2 with/without TLS under packet loss (already used by lit-rq1).
- [RQ1] `babovic2016web` — latency of WebSocket vs. long polling vs. HTTP streaming (already used by lit-rq1).
- [RQ1] `nastase2017experimental` — RTT per protocol on Raspberry Pi 3 (p. 411: MQTT 0.448 ms, XMPP 0.373 ms, AMQP 90.75 ms).
- [RQ1] `hong2023performance` — transfer time HTTP ≈ 0.169 s, HTTPS ≈ 2.211 s, MQTT ≈ 0.0197 s mean (p. 15), ESP8266 client.
- [RQ1] `sasaki2019performance` — access delay HTTP vs. MQTT measured with Raspberry Pi and Wireshark (p. 26).
- [RQ2] Gavriilidis, Halkidis & Petridou (2025), "Empirical Evaluation of TLS-Enhanced MQTT on IoT Devices for V2X Use Cases", Applied Sciences, DOI 10.3390/app15158398 — TLS 1.3 "overhead" for MQTT on Raspberry Pi 4B measured as CPU cycles, time, energy and memory (screened in full text, not included for RQ4, no bib entry).
- [RQ2] Van de Vyvere, Colpaert & Verborgh (2020), "Comparing a Polling and Push-Based Approach for Live Open Data Interfaces", DOI 10.1007/978-3-030-50578-3_7 — server CPU/memory of HTTP polling vs. Server-Sent Events (screened, not included; PDF `vandevyvere2020comparing.pdf` already present from another agent).
- [RQ2] `appelqvist2017performance` — server CPU and memory of XHR polling, long polling, SSE and WebSockets.
- [RQ3] `babovic2016web` — message size and encode/decode time of XML, JSON and binary encodings (p. 6986 ff.).
- [RQ3] `appelqvist2017performance` p. 41 and F12 — efficiency ratio depends strongly on payload size; relevant when JSON vs. CBOR/Protobuf changes the payload while headers stay constant.
- [Related work] `naik2017choice` — qualitative protocol comparison (already used by lit-rq1 / lit-related-work).
- [RQ1, acquisition reconciliation 2026-10-03] `pimentel2012communicating` — complete full text now available locally and read by lit-rq1; see RQ1 findings F10/F35. Removed from RQ4's outstanding acquisition list; no independent RQ4 finding added from this recovered copy.

## Open questions
- **Origin of "protocol efficiency" — partially resolved in continuation.** Năstase et al. (2017, p. 407) attribute the term to reference [4]; their printed p. 412 confirms this is Mijovic, Shehu and Buratti (2016). The attribution is verified, but the original paper's precise numerator, denominator and measured layers remain UNVERIFIED without its full text; cite Năstase directly for the definition actually read.
- **Thangavel et al. page numbers/quotes remain UNVERIFIED after Task B.** No local full text was available; F6 and its table row are provisional until Felix supplies a legal full text.
- **Hong et al. (2023) DOI** (10.7236/IJASC.2023.12.1.9) is printed in the PDF and resolves at doi.org but is not in Crossref; **Sasaki & Yokotani (2019)** has no DOI that could be found.
- **Enache et al. (2023) Table 5** reproduces third-party figures; the original source (I. Craggs) was not retrieved. Decide whether to cite at all.
- **RFC 8446 handshake byte sizes** were not extracted (certificate- and cipher-dependent); if the thesis runs TLS, the handshake size has to come from the own capture. Whether TLS is in scope for RQ4 is not fixed in `docs/methodology.md` — Felix to decide.
- **Semantic Scholar was unavailable** (HTTP 429 on all but two queries, API shared with parallel agents); IEEE Xplore and ACM DL were not searched directly. Coverage relies on Crossref, arXiv, OpenAlex, web search and snowballing — a re-run of the four logged-as-failed Semantic Scholar queries is advisable.
- **Existing RQ4 sources** (Sarafov 2018; Muller 2014, arXiv:1409.3367; IJRASET 2026) are outside this findings file's audit; their Task A evidence/status is handled in `existing-sources.md` and the central verification report.
- The reviewed sample has no separate keep-alive breakdown and session-length amortisation for all three thesis protocols with identical payloads. Proos and Carlsson do account for heartbeat bytes in an aggregate metric. A broader targeted IEEE Xplore search remains advisable before making any universal absence claim.

## Continuation status — 2026-10-03
- Added one empirical full text from the existing library (`proos2020performance`) and one primary tool-documentation source (`wireshark2026ethernet`); no new PDFs downloaded, no new acquisition item.
- Confirmed Năstase's reference [4] by reading printed p. 412. Retried legal Mijovic retrieval: university record visible in search, direct retrieval returns HTTP 403; full text still unavailable.
- Crossref exact-title lookup for Proos returned three unrelated records, so no DOI is assigned. Title/authors/ISBN/pagination are confirmed from the full text and author/IFIP pages; DOI absence is a lookup result, not proof that no identifier exists.
- Prior evidence is retained. Corrected the overstrong MQTT statement that pings occur only during publishing gaps, qualified MQTT 5.0 Properties overhead, and narrowed the keep-alive gap after reading the additional evidence.
