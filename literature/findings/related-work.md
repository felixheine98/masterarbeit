# Findings — Related Work and scope boundaries

Agent: lit-related-work · Last updated: 2026-10-03

> Historical creation note: this file was created from `_TEMPLATE.md` by lit-related-work. Task B subsequently re-read its source passages and updated the findings below, including the existing Bayılmış source after recovering its full text.

## Summary

Published smart-plug monitoring systems provide precedents for the thesis architecture but generally adopt a protocol without comparing communication performance. The evidence supports a narrower contribution than a first comparison of MQTT, HTTP and WebSocket: Năstase already evaluates that triple (alongside other protocols), and Kaur/Khanna's publisher abstract confirms a smart-room response-time comparison. The recovered Tusa/Clayman full text combines JSON/XDR, REST/WebSocket/UDP, CPU/RAM and exchanged-byte metrics on server clusters; it therefore covers more than two dimensions, although not the thesis' protocol and hardware combination. Petersen's related benchmark also combines serializers and middleware on Raspberry Pis. The contribution should be framed around the selected telemetry paths and four metric dimensions with consistent controls, conditional on the screened evidence and unresolved full texts. Primary Thread Group and CSA sources now support separate boundary arguments for Thread networking and Matter application interoperability.

## Findings

### Block 1 — Home energy monitoring systems and smart plugs

#### F1: A Shelly-based household monitoring system uses two protocols side by side without evaluating them
- **Claim:** Lima et al. instrument a real household with Shelly PM/EM meters and plugs and collect data over two paths in parallel: polling of the vendor cloud API (10-minute interval, into a cloud SQL database) and local MQTT telemetry. The choice is described functionally (remote access vs. local real time); no communication metric is measured.
- **Source:** [@lima2024household]
- **Page / section:** p. 787 (two protocols), p. 796 (10-minute collection)
- **Evidence:** "Data collection is streamlined through two distinct protocols." (p. 787)
- **Basis:** full text
- **Relevance:** supports — closest published system to the thesis' hardware (Shelly, household appliances); shows that polling and MQTT coexist in practice but are not compared.
- **Cite as (APA 7):** (Lima et al., 2024, p. 787)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 14 and 23 correspond to printed pp. 787 and 796; API integration p. 795 also inspected. The quote and two collection paths agree.

#### F2: Shelly devices → Mosquitto on a Raspberry Pi → Node-RED is an established pipeline
- **Claim:** The local real-time path in Lima et al. consists of Shelly devices publishing to a Mosquitto broker on a Raspberry Pi 3B, with Node-RED subscribing for graphs and automations.
- **Source:** [@lima2024household]
- **Page / section:** p. 797 (pipeline); p. 786 (Raspberry Pi 3B hosting Mosquitto and Node-RED)
- **Evidence:** "it was possible to manage messages from several devices" (p. 797; sentence excerpt)
- **Basis:** full text
- **Relevance:** supports — positions the thesis' architecture (Shelly → Pi/Mosquitto → store → dashboard) as representative rather than idiosyncratic.
- **Cite as (APA 7):** (Lima et al., 2024, p. 797)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 13/24 = printed pp. 786/797; hardware and subscription architecture confirmed; quotation shortened to a verbatim excerpt.

#### F3: MQTT + Mosquitto on a Raspberry Pi + InfluxDB + Grafana as energy-management monitoring stack
- **Claim:** Manowska et al. build a monitoring system for energy management with ESP8266 sensor nodes, a Mosquitto broker on a Raspberry Pi 3 B+, InfluxDB as time-series database and Grafana for visualisation. MQTT is adopted as "lightweight" without a measured comparison, and the system was only tested in the laboratory.
- **Source:** [@manowska2022mqtt]
- **Page / section:** p. 1 (architecture, abstract), p. 6 (Raspberry Pi 3 B+), p. 9 (conclusions)
- **Evidence:** "a Mosquitto-based MQTT broker is placed on the RPi and set up for remote monitoring and control" (p. 1)
- **Basis:** full text
- **Relevance:** supports — same broker → time-series DB → dashboard pipeline as the thesis; method gap (no protocol evaluation).
- **Cite as (APA 7):** (Manowska et al., 2022, p. 1)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 1, 6 and 9 confirm architecture, Pi 3 B+ and laboratory-only testing; hardware locator added. Published online in 2022, issue citation printed as 2023 (bibliographic distinction retained).

#### F4: Raspberry-Pi-centred "smart energy house" with MQTT, InfluxDB and Grafana
- **Claim:** Rojek et al. describe a monitoring system whose IoT modules communicate over Wi-Fi and MQTT with a central Raspberry Pi; measurements are stored in InfluxDB and visualised in Grafana, with WebSocket and a REST API mentioned only as access paths for browser clients.
- **Source:** [@rojek2021smartenergyhouse]
- **Page / section:** p. 038-8
- **Evidence:** "In the Smart Energy House project, Grafana is primarily used with MQTT and InfluxDB." (p. 038-8)
- **Basis:** full text
- **Relevance:** supports — second independent instance of the pipeline; all three thesis protocols appear in one system but are not compared.
- **Cite as (APA 7):** (Rojek et al., 2021, p. 038-8)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF page 8 is printed 038-8. Quote read in its column; REST/browser/WebSocket access is discussed without a comparative protocol experiment.

#### F5: Commercial Wi-Fi smart plugs publishing power data via MQTT to a cloud broker
- **Claim:** Albraheem et al. collect active-power data from commercial Wi-Fi smart plugs that publish to an MQTT broker on Amazon EC2; a Python client subscribes and stores the data (Firebase) for a mobile app. The paper reports no communication performance figures.
- **Source:** [@albraheem2023smartplug]
- **Page / section:** p. 359
- **Evidence:** "They will publish power data to MQTT Broker and the MQTT Client will subscribe to the topic to get the power data" (p. 359)
- **Basis:** full text
- **Relevance:** supports — cloud-broker variant of the same data path; protocol taken as given.
- **Cite as (APA 7):** (Albraheem et al., 2023, p. 359)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF page 7 = p. 359 confirms MQTT/EC2/Python/Firebase; pp. 360–361 inspected. The Android-app resource measurements on p. 361 are now acknowledged in the gap synthesis.

#### F6: Smart-plug review — Wi-Fi is the usual choice for residential plugs; protocols discussed only qualitatively
- **Claim:** The review by Suryadevara and Biswal surveys smart-plug technologies and commercial products and discusses the radio technologies (Wi-Fi, Zigbee, Z-Wave, BLE) qualitatively; for residential use it regards Wi-Fi as adequate. Application-layer protocols are mentioned only in passing (MQTT once, mixed with radio technologies).
- **Source:** [@suryadevara2019smartplugs]
- **Page / section:** p. 8 (protocol selection); p. 13 (table of commercial plugs and their wireless technology)
- **Evidence:** "For residential or individual use, Wi-Fi is a reliable option as the network is essentially free of any congestion most of the time." (p. 8)
- **Basis:** full text
- **Relevance:** supports — justifies the thesis' setting (application protocols over an existing home Wi-Fi/IP network) and shows that the smart-plug literature does not separate radio layer from application layer.
- **Cite as (APA 7):** (Suryadevara & Biswal, 2019, p. 8)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pp. 8/13 confirm the quotation and commercial table. The review's uncongested-home-network assertion is its qualitative view, not empirical validation of this experiment.

#### F7: Consumer-level effect of smart-plug monitoring (motivation)
- **Claim:** In a 15-month field study with 125 households equipped with IoT smart plugs, participating households used about 5 % less energy than average households; the reduction grew with the number of monitored appliances and the monitoring frequency. The paper contains no information on the communication architecture.
- **Source:** [@oh2020smartplug]
- **Page / section:** p. 1 (abstract)
- **Evidence:** "participating households used around 5% less energy compared to average households" (p. 1)
- **Basis:** full text
- **Relevance:** extends — motivation for appliance-level monitoring (Ch. 1.1 / 2.1), not for the protocol comparison itself.
- **Cite as (APA 7):** (Oh, 2020, p. 1)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF p. 1 confirms 15 months, 125 households, approximately 5% and monitoring-frequency association. This observational training/monitoring programme does not isolate the causal effect of the plug alone.

#### F8: Shelly Gen2 devices expose one RPC interface over HTTP, WebSocket and MQTT
- **Claim:** According to the vendor's device API documentation, Gen2+ Shelly devices support several RPC channels: HTTP (one-shot request/response, no keep-alive, no notifications), WebSocket (persistent connection at `ws://<shelly.addr>/rpc`, notifications after the client has sent a request frame with a valid `src`), MQTT (publish/subscribe via a broker, topics `<shelly-id>/rpc` and `<src>/rpc`) and UDP. The Shelly Plus Plug S page lists the components WiFi, Bluetooth Low Energy, Cloud, MQTT, Outbound Websocket and one Switch, and states that the device has a built-in power meter.
- **Source:** [@shelly2026rpcchannels], [@shelly2026plusplugs]
- **Page / section:** Sec. "HTTP", "Websocket", "MQTT", "UDP" (RPC Channels page); introductory paragraph (Shelly Plus Plug S page). Web pages, no pagination.
- **Evidence:** "HTTP is used for one-shot request-response calls." (RPC Channels, Sec. "HTTP")
- **Basis:** full text (vendor documentation, grey literature; pages read on 2026-10-03, no publication date)
- **Relevance:** supports — the three compared protocols are native access paths of the very device used, so the comparison is not artificial; HTTP's lack of notifications is the technical reason why HTTP must be evaluated as *polling* (Ch. 2.8).
- **Cite as (APA 7):** (Shelly, n.d.) — organisation name as it should appear in the reference list is UNVERIFIED (see Open questions)
- **Verification (Task B, 2026-10-03):** ✔ verified — current vendor RPC Channels sections and device introduction/components re-read; quote is exact. This verifies the stated Shelly API behaviour, not a universal HTTP restriction.

### Block 2 — Surveys and comparative studies of application-layer protocols

Most cited (OpenAlex citation counts on 2026-10-03, indicative only): Al-Fuqaha et al., 2015 (≈ 8,650); Naik, 2017 (≈ 700); Mishra & Kertesz, 2020 (≈ 425); Karagiannis et al., 2015 (≈ 420); Bayılmış et al., 2022 (≈ 160). Most recent: Petrescu et al., 2025; Bhowmik & Riaz, 2023. Dizdarević et al. (2019) belongs in this list as well but is already in `sources-existing.md`.

#### F9: The most cited IoT survey states that no comprehensive joint evaluation of application protocols exists
- **Claim:** After reviewing pairwise performance studies (e.g. MQTT vs. CoAP, CoAP vs. HTTP, XMPP over WebSocket, AMQP vs. REST), Al-Fuqaha et al. conclude that the protocols have not been evaluated together and offer only a feature table (Table IV, incl. minimum header size).
- **Source:** [@alfuqaha2015survey]
- **Page / section:** p. 2356
- **Evidence:** "there is no comprehensive evaluation of all these protocols together" (p. 2356; sentence excerpt)
- **Basis:** full text
- **Relevance:** supports — historical statement about the protocols covered by this 2015 survey. It does not establish an unresolved 2026 gap for the thesis triple or four dimensions; newer predecessors in the coverage table narrow the contribution.
- **Cite as (APA 7):** (Al-Fuqaha et al., 2015, p. 2356)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF page 10 = p. 2356; quotation checked with line-break dehyphenation. Relevance corrected to a historical 2015 observation rather than proof of a current gap.

#### F10: Thorough performance evaluation named as an open issue
- **Claim:** In the open-challenges section the same survey notes that evaluations of individual underlying technologies, application-layer protocols and QoS exist, but a thorough performance evaluation of IoT applications remains an open issue in 2015. This is a broad system-performance observation rather than a specific absence claim about MQTT/HTTP/WebSocket.
- **Source:** [@alfuqaha2015survey]
- **Page / section:** p. 2363
- **Evidence:** "is still an open issue" (p. 2363; sentence excerpt)
- **Basis:** full text
- **Relevance:** supports — a second passage in the same survey about performance evaluation; not an independent source or proof that the selected four-dimension gap persists.
- **Cite as (APA 7):** (Al-Fuqaha et al., 2015, p. 2363)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF page 17 = p. 2363. Claim corrected: the passage concerns broad IoT application performance, including underlying technologies and QoS; it is not an independent source for the specific gap.

#### F11: The widely cited MQTT/CoAP/AMQP/HTTP comparison is qualitative and literature-based
- **Claim:** Naik ranks MQTT, CoAP, AMQP and HTTP on a relative "lower/higher" scale for message size vs. overhead, power consumption vs. resource requirement, bandwidth vs. latency, and reliability vs. interoperability. The ranking is derived from protocol properties and prior literature, not from an own experiment; WebSocket is not included. HTTP is placed highest on message size, overhead, bandwidth and latency.
- **Source:** [@naik2017choice]
- **Page / section:** Sec. IV (accepted manuscript, no printed pagination)
- **Evidence:** "this evaluation is based on static components and some empirical evidence from the literature" (Sec. IV)
- **Basis:** full text (author-accepted manuscript)
- **Relevance:** supports — touches three of the thesis' four dimensions conceptually, but without measurement and without WebSocket; a good example of what "multi-dimensional but not empirical" looks like.
- **Cite as (APA 7):** (Naik, 2017, Sec. IV)
- **Verification (Task B, 2026-10-03):** ✔ verified — Sec. IV in unpaginated manuscript (PDF page 3) and the relative-ranking discussion confirm a literature-based qualitative comparison; quote read within its column.

#### F12: MQTT dominates research attention among M2M protocols
- **Claim:** Mishra and Kertesz survey MQTT research and implementations (brokers, client libraries) and show bibliometrically that MQTT had more publications than CoAP and AMQP in their 2015–2019 search; MQTT growth is separately calculated over earlier five-year windows; the survey compares broker/library features and does not measure performance.
- **Source:** [@mishra2020mqtt]
- **Page / section:** p. 201071 (abstract); pp. 201077–201078 (growth figures)
- **Evidence:** "show how the growth in MQTT research stands out from the rest" (p. 201071)
- **Basis:** full text
- **Relevance:** supports — frames MQTT as the reference protocol of the comparison (Ch. 2.4 / 3.1).
- **Cite as (APA 7):** (Mishra & Kertesz, 2020, p. 201071)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 1/7/8 = pp. 201071/201077/201078. Corrected a comparative-growth overstatement: the source compares publication counts and separately estimates MQTT growth.

#### F13: Closest verified experimental study — six protocols on a Raspberry Pi 3, overhead ratio and RTT only
- **Claim:** Năstase et al. run AMQP, CoAP, HTTP (REST), MQTT, WebSocket and XMPP between a Raspberry Pi 3 (clients) and a PC (servers) with both endpoints connected to a 100 Mbps LAN switch (p. 408), and analyse Wireshark captures. Measured: data bytes vs. total bytes, ratio of useful to total bytes ("protocol efficiency"), data vs. total packets, average packet size, and round-trip time. Not measured: CPU/RAM on the Pi, packet loss, payload format (the paper only remarks that JSON is expected to be replaced by binary formats, p. 407). XMPP, MQTT and WebSocket perform best.
- **Source:** [@nastase2017experimental]
- **Page / section:** p. 407 (metric list, hardware), p. 408 (100 Mbps switch and Wireshark), p. 411 (conclusions)
- **Evidence:** "XMPP, MQTT and WebSocket perform very well in terms of RTT" (p. 411; sentence excerpt)
- **Basis:** full text
- **Relevance:** supports / method inspiration — covers two of four dimensions (latency as RTT; overhead/efficiency ratio) for all three thesis protocols on comparable hardware. Strong predecessor for RQ4; leaves RQ2 and RQ3 open.
- **Cite as (APA 7):** (Năstase et al., 2017, p. 411)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 5–9 = pp. 407–411. Corrected wireless-network claim to the explicitly described 100 Mbps LAN switch; hardware, metrics and conclusion quote confirmed.

#### F14: A 2025 review still argues from secondary evidence and finds no universal choice
- **Claim:** Petrescu et al. review MQTT, MQTT-SN, CoAP, LwM2M, AMQP, XMPP, WebSockets, HTTP/HTTPS and OPC UA by design, communication pattern, reliability and security. Performance statements (e.g. the efficiency hierarchy CoAP > MQTT-SN > MQTT > HTTP) are taken from cited empirical studies; the review contains no own measurement. HTTP is rated least efficient for frequent telemetry; WebSocket limitations are listed qualitatively (TCP required, no native QoS; p. 15).
- **Source:** [@petrescu2025transport]
- **Page / section:** p. 1 (abstract), p. 15 (WebSocket limitations), p. 21 (Sec. 4.1, energy-efficiency hierarchy)
- **Evidence:** "HTTP/HTTPS: Consistently the least efficient for frequent telemetry." (p. 21)
- **Basis:** full text
- **Relevance:** supports — most recent review found; shows that the state of knowledge in 2025 is still assembled from heterogeneous studies. Supplies a secondary energy/traffic-efficiency expectation; it does not directly establish that HTTP polling has the worst latency in this experiment. HTTP connection reuse and polling policy must be controlled rather than inferred from statelessness.
- **Cite as (APA 7):** (Petrescu et al., 2025, p. 21)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 15/21 confirm limitations and quoted energy-efficiency hierarchy. Corrected its use as evidence for an unqualified HTTP latency ranking; the review is secondary evidence.

#### F15: Recent messaging-protocol review is purely literature-based and omits HTTP and WebSocket
- **Claim:** Bhowmik and Riaz review MQTT, AMQP, CoAP, XMPP, DDS and STOMP from earlier publications and summarise them in a feature table; HTTP and WebSocket are not among the reviewed protocols.
- **Source:** [@bhowmik2023review]
- **Page / section:** p. 3134 (abstract)
- **Evidence:** "This paper exhaustively summarizes information on the messaging protocols from the available previous research sources online." (p. 3134)
- **Basis:** full text
- **Relevance:** supports — further example of a qualitative review; low weight (minor journal), use at most as a supporting citation.
- **Cite as (APA 7):** (Bhowmik & Riaz, 2023, p. 3134)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF p. 1 = p. 3134; abstract quotation is verbatim and enumerates the six reviewed protocols. No own experiment is presented.

#### F16: MQTT over WebSocket adds overhead compared with MQTT over TCP
- **Claim:** Enache et al. discuss MQTT over WebSocket versus MQTT over TCP in terms of payload/QoS, TLS and latency and conclude that the WebSocket variant costs additional overhead (framing, masking) in exchange for web and firewall compatibility. The result tables carry citations to earlier work in their captions (Tables 3–5), and Sec. 5 explicitly states that all measurements were performed by references [8] and [13]; they are secondary, rather than this paper's own measurements.
- **Source:** [@enache2023mqttws]
- **Page / section:** p. 49 (conclusions); p. 48 (Tables 3–5)
- **Evidence:** "WebSocket introduces additional overhead" (p. 49; sentence excerpt)
- **Basis:** full text
- **Relevance:** extends — relevant for the thesis' definition of the "WebSockets" condition (native WebSocket messaging vs. MQTT tunnelled over WebSocket must be kept apart); low weight (4-page paper in a faculty bulletin).
- **Cite as (APA 7):** (Enache et al., 2023, p. 49)
- **Verification (Task B, 2026-10-03):** ✔ verified — PDF pages 3/4 = pp. 48/49. Sec. 5 explicitly attributes all measurements to [8]/[13]; secondary-data wording corrected and quote shortened.

#### F17: Same-hardware comparison of CoAP, WebSocket and MQTT — efficiency and RTT (abstract only)
- **Claim:** Mijovic et al. implement CoAP, WebSocket and MQTT on one low-cost hardware platform over IEEE 802.11 and measure protocol efficiency (overhead) and average round-trip time in LAN and Internet settings; CoAP is best, WebSocket close behind, MQTT depends on QoS. HTTP is not included.
- **Source:** [@mijovic2016comparing]
- **Page / section:** UNVERIFIED (paywalled, abstract only)
- **Evidence:** "average Round Trip Time (RTT), were experimentally evaluated" (abstract; sentence excerpt)
- **Basis:** abstract
- **Relevance:** supports — two of four dimensions (overhead, latency); origin of the efficiency metric reused by Năstase et al.
- **Cite as (APA 7):** (Mijovic et al., 2016) — no page until the full text is available
- **Verification (Task B, 2026-10-03):** ✔ verified — abstract only: University of Bologna author record (handle 11585/598271, exact-title indexed primary abstract) confirms protocols, hardware generality, efficiency/RTT and results. The full text and its page-level methods remain unverified.

#### F18: MQTT vs. WebSocket on an ESP8266 — RTT and device memory (abstract only)
- **Claim:** Oliveira et al. compare MQTT and WebSocket on an ESP8266 with Node.js servers with regard to documentation, round-trip time in a local network and memory allocated on the device, and find WebSocket preferable for low-RTT applications.
- **Source:** [@oliveira2018comparison]
- **Page / section:** UNVERIFIED (paywalled, abstract only)
- **Evidence:** "round-trip time of packages using local network and memory allocated in a device" (abstract)
- **Basis:** abstract
- **Relevance:** supports — two of four dimensions (latency, memory) for two of three protocols, on a microcontroller rather than a Linux gateway.
- **Cite as (APA 7):** (Oliveira et al., 2018)
- **Verification (Task B, 2026-10-03):** ✘ problem — no local PDF; IEEE direct page requires JavaScript, and the author institutional record confirms identity but does not expose the abstract. Secondary indexed text corroborates the wording; the RQ1 verifier also recovered a DOI-matched OpenAlex metadata abstract. Neither is a fresh primary-source quote/memory-method verification. Retained as abstract-only, with no pages.

#### F19: MQTT vs. WebSocket latency over a wide-area path (abstract only)
- **Claim:** Silva et al. measure round-trip time of MQTT and WebSocket between servers in Italy and Brazil and find similar average latency for both.
- **Source:** [@silva2018latency]
- **Page / section:** UNVERIFIED (paywalled, abstract only)
- **Evidence:** "Experiments were performed to measure the round trip time using MQTT (Message Queuing Telemetry Transport) and WebSocket protocols" (abstract)
- **Basis:** abstract
- **Relevance:** supports — one dimension (latency) only.
- **Cite as (APA 7):** (Silva et al., 2018)
- **Verification (Task B, 2026-10-03):** ✘ problem — no local PDF; direct IEEE response exposes no abstract, and Brescia institutional record has no associated file or abstract. The RQ1 verifier recovered a DOI-matched OpenAlex metadata abstract, but quote and WAN-result claim are not independently reverified against primary content; retained as explicitly abstract-only.

#### F20: HTTP vs. MQTT/TCP vs. MQTT/WebSocket on an ESP32 — abstract finding with full-text continuation in RQ1
- **Claim:** Amirkhanov et al. compare HTTP, MQTT over TCP and MQTT over WebSocket for a digital-twin application using an ESP32 and a DHT22 sensor; reported are average latency and its standard deviation (MQTT/TCP 290.5 ms; HTTP 342.6 ms) and connection stability.
- **Source:** [@amirkhanov2025evaluating]
- **Page / section:** Initial finding: abstract, no page citation. Continuation: RQ1 inspected the online publisher PDF, printed pp. 683, 685–686, 688 and 693; see `rq1-latency.md`, F23.
- **Evidence:** "evaluating their latency, connectivity stability, and IoT application feasibility using an ESP32 microcontroller and DHT22 sensor setup" (abstract)
- **Basis:** abstract for the claim and quote retained above; online full-text continuation is documented by RQ1, F23.
- **Relevance:** limits direct comparability — "WebSocket" means MQTT tunnelled over WebSocket. RQ1's full-text review found conflicting HTTP directions (POST ESP32→PC versus GET PC→ESP32) and different timing endpoints for MQTT acknowledgement and HTTP RTT; use its qualified method findings, not an unqualified protocol ranking. The local archival PDF is still outstanding.
- **Cite as (APA 7):** (Amirkhanov et al., 2025)
- **Verification (Task B, 2026-10-03):** ✔ verified — abstract only: publisher article page re-read confirms exact quotation and reported 290.5/342.6 ms means. Local full text unavailable; page-level continuation remains a cross-reference to RQ1, not an independent full-text pass here.

#### F21: Encoding × transport × edge resources and exchanged bytes in one testbed (continuation verified)
- **Claim:** Tusa and Clayman jointly evaluate JSON/XDR, REST/WebSocket/UDP, CPU/RAM and received/reply bytes on server clusters. MQTT is future work; latency is not measured with per-message timestamps. This is a multi-dimensional predecessor, not evidence that joint evaluation is absent.
- **Source:** [@tusa2021impact]
- **Page / section:** printed pp. 8–11 (variants, server hardware and metrics), pp. 17–18 (interpretation and MQTT future work); PDF pages equal printed article pages.
- **Evidence:** "we plan to evaluate the throughput and cost of using MQTT" (p. 18; sentence excerpt).
- **Basis:** full text (legal PDF recovered by RQ3; cited passages also read for this synthesis).
- **Relevance:** extends / limits novelty — covers payload, resources and traffic jointly. It does not evaluate MQTT, HTTP polling or CBOR/Protobuf variants, and it does not use a Raspberry Pi. Byte totals are not the thesis' full-session useful-payload efficiency ratio. Detailed extraction belongs in `rq3-payload.md`.
- **Cite as (APA 7):** (Tusa & Clayman, 2021)
- **Verification (Task B, 2026-10-03):** ✔ verified — article pp. 8–11 and 17–18 inspected, including Tables 1–2, byte/CPU/RAM metrics and MQTT future-work quotation (line-break dehyphenation); synthesis and partial latency/overhead table coverage are fair.

#### F22: Recovered full text compares CoAP, MQTT and WebSocket delay, throughput, charge and theoretical efficiency
- **Claim:** Bayılmış et al. add an experiment using a WeMOS D1/ESP8266EX and an i7/8 GB Windows 10 laptop. They generate 10,000 messages per size (8–1024 bytes) with a stated 10 ms waiting time. Sec. 4 measures throughput, average delay between packet arrivals on the server, and device charge consumption reported in mAh. The efficiency equations include opening/closing handshakes and per-message headers but explicitly omit protocol-stack layers 1–3. CPU/RAM consumption and payload-format alternatives are not evaluated in this experiment. The Wi-Fi link and a mobile 4.5G path are described; this should not be reduced to a local-only test.
- **Source:** [@bayilmis2022survey]
- **Page / section:** Sec. 4.1–4.2, pp. 1101–1103 (PDF pages 8–10); Table 3, Figs. 12–15 and Eqs. (1)–(2).
- **Evidence:** "throughput, message delay times, and energy consumption values" (p. 1101; sentence excerpt).
- **Basis:** full text (publisher-version PDF recovered from the Karabük University institutional publication system on 2026-10-03; identity, abstract and Sec. 4 inspected).
- **Relevance:** extends / limits novelty — another multi-metric CoAP/MQTT/WebSocket predecessor. The delay definition uses successive arrival times, not a timestamped sensor-to-gateway delivery latency; mAh is charge, not directly an energy unit. Its calculated efficiency differs from a complete captured-session byte ratio. Detailed follow-up belongs to RQ1/RQ4 rather than a new Related Work discovery task.
- **Cite as (APA 7):** (Bayılmış et al., 2022, pp. 1101–1103)
- **Verification (Task B, 2026-10-03):** ✔ verified — newly recovered local PDF pages 1 and 8–10 establish source identity and printed pp. 1101–1103. Abstract-only status replaced with inspected experimental evidence; table upgraded with inter-arrival-delay and theoretical-overhead limitations.

#### F23: Early survey includes WebSocket, REST/HTTP and MQTT, but is explicitly qualitative (continuation verified)
- **Claim:** Karagiannis et al. survey CoAP, MQTT, XMPP, RESTful services, AMQP and WebSocket. Section 9 explicitly describes the paper as qualitative and reserves implementation and experimental comparison for future work. Its WebSocket latency statements refer to prior studies rather than a new benchmark.
- **Source:** [@karagiannis2015survey]
- **Page / section:** Sec. 8, "Websocket", and Sec. 9, "Conclusions & Future Work". Deposited manuscript has seven pages numbered 1–7; the journal range 9–18 in the AIT record cannot be mapped to that version.
- **Evidence:** "Having seen this paper purely qualitatively" (Sec. 9; sentence excerpt).
- **Basis:** full text (legal Zenodo deposit recovered and read on 2026-10-03).
- **Relevance:** supports — useful historical protocol overview, not empirical evidence or proof that an experimental gap persists today. Metadata conflict: AIT gives volume 3(1), Zenodo volume 1(1); the manuscript does not resolve it.
- **Cite as (APA 7):** (Karagiannis et al., 2015)
- **Verification (Task B, 2026-10-03):** ✔ verified — deposited manuscript PDF page 5 contains Secs. 8–9 and exact quote; its qualitative character is explicit. Published-journal pagination and volume remain unresolved, so sections are retained.

#### F24: Publisher abstract confirms a smart-room comparison of MQTT, WebSocket and HTTP response time
- **Claim:** Kaur and Khanna report a NodeMCU smart-room implementation using sensors and Node-RED, and a comparison of the response-time delays of MQTT, WebSocket and HTTP. Polling policy, repeated-run statistics and coverage of the other dimensions require the full chapter.
- **Source:** [@kaur2022implementation]
- **Page / section:** publisher abstract (web page, no finding page number); chapter body remains paywalled.
- **Evidence:** "The response time delays of all these protocols for the smart room test bed have been found and compared." (abstract).
- **Basis:** abstract (read from Springer on 2026-10-03).
- **Relevance:** limits novelty — directly contradicts a first-three-protocol-comparison claim. Do not treat absent details in the abstract as proof that the chapter omits other dimensions.
- **Cite as (APA 7):** (Kaur & Khanna, 2022)
- **Verification (Task B, 2026-10-03):** ✔ verified — abstract only: Springer primary chapter page confirms NodeMCU/Node-RED and exact response-time sentence. No page citation or full-chapter coverage claim is inferred.

### Block 3 — Scope boundary: Thread and Matter

#### F25: Thread is a low-power IPv6 mesh specified from the physical up to the network layer
- **Claim:** Thread is an industry standard (Thread Group) for an IPv6-based low-power mesh network over IEEE 802.15.4 with its own routing protocol; it defines the physical through network layers and leaves the layers above to existing standards.
- **Source:** [@kim2019thread]
- **Page / section:** Sec. "Introduction" (accepted manuscript, journal pagination not printed)
- **Evidence:** "unlike RPL, Thread specifies physical through network layers" (Introduction)
- **Basis:** full text (accepted manuscript)
- **Relevance:** supports — Thread is an alternative *network* (radio, mesh routing, IPv6 adaptation), not an alternative to MQTT/HTTP/WebSocket. Comparing it would change the link and network layer and break the thesis' fair-comparison rule (only the application protocol varies; same Wi-Fi network).
- **Cite as (APA 7):** (Kim et al., 2019, Introduction)
- **Verification (Task B, 2026-10-03):** ✔ verified — Introduction on PDF page 1 (layout page 2) confirms the quote after dehyphenating physical. Deposited pagination differs from journal pagination; section citation retained.

#### F26: Matter is an application-layer standard on top of IPv6 that runs over Wi-Fi, Thread or Ethernet
- **Claim:** Matter is an open, IPv6-based protocol stack whose novelty is its application layer (data model, interaction model, message layer); transport is TCP or UDP (plus BTP over BLE for commissioning), the network layer is IPv6, and the supported underlying technologies are limited to Ethernet, Wi-Fi and Thread.
- **Source:** [@madadi2024matter]
- **Page / section:** Sec. I (definition); Sec. III (four layers); Sec. III-D (Ethernet, Wi-Fi, Thread)
- **Evidence:** "The application layer represents the main novelty" (Sec. III; sentence excerpt)
- **Basis:** full text (arXiv author version of the IEEE Communications Magazine article)
- **Relevance:** supports, with a caveat — see F27.
- **Cite as (APA 7):** (Madadi-Barough et al., 2024, Sec. III)
- **Verification (Task B, 2026-10-03):** ✔ verified — author-version Secs. I/III (PDF pages 1–4) confirm all layers, BTP commissioning and supported IP technologies; quote shortened. Author-version pages exist but are not published journal pagination.

#### F27: Consequence for the wording of the scope boundary
- **Claim:** The two sources support the exclusion, but not with one and the same argument. "Different network layer" is accurate for Thread (F25). It is *not* accurate for Matter: Matter is itself an application-layer standard and can run over the same Wi-Fi/IPv6 network as the thesis' protocols (F26). Matter's exclusion therefore needs its own justification: it is an integrated interoperability stack (data model, commissioning, fabric security, own message layer) aimed at device interoperability rather than a general-purpose messaging protocol for a telemetry pipeline, and it cannot be varied in isolation while keeping payload and transport constant. The source also evaluates Matter's encapsulation overhead, latency and energy (Sec. IV), i.e. Matter *is* measurable on the thesis' dimensions — it is out of scope by design decision, not by impossibility.
- **Source:** [@madadi2024matter], [@kim2019thread]
- **Page / section:** Sec. I, III, IV (Madadi-Barough et al.); Introduction (Kim et al.)
- **Evidence:** "Matter is an open, IPv6-based" (Madadi-Barough et al., Sec. I; sentence excerpt)
- **Basis:** full text; the reasoning in this finding is the agent's own synthesis, not a statement of the sources
- **Relevance:** corrects the historical shared "different network layer" justification. `docs/methodology.md` now already separates the two arguments; the design exclusion remains appropriate.
- **Cite as (APA 7):** (Kim et al., 2019; Madadi-Barough et al., 2024)
- **Verification (Task B, 2026-10-03):** ✔ verified — Secs. I/III/IV independently read; exclusion is clearly marked as the author's synthesis. Historical contradiction wording updated because methodology already separates the boundary arguments.

## Dimension coverage of the comparative studies (novelty check)

L = latency / packet loss (RQ1) · R = CPU/RAM on the device (RQ2) · P = payload format (RQ3) · O = protocol overhead / efficiency (RQ4). "~" = partially.

| Study | Protocols | Hardware | L | R | P | O | Basis |
|---|---|---|---|---|---|---|---|
| Năstase et al., 2017 | AMQP, CoAP, HTTP, MQTT, WebSocket, XMPP | Raspberry Pi 3 + PC | ~ (RTT; no loss) | – | – | yes (byte and packet ratios) | full text |
| Mijovic et al., 2016 | CoAP, WebSocket, MQTT | one low-cost platform (not named in abstract) | ~ (RTT) | ? | ? | yes (efficiency) | abstract |
| Oliveira et al., 2018 | MQTT, WebSocket | ESP8266 | ~ (RTT) | ~ (memory) | ? | ? | abstract |
| Silva et al., 2018 | MQTT, WebSocket | servers, WAN | ~ (RTT) | ? | ? | ? | abstract |
| Amirkhanov et al., 2025 | HTTP, MQTT/TCP, MQTT/WebSocket | ESP32, local Wi-Fi; not native WebSocket | ~ (latency/stability with inconsistent timing endpoints) | ? | ? | ? | abstract here; online full-text continuation in RQ1 F23 |
| Enache et al., 2023 | MQTT/TCP, MQTT/WebSocket | none identified (secondary data) | ~ | – | – | ~ | full text |
| Tusa & Clayman, 2021 | REST (HTTP POST), WebSocket, UDP; JSON/XDR | AMD/Intel server clusters; CentOS 7; 1 Gbps | ~ (counts within time window, not timed latency) | yes | yes (JSON/XDR) | ~ (received/reply bytes, not session efficiency) | full text, pp. 8–11, 17–18 |
| Petersen et al., 2017, communication comparison | ten middleware implementations × 25 serializers; no MQTT condition | two Raspberry Pi 3B; Java; 100 Mbps interfaces | ~ (latency/throughput, repeated ten times) | – (memory explicitly excluded) | yes (serializer × middleware) | – (no session byte efficiency) | full text, Secs. II, IV–V; detailed source in RQ3 |
| Bayılmış et al., 2022 | CoAP, MQTT, WebSocket | WeMOS D1/ESP8266EX + i7 laptop (Windows 10); Wi-Fi/mobile 4.5G path | ~ (inter-arrival delay; throughput; no delivery-loss metric) | – (hardware specs, not CPU/RAM consumption) | – (payload-size sweep, no format comparison) | ~ (theoretical efficiency, layers 1–3 excluded) | full text, Sec. 4, pp. 1101–1103; charge in mAh also measured |
| Kaur & Khanna, 2022 | MQTT, WebSocket, HTTP | NodeMCU sensors + Node-RED | ~ (response time; method unresolved) | ? | ? | ? | publisher abstract |
| Naik, 2017 | MQTT, CoAP, AMQP, HTTP | none (qualitative) | qualitative | qualitative | – | qualitative | full text |

Reading of the table: multi-dimensional predecessors exist, and Tusa/Clayman covers resources, payload and traffic jointly. No inspected entry establishes the complete thesis combination of the three telemetry paths and four measurement dimensions on a Raspberry Pi with a fixed smart-plug trace. This is a bounded synthesis, not proof of absence throughout the literature. Every "?" is an unknown, not a "no"; "–" applies only to inspected evidence. Middleware experiments must not be silently recast as the thesis' MQTT/HTTP polling/native WebSocket comparison.

## Methodological gaps in related work
- The inspected system papers adopt MQTT (or cloud polling) without a controlled joint protocol comparison. Albraheem does report Android-app CPU/RAM on p. 361; those figures are not Raspberry Pi protocol-resource comparisons — [@lima2024household], [@manowska2022mqtt], [@rojek2021smartenergyhouse], [@albraheem2023smartplug]
- A real deployment runs HTTP-style API polling and MQTT in parallel on Shelly devices without comparing them — [@lima2024household]
- The smart-plug literature discusses radio technologies and mixes them with application protocols; application-layer behaviour of plugs is not characterised — [@suryadevara2019smartplugs]
- No comprehensive joint evaluation of application protocols; thorough performance evaluation named as open issue (2015) — [@alfuqaha2015survey]
- Widely cited comparisons are qualitative rankings derived from prior literature, and omit WebSocket — [@naik2017choice], [@bhowmik2023review]
- The most recent review (2025) still synthesises performance from heterogeneous third-party studies with different hardware, payloads and networks — [@petrescu2025transport]
- The closest experimental study measures overhead ratio and RTT only: no CPU/RAM, no packet loss, no payload-format variation, no repeated runs or dispersion reported in the conclusions — [@nastase2017experimental]
- Several screened WebSocket comparisons use microcontrollers (ESP8266/ESP32), which do not provide the thesis' Linux/psutil measurement environment — [@oliveira2018comparison], [@amirkhanov2025evaluating] (abstracts), [@bayilmis2022survey] (Sec. 4). The screened set does not establish that most studies use microcontrollers; device memory can still be measured (F18).
- "WebSocket" is used for two different things in the literature (native WebSocket messaging vs. MQTT tunnelled over WebSocket); studies are not directly comparable across this difference — [@enache2023mqttws], [@amirkhanov2025evaluating]
- No entry in the inspected comparison table establishes a controlled MQTT/HTTP polling/native WebSocket experiment using a fixed consumer smart-plug trace. This is limited to the screened evidence; unread full texts do not establish absence.

## PDF page offsets
| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| bayilmis2022survey | 1094; pp. 1101–1103 = PDF pages 8–10 |
| lima2024household | 774 |
| manowska2022mqtt | 1 (article no. 17, paginated "1 of 12") |
| rojek2021smartenergyhouse | 038-1 |
| albraheem2023smartplug | 353 |
| suryadevara2019smartplugs | 1 (article no. 1957, paginated "1 of 20") |
| oh2020smartplug | 1 (article no. 4035, paginated "1 of 13") |
| alfuqaha2015survey | 2347 |
| mishra2020mqtt | 201071 |
| nastase2017experimental | 403 |
| petrescu2025transport | 1 (article no. 583, paginated "1 of 33") |
| bhowmik2023review | 3134 |
| enache2023mqttws | 46 |
| naik2017choice | no printed pagination (accepted manuscript) — cite by section |
| madadi2024matter | author-version pages numbered 1–7, not the published journal pages — cite by section |
| kim2019thread | journal pagination (55–61) absent; deposited layout pages are numbered 2–8 — cite sections for this version |

## Cross-references (for other RQs)
- [RQ4] nastase2017experimental — defines and measures "protocol efficiency" (useful bytes / total bytes) for MQTT, HTTP and WebSocket from Wireshark captures on a Raspberry Pi 3 (pp. 407–411); direct methodological predecessor.
- [RQ4] mijovic2016comparing — source of the protocol-efficiency metric (per Năstase et al., p. 407); paywalled.
- [RQ4] Yokotani & Sasaki (2016), "Comparison with HTTP and MQTT on required network resources for IoT", doi:10.1109/ICCEREC.2016.7814989 — seen in search (≈ 200 citations), closed access, not processed here.
- [RQ4] madadi2024matter — Sec. IV-A quantifies Matter encapsulation overhead; only relevant if a reviewer asks how Matter would compare.
- [RQ1] amirkhanov2025evaluating, silva2018latency, oliveira2018comparison — latency/RTT comparisons involving WebSocket (abstracts only).
- [RQ1/RQ4] enache2023mqttws — MQTT over WebSocket vs. MQTT over TCP (p. 49).
- [RQ2/RQ3] tusa2021impact — encoding (JSON vs. binary) and transport vs. edge resource consumption; should be read by whoever finalises RQ2/RQ3.
- [RQ3 / gap synthesis] petersen2017communication — combined middleware × serializer experiment on two Raspberry Pi 3B; Methods and Conclusion read here for the coverage table; detailed findings and verified BibTeX are owned by RQ3. Memory is explicitly outside the paper's scope; do not claim format × transport measurements on a Pi are new.
- [RQ3] nastase2017experimental, p. 407 — remark that JSON is expected to be replaced by binary formats in IoT (context only).
- [existing sources] bayilmis2022survey — the entry "ScienceDirect survey, PII S2352864822000347" in `sources-existing.md` is Bayılmış et al. (2022), Digital Communications and Networks, 8(6), 1094–1104, doi:10.1016/j.dcan.2022.03.013 (metadata verified via Crossref; full text recovered during Task B; see F22).
- [all] PDFs from other agents were present in `literature/pdfs/` during this run (e.g. almasri2020investigating, seoane2021performance, dizdarevic2023engineering) and were deliberately not processed here.

## Open questions
- **Kaur & Khanna (2022)** — publisher abstract verifies the three protocols and response-time comparison. Full chapter still needed for the method and dimension coverage; do not claim a first three-protocol comparison.
- **Tusa & Clayman (2021)** — full-text gap closed (F21). **Bayılmış et al. (2022)** full text was recovered and Sec. 4 read during Task B; F22 and the coverage table now record the actual hardware and measurement limits.
- The gap statements with full-text backing are from 2015 (Al-Fuqaha et al.) and 2025 (Petrescu et al., implicit). No source read here states the four-dimension gap explicitly; the novelty argument rests on the coverage table above, which is based on a limited search (OpenAlex, arXiv, one Semantic Scholar query). **IEEE Xplore and ACM DL were not searched directly**, and Semantic Scholar was rate-limited (HTTP 429) for the two main queries.
- Shelly documentation: the pages carry no date, and the legal name of the publisher (for the reference list) was not verified. The thesis names the device "Shelly Plus Plug S Gen2"; the documentation lists "Shelly Plus Plug S" under Gen2 devices — whether "Outbound Websocket" (device as client) or the inbound `ws://…/rpc` endpoint is used in the experiment should be stated in Ch. 2.8.
- Whether the Shelly Plus Plug S supports Matter was not checked; if it does not, that would be an additional practical argument for the scope boundary, but it must not be asserted without a source.
- Thread/Matter primary-source gap closed in this continuation: Thread Group FAQ and CSA Matter Core Specification 1.2 architecture sections were read (F28–F29 below). No latest-version claim or protocol-performance comparison is made.
- Karagiannis et al. (2015): legal full text now available; journal metadata corroborated by the author institution, but a volume conflict remains and the journal page range is not evidence pagination for the deposited manuscript (F23).
- Citation counts are OpenAlex values from the day of the search and are indicative only.

## Continuation — 2026-10-03

This continuation preserves previous findings except where new full text resolves or corrects them. The research gap remains a synthesis of screened studies, not a universal absence claim.

### F28: Thread Group explicitly separates Thread networking from the application layer
- **Claim:** The primary organisation describes Thread as IPv6 networking over IEEE 802.15.4 and states that applications run above it. This supports excluding Thread from a comparison that holds the Wi-Fi network constant.
- **Source:** [@threadgroup2026resources]
- **Page / section:** FAQ, Developers: "What Aspects Of The Wireless Network Does Thread Address?" and Buildings: "Can Thread Be Integrated Into An IPv4-Based Network?"
- **Evidence:** "The application layer itself is not covered by Thread" (sentence excerpt).
- **Basis:** full text (primary organisation web documentation read on 2026-10-03).
- **Relevance:** supports — primary backing for the Thread boundary; the exclusion from this experiment is the thesis author's design decision.
- **Cite as (APA 7):** (Thread Group, n.d., "What Aspects Of The Wireless Network Does Thread Address?")
- **Verification (Task B, 2026-10-03):** ✔ verified — primary Thread Group FAQ re-read at the named questions; exact application-layer excerpt and IPv6/IEEE 802.15.4 description confirmed.

### F29: The Matter Core Specification confirms application functionality over Wi-Fi, Ethernet or Thread
- **Claim:** Matter 1.2 defines an application layer over IPv6, with data and interaction models, binary action framing, security and a message layer. Wi-Fi, Ethernet and Thread are supported underlying technologies. Matter is therefore excluded to keep this experiment focused on telemetry messaging with controlled payloads, not because it occupies another network layer.
- **Source:** [@connectivitystandardsalliance2023mattercore]; corroborating overview [@connectivitystandardsalliance2024matteroverview].
- **Page / section:** Core Specification, Secs. 2.1–2.3, printed pp. 47–49 (PDF pages 51–53). Overview: heading "Build on proven, widely deployed technologies" (unpaginated).
- **Evidence:** "The protocol defines the application layer" (Core Specification, p. 47; sentence excerpt).
- **Basis:** full text of the cited architecture passages and the overview; the remaining specification was not reviewed.
- **Relevance:** supports / corrects — primary confirmation of F27. The scope consequence is the author's synthesis, not a technical impossibility of comparing Matter.
- **Cite as (APA 7):** (Connectivity Standards Alliance, 2023, pp. 47–49)
- **Verification (Task B, 2026-10-03):** ✔ verified — Core Specification PDF pages 51–53 = printed pp. 47–49; exact p. 47 excerpt and architecture read. CSA overview second-page heading corroborates the supported technologies; no whole-specification or latest-version claim.

### Suggested wording for Chapters 1.5 and 3.4

Thread provides IPv6 mesh networking over IEEE 802.15.4, with application protocols operating above it (Thread Group, n.d., "What Aspects Of The Wireless Network Does Thread Address?"). Evaluating Thread would change the network technology held constant in this study. Matter defines application functionality, including device data and interaction models, over IP networks such as Wi-Fi, Ethernet and Thread (Connectivity Standards Alliance, 2023, pp. 47–49). Its evaluation would introduce an interoperability stack beyond the selected telemetry messaging comparison. Both technologies are therefore discussed as context and excluded from the experiment by design.

### Additional pagination record

| bibkey | Inspected version and pagination rule |
|--------|----------------------------------------|
| karagiannis2015survey | Seven-page deposited manuscript numbered 1–7; published range 9–18 is institution metadata only; cite sections |
| threadgroup2026resources | Web FAQ; cite question heading, no pagination |
| connectivitystandardsalliance2023mattercore | PDF page 5 = printed page 1; printed page = PDF index minus 4 after front matter; inspected architecture pp. 47–49 |
| connectivitystandardsalliance2024matteroverview | Two-page PDF without printed page numbers; cite heading |
| tusa2021impact | Printed article pages 1–20 equal PDF pages; article number 32 is not pagination |
| petersen2017communication | DTU cover precedes six-page manuscript without proceedings pagination; cite sections; source owned by RQ3 |

### Completion record

- Three targeted discovery queries and three grouped retrieval/synthesis records added to the search log; seven distinct target sources screened, three new primary organisation references, and three existing study evidence upgrades. Petersen is a cross-reference to the RQ3-owned source.
- Three PDFs downloaded by this owner: Karagiannis, CSA Matter Core Specification 1.2 and the CSA overview. Tusa and Petersen were downloaded by RQ3; Pimentel by RQ1. No new acquisition requests.
- Karagiannis and Tusa removed from this owner's outstanding table. Kaur and Mijovic remain priorities; Bayılmış was subsequently recovered and its experiment inspected during Task B (F22). Amirkhanov has been inspected online by RQ1; its abstract was independently verified during Task B, while the local archival PDF remains outstanding.
- The continuation originally retained historical findings without complete re-verification. Task B has now covered all 29 numbered findings, with unresolved primary-evidence checks explicitly marked. IEEE/ACM coverage and remaining unknown dimensions still limit any universal novelty claim.
