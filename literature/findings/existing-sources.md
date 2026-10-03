# Findings — Existing sources (verification, Tasks A and B)

Agent: lit-verifier · Last updated: 2026-10-03

## Summary
Seven sources from `literature/sources-existing.md` were resolved; full text was read for five of them (three PDFs with printed pagination, one arXiv preprint cited by section, one journal article read as publisher XML and cited by section). At Task A, two sources (`bayilmis2022survey`, `viswanathan2017analysis`) could not be read. Task B obtained and checked the Bayılmış publisher PDF; its experimental findings are recorded in `related-work.md` F22. Viswanathan remains abstract-only. For RQ4, `sarafov2018comparison` is the strongest existing source: an analytical L4–L7 overhead model for WebSocket, CoAP and MQTT validated on a Raspberry Pi with Wireshark and netem, but without HTTP polling, TLS or keep-alives. `muller2014websocket` gives only second-hand overhead figures for HTTP polling and WebSocket framing. The three sources listed under RQ3 that could be identified contain almost nothing on payload serialization formats (no CBOR, no Protocol Buffers): two are about power consumption (RQ2-adjacent) and one is a general protocol survey. `mishra2026performance` (IJRASET) has severe quality problems and should not carry any argument in the thesis.

Task B rechecked all 25 findings against their local PDF or publisher XML. Verification establishes what the source reports, not the reliability of its results. Source simplifications and defects remain explicit; line-break hyphens and XML reference spacing are normalised.

## Findings

### Source: sarafov2018comparison — assigned RQ4 (protocol overhead)
Sarafov, V. (2018). Comparison of IoT Data Protocol Overhead. TUM seminar proceedings NET-2018-03-1, pp. 7–14. Student seminar paper, not peer-reviewed.

#### S1-F1: Overhead model separates handshake cost from per-message header cost
- **Verification (Task B, 2026-10-03):** ✔ verified — Eq. 3 and L4–L7 assumptions read on printed pp. 8–9 (PDF 2–3); source uses efficiency as its throughput definition.
- **Claim:** Protocol overhead is modelled from the transport layer upwards as opening handshake + closing handshake + n × per-message header, ω(n) := bH_o + bH_c + nh (Eq. 3); lower layers (L1–L3) are treated as identical for all protocols and excluded.
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 9 (Eq. 3; assumptions on p. 8)
- **Evidence:** "Hence the actual data protocol overhead for n communication slots is given by the overhead sum between Layer 4 and Layer 7"
- **Basis:** full text
- **Relevance:** method inspiration — same decomposition as RQ4 (per-message headers vs. full connection incl. handshakes); also defines throughput τ = D_app / D_total (Eq. 4), which corresponds to the thesis' efficiency ratio.
- **Cite as (APA 7):** (Sarafov, 2018, p. 9)

#### S1-F2: WebSocket overhead ≈ 600 + 54n bytes
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 9–10 (PDF 3–4), Eq. 5/Table 2 and quotation; approximation applies to the stated model.
- **Claim:** For an unencrypted WebSocket connection the estimated overhead is about 600 bytes of fixed handshake cost (TCP + HTTP upgrade opening, WebSocket + TCP closing) plus 54 bytes per message (Eq. 5; model values H_o ≈ 430, H_c = 168, h = 54 in Table 2 on p. 10).
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 9 (Eq. 5); Table 2 on p. 10
- **Evidence:** "A good approximation is ≈ 310 Bytes (Client side ≈ 170 Bytes, Server side ≈ 140 Bytes)." (size of the WebSocket opening handshake)
- **Basis:** full text
- **Relevance:** supports — concrete expected values to compare the thesis' Wireshark/tcpdump measurements against.
- **Cite as (APA 7):** (Sarafov, 2018, p. 9)

#### S1-F3: MQTT overhead between 300 + 42n (QoS 0) and 300 + 174n (QoS 2) bytes
- **Verification (Task B, 2026-10-03):** ✘ corrected — pp. 11–12 (PDF 5–6) confirm the reported model values and quote, but the fixed two-byte statement is a source simplification; relevance now distinguishes model totals from normative MQTT framing.
- **Claim:** For a publishing MQTT connection without TLS/authentication the estimated overhead is about 300 bytes of handshake cost plus 42 (QoS 0), 86 (QoS 1) or 174 (QoS 2) bytes per message, including TCP segment/ACK cost (Table 4 on p. 11; Eq. 7 on p. 12).
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 11 (Table 4, header size); p. 12 (Eq. 7)
- **Evidence:** "The MQTT fixed header is exactly 2 Bytes long"
- **Basis:** full text
- **Relevance:** supports — within this simplified model, MQTT per-message cost is lower than WebSocket's 54 bytes only at QoS 0; these are L4–L7 model totals, not normative protocol-header sizes. MQTT Remaining Length is variable-length and PUBLISH overhead also depends on the topic and QoS. Fix and report QoS and actual framing in RQ4.
- **Cite as (APA 7):** (Sarafov, 2018, pp. 11–12)

#### S1-F4: Validation setup uses Raspberry Pi client, Wireshark byte counts and netem packet loss
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 12 (PDF 6), Sec. 4.1 and Fig. 6; WiFi, Pi/laptop, Wireshark and client-side 20% netem loss.
- **Claim:** The model was validated in a local WiFi network with a Raspberry Pi as client and a laptop as server; total bytes per run were measured with Wireshark, and packet loss (20 %) was emulated with netem on the client.
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 12 (Sec. 4.1)
- **Evidence:** "The total amount of bytes for each execution was measured with Wireshark [6]."
- **Basis:** full text
- **Relevance:** method inspiration — precedent for the thesis' measurement method (Wireshark/tcpdump on a Raspberry Pi; netem instead of physical disturbance, cf. optional RQ5).
- **Cite as (APA 7):** (Sarafov, 2018, p. 12)

#### S1-F5: Handshake cost dominates short connections; efficiency rises with payload size
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 13 (PDF 7), Sec. 4.2; text explicitly reports 15 slots and 29% to 77%.
- **Claim:** Without packet loss, MQTT and WebSocket start with low throughput (efficiency) because of handshake costs and overtake confirmable CoAP after roughly 15 messages; raising the average payload from 64 to 512 bytes more than doubles efficiency for all protocols (MQTT QoS 0: 29 % → 77 %). WebSocket and MQTT QoS 0 end up almost equal.
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 13 (Sec. 4.2)
- **Evidence:** "MQTT with QoS 0 improves its throughput from 29% to 77%."
- **Basis:** full text
- **Relevance:** supports — efficiency ratio depends strongly on payload size and number of messages per connection; both must be controlled variables in RQ4 (and link RQ4 to RQ3).
- **Cite as (APA 7):** (Sarafov, 2018, p. 13)

#### S1-F6: TLS, proxies and caching are explicitly left out
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 13 (PDF 7), Sec. 5; security and cache/proxy limitations explicitly stated.
- **Claim:** The author names the omission of TLS/DTLS as a major limitation of the model; proxy and cache effects are also excluded.
- **Source:** [@sarafov2018comparison]
- **Page / section:** p. 13 (Sec. 5)
- **Evidence:** "Not considering TLS securing for WebSocket and MQTT and DTLS securing for CoAP is a huge drawback"
- **Basis:** full text
- **Relevance:** extends — the thesis can state explicitly whether TLS is in or out of scope and why.
- **Cite as (APA 7):** (Sarafov, 2018, p. 13)

### Source: muller2014websocket — assigned RQ4 (protocol overhead)
Muller, G. L. (2014). HTML5 WebSocket protocol and its application to distributed computing. MSc thesis, Cranfield University (arXiv:1409.3367). Not peer-reviewed; the overhead figures are quoted from secondary/web sources.

#### S2-F1: HTTP polling can produce responses without new data
- **Verification (Task B, 2026-10-03):** ✘ corrected — printed p. 4 (PDF 14) and quote confirmed; removed implication that each polling request necessarily opens another connection.
- **Claim:** Muller describes periodic polling requests that can receive empty responses when no new data is available, adding traffic. His reference to unnecessary connections is implementation-dependent: an HTTP polling exchange does not necessarily establish a new TCP connection, and responses may repeat the current value instead of being empty.
- **Source:** [@muller2014websocket]
- **Page / section:** p. 4 (Sec. 1.1.3)
- **Evidence:** "even if no data is available, the server will send an empty response."
- **Basis:** full text
- **Relevance:** supports — qualitative argument for the expected overhead disadvantage of HTTP polling in RQ4.
- **Cite as (APA 7):** (Muller, 2014, p. 4)

#### S2-F2: HTTP request/response headers of at least 871 bytes per exchange (second-hand figure)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 7 (PDF 17); 871-byte figure is a cited example, not a protocol minimum.
- **Claim:** The thesis reports a total HTTP request + response header overhead of at least 871 bytes without payload, versus a small payload of 20 bytes; the figure is taken from the thesis' reference [2], not measured by the author.
- **Source:** [@muller2014websocket]
- **Page / section:** p. 7 (Sec. 1.1.6)
- **Evidence:** "The total overhead from the HTTP request and response header is at least 871 bytes without containing any data."
- **Basis:** full text
- **Relevance:** supports — but browser-era, second-hand number; an IoT client with minimal headers will differ. Use only as illustration and measure own values.
- **Cite as (APA 7):** (Muller, 2014, p. 7)

#### S2-F3: WebSocket requires an HTTP upgrade handshake before data frames
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 8 (PDF 18), Sec. 1.2.2; HTTP Upgrade description and quotation confirmed.
- **Claim:** A WebSocket connection starts with an HTTP request carrying an Upgrade header; only after this handshake can either side send frames.
- **Source:** [@muller2014websocket]
- **Page / section:** p. 8 (Sec. 1.2.2)
- **Evidence:** "Before a Websocket communication can start, a HTTP connection must be initiated."
- **Basis:** full text
- **Relevance:** supports — handshake must be counted in the "full connection" overhead of RQ4. Prefer RFC 6455 as the primary citation.
- **Cite as (APA 7):** (Muller, 2014, p. 8)

#### S2-F4: WebSocket per-frame overhead figures are inconsistent within the thesis
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 9–10 (PDF 19–20); inconsistent 4–12 and 8–20-byte source figures retained as a defect.
- **Claim:** The thesis states a frame prefix of "4-12 bytes" on p. 9 and, citing a blog post by Oberstein, an overhead "between 8 and 20 bytes" on p. 10. The two figures do not agree and neither is derived from the specification.
- **Source:** [@muller2014websocket]
- **Page / section:** p. 9 (Sec. 1.2.2) and p. 10 (Sec. 1.2.4)
- **Evidence:** "depending on the size of the payload the overhead varies between 8 and 20 bytes."
- **Basis:** full text
- **Relevance:** contradicts (itself) — do not cite these numbers for frame sizes; take header sizes from RFC 6455 and from the thesis' own captures.
- **Cite as (APA 7):** (Muller, 2014, pp. 9–10)

### Source: dizdarevic2019survey — assigned RQ3 (payload formats)
Dizdarević, J., Carpio, F., Jukan, A., & Masip-Bruin, X. (2019). ACM Computing Surveys, 51(6). Read: arXiv preprint v2 (no final pagination → cited by section).

#### S3-F1: REST/HTTP does not prescribe a data format; JSON is the de-facto IoT default
- **Verification (Task B, 2026-10-03):** ✔ verified — preprint Sec. 3.1 (PDF 7); quotation and JSON/XML discussion checked; final ACM pagination remains unavailable.
- **Claim:** In REST over HTTP the representation format is arbitrary, JSON and XML being most common, and IoT practice has largely converged on JSON over HTTP.
- **Source:** [@dizdarevic2019survey]
- **Page / section:** Sec. 3.1
- **Evidence:** "In most cases, IoT standardizes around JSON over HTTP."
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** supports — justifies JSON as the baseline payload format in RQ3.
- **Cite as (APA 7):** (Dizdarević et al., 2019, Sec. 3.1)

#### S3-F2: Verbose text encodings (XML) are a bandwidth problem in constrained networks
- **Verification (Task B, 2026-10-03):** ✔ verified — preprint Sec. 3.6 (PDF 14); statement is specifically about XMPP/XML.
- **Claim:** XMPP's XML-based messages are considered too large for bandwidth-constrained networks, and the lack of an efficient binary encoding is named as a reason for its poor fit to lossy low-power networks.
- **Source:** [@dizdarevic2019survey]
- **Page / section:** Sec. 3.6
- **Evidence:** "By using XML, the size of the messages makes it inconvenient in the networks with bandwidth constraints."
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** supports — general motivation for compact/binary payload encodings (RQ3); note the statement is about XML, not JSON.
- **Cite as (APA 7):** (Dizdarević et al., 2019, Sec. 3.6)

#### S3-F3: Binary-encoded protocol headers reduce overhead (CoAP)
- **Verification (Task B, 2026-10-03):** ✔ verified — preprint Sec. 3.2 (PDF 8); binary protocol headers are distinguished from payload encoding.
- **Claim:** CoAP encodes headers, methods and status codes in binary form, which the survey credits with lower protocol overhead compared with many other protocols.
- **Source:** [@dizdarevic2019survey]
- **Page / section:** Sec. 3.2
- **Evidence:** "the headers, methods and status codes are all binary encoded, thus reducing the protocol overhead"
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** extends — concerns header encoding (RQ4), not payload serialization; useful only as an analogy for RQ3.
- **Cite as (APA 7):** (Dizdarević et al., 2019, Sec. 3.2)

#### S3-F4: Bandwidth ranking of protocols depends on payload size
- **Verification (Task B, 2026-10-03):** ✔ verified — preprint Sec. 4.2 (PDF 16); payload-dependent ranking is a secondary report of ref. 107.
- **Claim:** In a surveyed IoT-to-cloud study comparing MQTT, CoAP and REST HTTP, bandwidth results depended heavily on payload size: CoAP used least for small payloads, while REST HTTP performed best for larger payloads.
- **Source:** [@dizdarevic2019survey]
- **Page / section:** Sec. 4.2
- **Evidence:** "the results heavily depended on the size of the payloads that were being transferred."
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** supports — payload size (and hence serialization format) interacts with protocol choice; links RQ3 and RQ4. This is a secondary report of another study (the survey's ref. [107]).
- **Cite as (APA 7):** (Dizdarević et al., 2019, Sec. 4.2)

#### S3-F5: WebSockets are excluded from the survey
- **Verification (Task B, 2026-10-03):** ✔ verified — preprint Sec. 2.2 (PDF 6); exclusion and rationale are the survey authors' scope decision, not a current suitability conclusion.
- **Claim:** The survey explicitly leaves WebSockets (and QUIC) out of scope, arguing that WebSocket is not designed for resource-constrained devices.
- **Source:** [@dizdarevic2019survey]
- **Page / section:** Sec. 2.2
- **Evidence:** "WebSockets and QUIC are out of the scope in this survey."
- **Basis:** full text (arXiv preprint v2)
- **Relevance:** supports — documents a gap in a highly cited survey that the thesis' three-protocol comparison (incl. WebSockets) addresses.
- **Cite as (APA 7):** (Dizdarević et al., 2019, Sec. 2.2)

### Source: jaraochoa2023power — assigned RQ3 (payload formats); content fits RQ2 (resources/energy) instead
Jara Ochoa, H. J., Peña, R., Ledo Mezquita, Y., Gonzalez, E., & Camacho-Leon, S. (2023). Sensors, 23(10), 4896. Read: publisher full-text XML via Europe PMC (PMC10224120) → cited by section; page numbers UNVERIFIED (PDF not obtained). The article contains no comparison of payload serialization formats.

#### S4-F1: MQTT saves 6.03 % (QoS 0) and 8.33 % (QoS 1) average power versus HTTP
- **Verification (Task B, 2026-10-03):** ✔ verified — publisher XML Sec. 6.1, Tables 2–3/Eqs. 2–3; savings are as reported. HTTP average conflicts between prose (667.33 mW) and table/equations (670.16 mW); no PDF page claimed.
- **Claim:** On a NodeMCU-based monitoring platform, average power of the complete system was lower with MQTT than with HTTP, corresponding to savings of 6.03 % (QoS 0) and 8.33 % (QoS 1).
- **Source:** [@jaraochoa2023power]
- **Page / section:** Sec. 6.1 (page UNVERIFIED — XML full text has no pagination)
- **Evidence:** "there are power consumption savings in the MQTT cases of 6.03% (QoS 0) and 8.33% (QoS 1) with respect to HTTP."
- **Basis:** full text (JATS XML)
- **Relevance:** extends — energy, not payload format; relevant as background for RQ2 (resource consumption) rather than RQ3.
- **Cite as (APA 7):** (Jara Ochoa et al., 2023, Sec. 6.1)

#### S4-F2: With only the microcontroller powered, protocol choice makes no significant difference
- **Verification (Task B, 2026-10-03):** ✔ verified — publisher XML Sec. 6.1; nearly equal means and author quotation confirmed. This is not evidence of a formal significance test or Pi CPU/RAM results.
- **Claim:** Measured without sensors, display and memory, the average power was nearly identical for HTTP, MQTT QoS 0 and MQTT QoS 1.
- **Source:** [@jaraochoa2023power]
- **Page / section:** Sec. 6.1 (page UNVERIFIED)
- **Evidence:** "It can be declared that there are no significant differences between these cases when energizing only the microcontroller."
- **Basis:** full text (JATS XML)
- **Relevance:** extends — protocol effects on resource use can be small relative to the base load; relevant when interpreting RQ2 CPU/RAM differences.
- **Cite as (APA 7):** (Jara Ochoa et al., 2023, Sec. 6.1)

#### S4-F3: Measurement design — 100 samples at 1.5 s per test, three tests per configuration
- **Verification (Task B, 2026-10-03):** ✔ verified — XML Sec. 4.5/6.1; 100 samples, 1.5 s spacing, 150 s and three tests per configuration checked.
- **Claim:** Each test recorded 100 voltage/current/power readings at 1.5 s intervals (150 s per test) with an NI myDAQ and LabVIEW; three tests were run per protocol configuration.
- **Source:** [@jaraochoa2023power]
- **Page / section:** Sec. 4.5 (test count: Sec. 6.1) (page UNVERIFIED)
- **Evidence:** "The time between each iteration is 1.5 s, so for each test, 150 s (2.5 min) is required."
- **Basis:** full text (JATS XML)
- **Relevance:** method inspiration — example of a small-sample measurement design; the thesis' psutil sampling should be longer and state repetitions explicitly.
- **Cite as (APA 7):** (Jara Ochoa et al., 2023, Sec. 4.5)

#### S4-F4: Authors attribute MQTT's advantage to header size, without measuring it
- **Verification (Task B, 2026-10-03):** ✘ corrected — XML Sec. 7 supports only the authors' tentative explanation. Quote shortened to a literal excerpt; claim now avoids a universal HTTP concurrency assertion.
- **Claim:** The authors tentatively attribute lower MQTT power draw to header size and describe HTTP as handling one request at a time; message/header sizes were not measured. This is their proposed explanation, not a demonstrated universal restriction of HTTP.
- **Source:** [@jaraochoa2023power]
- **Page / section:** Sec. 7 (page UNVERIFIED)
- **Evidence:** "The above seems to be related to the size of the payload header format"
- **Basis:** full text (JATS XML)
- **Relevance:** supports the novelty argument — energy and overhead are linked only by assumption here, not measured in one experiment.
- **Cite as (APA 7):** (Jara Ochoa et al., 2023, Sec. 7)

#### S4-F5: No latency/speed analysis
- **Verification (Task B, 2026-10-03):** ✔ verified — XML Sec. 7 explicitly states no speed analysis; no page inferred.
- **Claim:** The authors state as a limitation that the speed of the system (i.e. latency/throughput) was not analysed.
- **Source:** [@jaraochoa2023power]
- **Page / section:** Sec. 7 (page UNVERIFIED)
- **Evidence:** "A limitation of this article is that no analysis of how fast any system can work was carried out."
- **Basis:** full text (JATS XML)
- **Relevance:** supports the novelty argument — single metric dimension (power) only.
- **Cite as (APA 7):** (Jara Ochoa et al., 2023, Sec. 7)

### Source: mishra2026performance — assigned RQ4 (protocol overhead) — NOT RECOMMENDED (see verification report)
Mishra, M., & Guru, S. (2026). IJRASET, 14(2), 883–890. Findings are recorded to document what the paper claims and why it is unreliable, not as evidence for the thesis.

#### S5-F1: Reported "bandwidth overhead": MQTT 124, CoAP 88, HTTP 536 bytes (NS-3 simulation)
- **Verification (Task B, 2026-10-03):** ✔ verified as a source defect — printed pp. 885/887/888 (PDF 4/6/7); units mismatch and 124/88/536-byte table values confirmed, not endorsed.
- **Claim:** In an NS-3 simulation with 1024-byte payloads the paper reports overhead of 124 bytes (MQTT), 88 bytes (CoAP) and 536 bytes (HTTP) per packet (Table 2, p. 887). The metric is defined on p. 885 as a ratio of headers to payload but reported in bytes; how it was computed is not explained.
- **Source:** [@mishra2026performance]
- **Page / section:** p. 885 (definition), p. 887 (Table 2), p. 888 (quote)
- **Evidence:** "the high overhead of HTTP (536 bytes per packet) directly correlates with its total failure (100% packet loss)"
- **Basis:** full text
- **Relevance:** supports in direction only (HTTP > MQTT overhead) — values are not reproducible and should not be cited as reference numbers.
- **Cite as (APA 7):** (Mishra & Guru, 2026, p. 887)

#### S5-F2: Simulation parameters contain unfilled template placeholders
- **Verification (Task B, 2026-10-03):** ✔ verified as a source defect — printed p. 885 (PDF 4), Table 1 contains node/time placeholders; peer-review process is not inferred from them.
- **Claim:** Table 1 (simulation parameters) lists node density and simulation time as placeholder text instead of values, so the experiment is not specified.
- **Source:** [@mishra2026performance]
- **Page / section:** p. 885 (Table 1)
- **Evidence:** "[Insert Number, e.g., 20 Nodes]"
- **Basis:** full text
- **Relevance:** contradicts (credibility) — direct evidence of incomplete reporting; the editorial/peer-review process itself has not been independently established.
- **Cite as (APA 7):** (Mishra & Guru, 2026, p. 885)

#### S5-F3: Implausible headline result — HTTP delivers 0 % of packets at 500 iterations
- **Verification (Task B, 2026-10-03):** ✔ verified as a source defect — printed p. 887 (PDF 6), Table 2 reports HTTP 0% PDR against MQTT/CoAP 100%; insufficient explanation retained.
- **Claim:** The paper reports that HTTP has 0 % packet delivery ratio and 100 % packet loss at the 500-iteration load while MQTT and CoAP deliver 100 %; no explanation beyond "TCP-induced network saturation" is given, although MQTT runs over the same TCP.
- **Source:** [@mishra2026performance]
- **Page / section:** p. 887 (Table 2 and summary)
- **Evidence:** "resulting in a 0% PDR and 100% packet loss"
- **Basis:** full text
- **Relevance:** contradicts — not usable as evidence for RQ1/RQ4.
- **Cite as (APA 7):** (Mishra & Guru, 2026, p. 887)

#### S5-F4: Simulation only; hardware validation named as future work
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 889 (PDF 8), Sec. VII.B; hardware validation is future work, not a completed measurement.
- **Claim:** The study is purely simulated; the authors name validation on physical hardware such as Raspberry Pi and ESP32 as future work.
- **Source:** [@mishra2026performance]
- **Page / section:** p. 889 (Sec. VII.B)
- **Evidence:** "Although this study was conducted in a simulated network environment"
- **Basis:** full text
- **Relevance:** supports the novelty argument only weakly (gap statement from an unreliable venue; better taken from a reputable source).
- **Cite as (APA 7):** (Mishra & Guru, 2026, p. 889)

#### S5-F5: Reference list contains at least one incorrect citation
- **Verification (Task B, 2026-10-03):** ✘ corrected — printed p. 890 (PDF 9), ref. 9 and DOI 10.1145/3292674 checked; nested overlong evidence quotation replaced with a short literal author excerpt. Incorrect source metadata remain flagged.
- **Claim:** Reference [9] attributes a Dizdarević survey to co-authors "F. Guzman, B. Salazar and R. Mariano" in "Ad Hoc Networks, vol. 88"; the verified Dizdarević survey (Crossref, DOI 10.1145/3292674) has the co-authors Carpio, Jukan and Masip-Bruin and appeared in ACM Computing Surveys 51(6). The remaining references were not checked.
- **Source:** [@mishra2026performance]
- **Page / section:** p. 890 (ref. [9])
- **Evidence:** "J. Dizdarević, F. Guzman, B. Salazar and R. Mariano"
- **Basis:** full text
- **Relevance:** contradicts (credibility).
- **Cite as (APA 7):** (Mishra & Guru, 2026, p. 890)

### Sources without findings in this file
- **bayilmis2022survey** (original RQ3 list) — Task B obtained the legal publisher PDF from Karabük University; full-text experimental findings and limitations are verified in `related-work.md` F22. The experiment compares CoAP/MQTT/WebSocket throughput, inter-arrival delay and charge consumption, with theoretical L4–L7 efficiency; no payload-format or CPU/RAM comparison.
- **viswanathan2017analysis** (RQ3 list) — only the repository record and abstract were read. Abstract-level note (basis: abstract, no page): the thesis reports MQTT power consumption on a Raspberry Pi while varying QoS level, payload size and authentication. Nothing in the abstract mentions serialization formats.

## Methodological gaps in related work
- Analytical overhead model + validation covers WebSocket, CoAP and MQTT but not HTTP (polling); TLS, keep-alive/ping traffic and authentication are not modelled; latency is deliberately excluded; no CPU/RAM measurement — [@sarafov2018comparison]
- Overhead figures for HTTP polling and WebSocket frames are second-hand (book/blog sources), mutually inconsistent, and not measured on IoT hardware — [@muller2014websocket]
- Survey excludes WebSockets and does not discuss payload serialization formats beyond naming JSON/XML (the terms CBOR and Protocol Buffers do not occur in the text) — [@dizdarevic2019survey]
- Single metric dimension (power) on one microcontroller; header/message sizes and latency not measured; the text gives the HTTP average power as 667.33 mW while Tables 2/3 give 670.16 mW (internal inconsistency) — [@jaraochoa2023power]
- Simulation only, unspecified parameters, undefined overhead metric — [@mishra2026performance]

## PDF page offsets
| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| sarafov2018comparison | 7 (per-paper PDF from TUM; footer shows pp. 7–14) |
| muller2014websocket | none — PDF pages 1–10 are unnumbered/roman front matter; PDF page 11 = printed page 1 (offset 10, checked on PDF p. 14 = printed p. 4 and PDF p. 53 = printed p. 43) |
| dizdarevic2019survey | no final pagination (arXiv preprint v2, running head ":7" etc. with empty article number) — cite by section |
| jaraochoa2023power | no PDF; XML full text — cite by section, pages UNVERIFIED |
| mishra2026performance | PDF page 1 is an unnumbered cover sheet; PDF page 2 = printed page 883 (PDF page 10 is blank) |
| bayilmis2022survey | 1094 (publisher PDF obtained in Task B; experiment pp. 1101–1103 = PDF pages 8–10) |

## Cross-references (for other RQs)
- [RQ2] jaraochoa2023power — power consumption MQTT vs HTTP on NodeMCU; fits resource consumption better than RQ3.
- [RQ2] viswanathan2017analysis — MQTT power consumption on a Raspberry Pi (QoS, payload size, authentication), per abstract; fits RQ2 better than RQ3.
- [RQ2] muller2014websocket, p. 43 — in a SocketCluster benchmark, number of connections and ping period raise CPU usage faster than message size ("periods of pings increase the processor usage more quickly then the size of the messages exchanged.").
- [RQ1] dizdarevic2019survey, Sec. 4.1 — survey of latency comparisons (MQTT vs HTTP vs CoAP); TCP named as main cause of higher latency.
- [RQ5] sarafov2018comparison, p. 12–13 — netem-based 20 % packet loss experiment; ranking of protocols changes under loss.
- [Related work] dizdarevic2019survey, Sec. 2.2 — WebSockets explicitly out of scope.

## Open questions
- Is `viswanathan2017analysis` really the Viswanathan/Pittsburgh source used so far? No identifier was recorded; it is the only matching work found, but its topic is power consumption, not payload formats.
- Why are `jaraochoa2023power` and (probably) `viswanathan2017analysis` filed under RQ3? Neither compares JSON with CBOR/Protocol Buffers. After Task A, RQ3 has no verified existing source that actually addresses serialization formats (Bayılmış was subsequently read in Task B and also provides no serialization-format comparison).
- Should `sarafov2018comparison` and `muller2014websocket` (both non-peer-reviewed student works) stay as primary RQ4 sources, or be backed by RFC 6455 / the MQTT specification and peer-reviewed measurements?
