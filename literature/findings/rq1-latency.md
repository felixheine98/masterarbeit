# Findings — RQ1: Latency and packet loss (MQTT, HTTP polling, WebSockets)

Agent: lit-rq1 · Last updated: 2026-10-03

## Summary
Continuation 2026-10-03: MQTT, HTTP REST and native WebSocket have already been compared on a Raspberry Pi 3 against a PC server by Năstase et al. (2017); Kaur and Khanna's (2022) publisher abstract confirms a further three-protocol response-time comparison using NodeMCU and Node-RED. The thesis must therefore position its contribution through the four metric dimensions under controlled conditions, rather than through the protocol triple alone. The Năstase study uses only ten JSON messages and different message layouts across protocols; a fixed HTTP polling schedule is not documented. Pimentel and Nickerson (2012), now read directly, provide a useful polling-versus-native-WebSocket precedent with checked NTP offsets. Amirkhanov et al. (2025), now inspected in the publisher PDF online, evaluate MQTT over WebSocket rather than a native WebSocket stream and describe inconsistent HTTP directions and latency endpoints. No source inspected for RQ1 demonstrates the thesis' complete combination of latency/delivery, CPU/RAM, payload-format variation and session overhead; this is a bounded observation about this evidence set.

Evidence base after continuation: 13 sources with full text inspected (including the previously selected sections of Al-Masri), and 14 limited to abstracts (including Łasocha's English abstract). One source was newly included for RQ1 from an existing local PDF (Năstase), and two formerly abstract-only sources were upgraded (Pimentel and Amirkhanov). Kaur remains abstract-only. Task B rechecked every numbered finding and now records per-finding verification below; Bayılmış additionally has a recovered local full-text experiment (F31 / Related Work F22). Page numbers are printed page numbers unless a section is given.

## Findings

### A. Direct protocol comparisons (latency / delivery)

### F1: HTTP is clearly slower and less reliable than MQTT and CoAP on a Raspberry Pi 4 testbed
- **Claim:** In a Raspberry Pi 4 / 802.11n testbed with a ~50-byte payload sent every 5 s, the reported mean latency was 22 ms (MQTT), 18 ms (CoAP) and 87 ms (HTTP); delivery rates were 99.7 %, 99.3 % and 96.1 % (Table I). Differences between HTTP and the other two were significant in a one-way ANOVA with Tukey HSD.
- **Source:** [@khaleefah2025empirical]
- **Page / section:** p. 77 (Table I and Sec. IV)
- **Evidence:** "CoAP and MQTT significantly outperform HTTP in latency and energy consumption."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Verified the 22/18/87 ms, 99.7/99.3/96.1% table values and reported ANOVA/Tukey conclusions on printed p. 77 (PDF 4); setup is p. 76 (PDF 3). These are the authors’ reported results, not an independent statistical reanalysis.
- **Relevance:** supports — closest hardware match (Raspberry Pi 4, Mosquitto, Wi-Fi) for the MQTT-vs-HTTP part of RQ1; gives an order of magnitude to compare the thesis results against.
- **Cite as (APA 7):** (Khaleefah et al., 2025, p. 77)

### F2: Khaleefah et al. measure sender-side round trip over 30 minutes per protocol
- **Claim:** Latency is defined as sending a message to receiving its acknowledgement at the same node (a clock-sync-free boundary), derived from Wireshark captures; monitoring duration is 30 minutes per protocol. Table I on p. 77 reports means without standard deviations; the number of independent repeated sessions is not documented. HTTP uses Flask; no WebSocket or impaired-network condition is included.
- **Source:** [@khaleefah2025empirical]
- **Page / section:** p. 76 (Sec. III-B, III-C)
- **Evidence:** "Defined as the time delay between the transmission of a message by a sender node and the reception of the acknowledgment by the same node."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ session count was overstated; corrected to duration and undocumented repetitions — Printed p. 76 (PDF 3) defines sender-side acknowledgement timing and 30-minute monitoring; Table I on p. 77 contains means without SD. The source does not establish the number of independent repeated sessions.
- **Relevance:** method inspiration / gap — RTT-at-sender is a clock-sync-free latency definition the thesis can use as a cross-check; the missing dispersion measures and missing WebSocket condition are a gap.
- **Cite as (APA 7):** (Khaleefah et al., 2025, p. 76)

### F3: MQTT latency rises only slightly with the QoS level on a loss-free link
- **Claim:** In the modified MQTT latency scenario, publisher and subscriber run in the same VM to avoid clock synchronisation; the Raspberry Pi publisher is used for bandwidth/CPU measurements in the original setup. Measured latency on a lossless, unencrypted link was 8.6 ms (QoS 0), 9.5 ms (QoS 1) and 10.2 ms (QoS 2). The paper reports a larger QoS effect with loss, but smaller than for bandwidth and CPU.
- **Source:** [@seoane2021performance]
- **Page / section:** pp. 10, 17 (Sec. 4.4.2 latency setup and Sec. 6.2 latency result)
- **Evidence:** "the latency values are 8.6 ms for QoS 0, 9.5 ms for QoS 1 and 10.2 ms for QoS 2"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ latency hardware attribution was misleading; corrected to the modified VM scenario — The three numerical values and QoS discussion are on printed p. 17. For the latency experiment the publisher and subscriber were relocated to the same VM (p. 10); the Raspberry Pi publisher belongs to the bandwidth/CPU setup.
- **Relevance:** supports — justifies treating the MQTT QoS level as a documented constant in the fair-comparison design (QoS comparison is only optional in the thesis) and gives reference values for a Raspberry Pi set-up.
- **Cite as (APA 7):** (Seoane et al., 2021, p. 17)

### F4: Under packet loss, MQTT inherits TCP retransmission behaviour and can be delayed by seconds
- **Claim:** Because MQTT relies on TCP for recovery, lost segments are retransmitted according to TCP timers, which can produce multi-second delays, whereas CoAP's application-level retransmission timers can be tuned.
- **Source:** [@seoane2021performance]
- **Page / section:** p. 19 (Sec. 6.3, CoAP and MQTT comparison)
- **Evidence:** "MQTT retransmissions follow the TCP scheme for retransmissions, what can lead to delays of several seconds."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 19 explicitly attributes multi-second delays to TCP retransmissions and contrasts configurable CoAP timers. Extension to the thesis’ TCP protocols is labelled as an expectation, not a measured result.
- **Relevance:** extends — all three thesis protocols run over TCP, so the same tail-latency mechanism is expected for HTTP polling and WebSocket under netem loss (optional RQ5); argues for reporting distributions/percentiles, not only means.
- **Cite as (APA 7):** (Seoane et al., 2021, p. 19)

### F5: Local time-to-completion spans tens of milliseconds to about one second, with zero observed loss
- **Claim:** On a local testbed including Raspberry Pi 3 B+ clients/brokers, the authors summarise time-to-completion as 10.67 ms (MQTT) to 1051 ms (CoAP) on p. 21. Table 7 on p. 20 instead lists a CoAP mean of 1015.28 ms for the high-IAT fixed-size case, so the upper summary value is internally inconsistent. No protocol lost messages in the local experiments; the authors attribute this to offered load below link capacity.
- **Source:** [@silva2021performance]
- **Page / section:** p. 21 (Sec. 6.2); loss statement p. 20 (Sec. 6.1)
- **Evidence:** "none of the protocols showed any packet loss for the scenarios run"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ heading contradicted the ~1 s result; numeric source inconsistency and overgeneralised loss expectation corrected — Printed pp. 20–21 support zero observed local loss and a wide TTC range. Table 7 reports CoAP mean 1015.28 ms, whereas pp. 20–21 prose says 1051 ms; retained this source discrepancy explicitly instead of treating the prose as an exact table result.
- **Relevance:** supports — zero observed loss is plausible at low LAN load; this study does not guarantee zero loss or establish that differences can only arise under impairment/overload. Report observations and application-delivery definitions in the thesis.
- **Cite as (APA 7):** (Silva et al., 2021, pp. 20–21)

### F6: At scale and high message rate, MQTT can lose the majority of messages
- **Claim:** In the large-scale FIT IoT-LAB run with 1 sender, 94 receivers and 1 ms inter-arrival time, MQTT lost about 65 % of messages while CoAP lost 0.04 % (Table 18).
- **Source:** [@silva2021performance]
- **Page / section:** p. 26 (Sec. 7; Table 18 on p. 25)
- **Evidence:** "for the MQTT case there is a packet loss of 65%"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ relevance generalised a single high-load implementation; corrected — Table 18 on printed p. 25 gives 1 sender/94 receivers, 5000 messages, 1 ms IAT, MQTT 65.16% and CoAP 0.04%; p. 26 gives the rounded quotation. Scope limited to this implementation/load, not an intrinsic MQTT loss rate.
- **Relevance:** extends — demonstrates loss in the tested high-load/fan-out implementation. This rate does not estimate delivery loss for the thesis’ six-device household setup; it helps to delimit transfer of the result.
- **Cite as (APA 7):** (Silva et al., 2021, p. 26)

### F7: "Packet loss" is defined differently per protocol family
- **Claim:** Silva et al. count an MQTT loss when a published message is never received by the subscriber, but a CoAP/OPC UA loss when a GET/PUT request fails, and derive CoAP loss from acknowledgements.
- **Source:** [@silva2021performance]
- **Page / section:** pp. 12, 17 (Sec. 4 loss definition; Sec. 4.5.2 ACK-based CoAP implementation)
- **Evidence:** "the definition of packet loss has differences due to the different characteristics of the protocols"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ claim included ACK implementation not present at the sole cited page; locator corrected — Printed p. 12 gives protocol-specific loss definitions; the CoAP ACK-based implementation and skipped-update example are on p. 17. Both locations now cited.
- **Relevance:** method inspiration — the thesis needs one application-level loss definition that works for push (MQTT, WebSocket) and pull (HTTP polling), e.g. sequence-numbered samples of the replayed Shelly trace that never arrive at the consumer; for polling, samples skipped between two polls must be counted separately from failed requests.
- **Cite as (APA 7):** (Silva et al., 2021, p. 12)

### F8: MQTT over WebSocket in the browser is the fastest of four pub/sub protocols, in the low-millisecond range
- **Claim:** In a browser-based test with Mosquitto and Paho JavaScript clients (MQTT over WebSocket, QoS 0), MQTT produced the lowest publisher-to-subscriber latency, followed by AMQP, with XMPP and DDS behind.
- **Source:** [@babovic2016web]
- **Page / section:** p. 6988 (Sec. VII-F)
- **Evidence:** "For the one-sensor-node message test case, MQTT achieved latency of only 2.53ms."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 6988 (PDF 15) gives the 2.53 ms value and ranking; setup on p. 6984 confirms Mosquitto, Paho and QoS 0 with WebSocket browser transport. Timing includes decoding, as stated in Sec. VII-F.
- **Relevance:** supports — shows that WebSocket transport does not prevent low-millisecond MQTT delivery on a LAN; relevant for the Next.js dashboard path of the thesis.
- **Cite as (APA 7):** (Babovic et al., 2016, p. 6988)

### F9: Platform socket implementations beat HTTP long polling in the Silverlight/Flash tests
- **Claim:** In the Silverlight application, socket-based delivery had lower transmit latency than long polling for XML messages (12.13–13.10 ms versus 13.49–14.46 ms), and long-polling messages were about 300 bytes larger. The same page reports an Adobe Flash NIO socket comparison. These results concern those platform socket implementations; they are not native HTML5 WebSocket measurements or an isolated causal test of header cost.
- **Source:** [@babovic2016web]
- **Page / section:** p. 6986 (Sec. VII)
- **Evidence:** "NIO socket implementation performs better than the long-polling protocol in all cases."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ native WebSocket/socket conflation and causal heading corrected — Printed p. 6986 (PDF 13) gives the Silverlight socket versus long-polling XML times and ~300-byte difference; NIO discussion belongs to Adobe Flash on the same page. These are platform socket implementations, not the native HTML5 WebSocket benchmark.
- **Relevance:** supports / caution — platform-specific socket/long-polling timing and message-size differences provide indirect RQ1/RQ4 context. Use the separate HTML5 experiments for claims about native WebSocket.
- **Cite as (APA 7):** (Babovic et al., 2016, p. 6986)

### F10: HTTP polling was slower than native WebSocket in a 4-Hz sensor experiment (original recovered)
- **Claim:** With a 150-ms pause between polls, HTTP polling showed 2.3–4.5 times the average latency of WebSocket across the tested paths. The selected Edmonton case was 151.3 ms versus 40.3 ms for WebSocket. All versions buffered and returned accumulated readings; this is not latest-value-only polling.
- **Source:** [@pimentel2012communicating]
- **Page / section:** pp. 47–50 (set-up, latency definition and Table 1)
- **Evidence:** "the application takes a time stamp at the server" (p. 48)
- **Basis:** full text; all nine PDF pages read in the continuation, replacing the earlier secondary citation through Babovic
- **Verification (Task B, 2026-10-03):** ✘ 2.3–4.5× ratio incorrectly applied to long polling as well; restricted to WebSocket — Printed p. 47 gives 4 Hz and 150 ms polling; p. 48 defines t4−t0 and buffering; Table 1 on p. 50 confirms 151.3 versus 40.3 ms and polling/WebSocket ratios 2.31–4.48. Some Japanese long-polling values exceed polling, so the ratio cannot be applied to long polling generally.
- **Relevance:** supports / method inspiration — latency starts when a measurement arrives at the server and ends at client receipt, including polling wait but excluding browser parsing/display. No MQTT or Raspberry Pi condition is included.
- **Cite as (APA 7):** (Pimentel & Nickerson, 2012, pp. 47–50)

### F11: Tunnelling MQTT through WebSocket changes latency only marginally, but lowers throughput
- **Claim:** The reported latencies for MQTT over TCP and MQTT over WebSocket are nearly identical for payloads of 5–1000 bytes (e.g. 283.35 ms vs. 284.70 ms at 5 bytes; Table 4), while message throughput is lower over WebSocket (Table 3), attributed to frame masking.
- **Source:** [@enache2023mqttws]
- **Page / section:** p. 48 (Tables 3–4, Sec. 5)
- **Evidence:** "all the measurements were performed by [8] and [13]"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 48 (PDF 3), Tables 3–4, confirms the numeric example and lower throughput over WebSocket; Sec. 5 explicitly attributes the measurements to [8] and [13]. This remains secondary quantitative evidence.
- **Relevance:** supports, with caution — the numbers are taken over from two other sources, not measured by the authors; hardware, repetitions and dispersion are not described. Usable as an indication only.
- **Cite as (APA 7):** (Enache et al., 2023, p. 48)

### F12: Qualitative ranking places HTTP last for latency and bandwidth
- **Claim:** Naik's relative comparison ranks HTTP as having the highest latency and bandwidth demand and CoAP the lowest, with MQTT and AMQP in between; the ranking is derived from protocol properties and earlier literature, not from an own experiment.
- **Source:** [@naik2017choice]
- **Page / section:** Sec. IV-C (ranking) and Sec. IV, introduction (basis of the comparison); author manuscript
- **Evidence:** "this evaluation is based on static components and some empirical evidence from the literature"
- **Basis:** full text (author-accepted manuscript)
- **Verification (Task B, 2026-10-03):** ✔ verified — Author manuscript Sec. IV introduction and IV-C (PDF 3–4) explicitly state a static/literature-based relative comparison; no new measured latency values inferred.
- **Relevance:** supports — widely cited baseline expectation (HTTP slowest), but explicitly non-empirical, which the thesis can point out.
- **Cite as (APA 7):** (Naik, 2017, Sec. IV)

### F13: MQTT latency versus QoS level depends on the broker and is not monotonic
- **Claim:** In a broker stress test on x86 machines, average latency for Mosquitto 1.4.15 was 1.65 ms (QoS 0), 0.74 ms (QoS 1) and 1.38 ms (QoS 2) (Table 10); other brokers showed different orderings, i.e. higher QoS did not always mean higher latency.
- **Source:** [@mishra2021stress]
- **Page / section:** p. 13 (Table 10); discussion p. 14
- **Evidence:** "In terms of average latency (round trip time), we found that at QoS0 Bevywise MQTT Route 2.0 leads the race"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 13 Table 10 gives Mosquitto 1.65/0.74/1.38 ms; quotation and RTT discussion are on p. 14. Broker rankings are conditional on the tested configurations.
- **Relevance:** contradicts (partly) F3 — the QoS effect on latency is implementation- and load-dependent; another reason to fix and document broker version and QoS in the thesis. Hardware is not a Raspberry Pi.
- **Cite as (APA 7):** (Mishra et al., 2021, pp. 13–14)

### B. HTTP polling interval

### F14: Polling wait depends on update phase and server load, rather than imposing the polling interval as a minimum latency
- **Claim:** In a benchmark with a resource updated every 5 s and clients polling with a 500 ms pause, client-side update latency spread over the whole 0–5 s range above 2000 clients in the configuration without a server-side cache; Server-Sent Events (push) always had a lower maximum latency than cached polling. The authors note that shorter polling intervals reduce latency at the cost of bandwidth.
- **Source:** [@vandevyvere2020comparing]
- **Page / section:** Sec. 5 (set-up), Sec. 5.2 (results), Sec. 6 (discussion); polling trade-off in Sec. 2.1 (author version, own pagination)
- **Evidence:** "A higher polling frequency can minimize the latency on the client, but this comes at a higher bandwidth cost"
- **Basis:** full text (author version)
- **Verification (Task B, 2026-10-03):** ✔ verified — Author version Secs. 2.1, 5.1, 5.2 and 6 (PDF 3, 7, 9–12) confirm 5 s updates, 500 ms pause, >2000-client spread and the reported SSE comparison; this is a caching/load-specific benchmark, not a universal polling lower bound.
- **Relevance:** method inspiration — latency of HTTP polling is largely a function of the polling interval relative to the update interval; the thesis must therefore report the polling interval together with every latency figure and ideally separate "request latency" from "data age at the consumer".
- **Cite as (APA 7):** (Van de Vyvere et al., 2020, Sec. 2.1)
- **Continuation correction:** Sec. 6 explicitly describes latency distributed between zero and the polling interval when update and polling rates match. The earlier heading incorrectly stated a lower bound equal to the polling interval. A newly available update can be fetched almost immediately; response time, caching and queueing can add delay. Secs. 2.1, 5.2 and 6 were re-read in the existing author PDF.

### F15: Polling-vs-push benchmarks measure "latency on the client" from a generation timestamp in the payload
- **Claim:** Each update object carries the timestamp of its generation; clients compute latency on receipt and log it to InfluxDB. The polling client fetches continuously with a fixed pause between response and next request.
- **Source:** [@vandevyvere2020comparing]
- **Page / section:** Sec. 5
- **Evidence:** "we choose to continuously fetch the HTTP document with a pause of 500ms between the previous response and the next request"
- **Basis:** full text (author version)
- **Verification (Task B, 2026-10-03):** ✔ verified — Author version Sec. 5.1 (PDF 7) defines the generation timestamp and pause after response; logging to InfluxDB is stated on PDF 9. Evidence quote shortened across the original PDF line wrap without changing wording.
- **Relevance:** method inspiration — same measurement pattern as planned in the thesis (timestamp in the payload, InfluxDB as sink); it requires synchronised clocks between generator and consumer (see F17).
- **Cite as (APA 7):** (Van de Vyvere et al., 2020, Sec. 5)

### C. Measurement methodology (clock sync, repetitions, impairment)

### F16: Studies avoid clock synchronisation by running publisher and subscriber on the same machine
- **Claim:** To measure MQTT publish-to-receive latency, Seoane et al. placed publisher and subscriber in the same virtual machine, following Thangavel et al. (2014); Babovic et al. did the same for their messaging test and thereby effectively measured round-trip time.
- **Source:** [@seoane2021performance]; [@babovic2016web]
- **Page / section:** Seoane p. 10 (Sec. 4.4.2); Babovic p. 6984 (Sec. VI-B)
- **Evidence:** "Following [12], the publisher and subscriber were run in the same virtual machine to avoid clock synchronization." (Seoane et al.)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Seoane printed p. 10 explicitly relocates publisher/subscriber to one VM; Babovic p. 6984 (PDF 11) places both clients on one computer and calls this RTT. The designs are described separately, not assumed equivalent to one network-hop RTT.
- **Relevance:** method inspiration — a clock-sync-free design option for the controlled scenario: Shelly emulator (publisher) and consumer on the same host, with the Raspberry Pi as broker/server in between.
- **Cite as (APA 7):** (Seoane et al., 2021, p. 10; Babovic et al., 2016, p. 6984)

### F17: NTP accuracy was insufficient in Babovic's configuration and must be checked in each experiment
- **Claim:** Babovic et al. evaluated PTP and NTP for server–client clock synchronisation and discarded NTP because the server's offset to nearby NTP servers fluctuated between a few milliseconds and about 80 ms; they used a commercial tool that kept the offset below 0.5 ms. They also note that at a 1 ms timer resolution, single-digit-millisecond results are only approximate.
- **Source:** [@babovic2016web]
- **Page / section:** pp. 6983–6984 (Sec. VI-A, NTP and selected tool); timer resolution p. 6989 (Sec. VII-F)
- **Evidence:** "we have also eliminated NTP because the clock offset on our server fluctuated from a few milliseconds to approximately 80ms"
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ sub-millisecond tool result needed p. 6984 in the locator; corrected — Printed p. 6983 (PDF 10) gives the NTP fluctuation; p. 6984 states the selected tool’s <0.5 ms offset, and p. 6989 gives 1 ms timer resolution. The offset is configuration-specific.
- **Relevance:** contradicts / threat to validity — the thesis' locked methodology relies on NTP-synchronised timestamps while expected LAN latencies are 10–100 ms (F1, F3, F5). The NTP offset must be measured and reported (e.g. local NTP server on the test LAN, logged chrony offsets), or one-way latency must be backed by an RTT-based measurement.
- **Cite as (APA 7):** (Babovic et al., 2016, p. 6983)
- **Continuation qualification:** This is a result of that NTP configuration, not a universal limitation of NTP. Pimentel and Nickerson check offsets before and after their tests and treat differences below their threshold as uncertain (F35). The locked NTP decision can remain; measuring its uncertainty is the relevant requirement.

### F18: Cross-device timestamps are sometimes used without any documented clock synchronisation
- **Claim:** Silva et al. compute time-to-completion using a publisher timestamp t1 and subscriber timestamp t2 taken on different devices. Inspection of all 30 pages finds no operational procedure for synchronising those device clocks or quantifying their offsets. The paper mentions lack of synchronization in a CoAP-performance explanation on p. 20, which is not a documented clock-handling procedure.
- **Source:** [@silva2021performance]
- **Page / section:** p. 17 (Sec. 4.5)
- **Evidence:** "t1 corresponds to the timestamp registered by the publisher at the instant when the message is sent"
- **Basis:** full text (all-page term search plus inspection of Sec. 4.5 timestamp definition and the synchronization discussion on p. 20)
- **Verification (Task B, 2026-10-03):** ✘ blanket absence of any synchronisation mention was false; narrowed to absence of documented clock procedure — Printed p. 17 defines publisher/subscriber timestamps; checked all 30 pages for NTP, clock and synchronization terms. The source does mention lack of synchronization in a CoAP-performance discussion (p. 20), but gives no operational cross-device clock procedure.
- **Relevance:** gap — undocumented clock handling is a recurring weakness the thesis can explicitly avoid.
- **Cite as (APA 7):** (Silva et al., 2021, p. 17)

### F19: Good practice exists for repetitions and dispersion, but is not the norm
- **Claim:** Silva et al. repeated every experiment 10 times and report mean, standard deviation, min, max, median and confidence interval; Seoane et al. show means with 95 % confidence intervals over 500 CoAP requests or MQTT messages per experiment; Gündoğan et al. repeated each experiment 1,000 times.
- **Source:** [@silva2021performance]; [@seoane2021performance]; [@gundogan2018ndn]
- **Page / section:** Silva p. 19 (Sec. 5); Seoane p. 13 (Sec. 6) and p. 10 (Sec. 4.3.2); Gündoğan Sec. 3 (paragraph "Testbed", arXiv version)
- **Evidence:** "all of the experiments have been repeated 10 times" (Silva et al.)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Silva p. 19 confirms 10 repeats and the six reported statistics; Seoane pp. 10 and 13 confirm 500 CoAP requests / MQTT messages per case and 95% CI; Gündoğan Sec. 3 (PDF 4) states 1000 repeats.
- **Relevance:** method inspiration — benchmark for the thesis' "repeated runs, mean ± standard deviation" decision; ≥ 10 runs per condition with SD and CI is defensible against this literature.
- **Cite as (APA 7):** (Silva et al., 2021, p. 19; Seoane et al., 2021, p. 13; Gündoğan et al., 2018, Sec. 3)

### F20: Network impairment is emulated with NetEm on a separate node between the endpoints
- **Claim:** Seoane et al. inserted a Linux virtual machine running NetEm between Raspberry Pi 3 and client/broker and tested loss rates of 0, 5, 10, 15 and 20 %; the emulator runs on a separate node because NetEm drops packets before they reach the interface, so they could not be captured on the sending host.
- **Source:** [@seoane2021performance]
- **Page / section:** p. 8 (Sec. 4.1); loss rates p. 10 (Sec. 4.4.2)
- **Evidence:** "These nine experiments were repeated for five different packet loss rates (0%, 5%, 10%, 15% and 20%), resulting in 45 total experiments."
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed pp. 8 and 10 confirm separate NetEm VM, capture-point rationale, five loss rates and 45 MQTT cases. Optional RQ5 classification preserved.
- **Relevance:** method inspiration — directly reusable for optional RQ5 (netem instead of physical distance tests): choice of loss rates and placement of the emulator relative to tcpdump capture points.
- **Cite as (APA 7):** (Seoane et al., 2021, pp. 8, 10)

### F21: Tested single-hop push variants were faster but sometimes less reliable than pull variants
- **Claim:** In single-hop experiments on constrained class-2 nodes (IEEE 802.15.4, FIT IoT-LAB), push-oriented protocol variants completed faster, whereas unconfirmed push lost data (about 6 % for non-confirmable CoAP PUT at a 50 ms publishing interval).
- **Source:** [@gundogan2018ndn]
- **Page / section:** Sec. 4.4 (arXiv version)
- **Evidence:** "push-oriented protocols operate faster, but less reliable"
- **Basis:** full text (arXiv v3)
- **Verification (Task B, 2026-10-03):** ✘ heading generalised a conditional result; restricted to the tested single-hop variants — ArXiv Sec. 4.4 (PDF 6) explicitly reports faster but less reliable push variants and 6% unconfirmed CoAP PUT loss at 50 ms; class-2 nodes and IEEE 802.15.4 are in Sec. 3. This is not a generic push reliability law.
- **Relevance:** extends — conceptual frame for comparing push (MQTT, WebSocket) with pull (HTTP polling); hardware and link layer differ from the thesis (no Wi-Fi, no Raspberry Pi), so only the pattern, not the numbers, transfers.
- **Cite as (APA 7):** (Gündoğan et al., 2018, Sec. 4.4)

### D. Survey-level statements on the state of research

### F21a (survey): A large protocol survey leaves WebSocket to future work and criticises inconsistent latency definitions
- **Claim:** Al-Masri et al. review latency studies for MQTT, CoAP, AMQP, XMPP, DDS and HTTP, observe that it is often unclear whether reported latency includes connection initialisation, and explicitly defer HTTP/2 and WebSocket to future work.
- **Source:** [@almasri2020investigating]
- **Page / section:** p. 94901 (Sec. on performance comparison); p. 94907 (Sec. VIII, conclusion)
- **Evidence:** "we plan to investigate HTTP 2.0 and WebSocket as part of the messaging protocols"
- **Basis:** full text (relevant sections read, not the whole 32-page survey)
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed pp. 94901 and 94907 (PDF 22 and 28) confirm inconsistent initialization treatment and WebSocket/HTTP 2.0 future-work statement.
- **Relevance:** supports the novelty argument — a highly cited survey confirms that WebSocket is under-represented and that latency definitions are not comparable across studies; the thesis' RQ4 distinction (per message vs. full connection incl. handshake) answers exactly this.
- **Cite as (APA 7):** (Al-Masri et al., 2020, pp. 94901, 94907)

### E. Further comparisons (evidence basis stated for each finding)

Most entries in this section retain the original abstract-only evidence from OpenAlex (F22 from the PDF). F23 was upgraded using the publisher PDF in the continuation; Task B subsequently upgraded F31 using the recovered local publisher PDF. F32 uses the publisher abstract. Full-text gaps remain on the to-acquire list.

### F22: For few messages per second, simple HTTP polling is reported as sufficient; WebSocket pays off at high message counts
- **Claim:** A LAN test with a self-written application found several-hundred-percent gains for WebSocket over HTTP when more than 100 copies of a 100-character text were transmitted.
- **Source:** [@lasocha2021comparison]
- **Page / section:** — (English abstract; body text is in Polish)
- **Evidence:** "for a smaller number of them, a simple HTTP polling is absolutely enough"
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✘ abstract says “when”, not “only when”; unsupported exclusivity removed — English abstract on local PDF 1 supports LAN, 100-character texts and gains when >100 copies are transferred. Polish body was not used and no page-level full-text claim is made.
- **Relevance:** contradicts (partly) the blanket expectation that WebSocket is always faster — relevant for a home energy monitor with one sample per plug per second or slower.
- **Cite as (APA 7):** (Łasocha & Badurowicz, 2021)

### F23: HTTP vs. MQTT/TCP vs. MQTT/WebSocket on an ESP32: large dispersion and inconsistent method descriptions
- **Claim:** The reported means are 290.500 ms (MQTT/TCP), 341.973 ms (MQTT/WebSocket) and 342.645 ms (HTTP); MQTT/TCP SD is 325.719 ms, exceeding HTTP's 307.931 ms. Hardware uses a local Wi-Fi router, rather than a documented Internet path.
- **Source:** [@amirkhanov2025evaluating]
- **Page / section:** pp. 683, 685–688, 692–693 (Table 1 on p. 692)
- **Evidence:** "the ESP32 can behave like an HTTP server" (p. 688)
- **Basis:** publisher PDF inspected online, especially Methods and Discussion; local download timed out
- **Verification (Task B, 2026-10-03):** ✘ numerical table page omitted from locator; p. 692 added — Publisher PDF re-inspected online: setup p. 683; HTTP direction contradiction pp. 685/688; MQTT acknowledgement timing p. 686; numerical Table 1 p. 692 and discussion p. 693. Quotation on p. 688 is verbatim. Local curl retrieval failed, but direct online full text is available.
- **Relevance:** gap — p. 685 describes ESP32→PC POST, whereas p. 688 describes PC→ESP32 GET RTT. MQTT timing targets broker acknowledgement (p. 686), not subscriber receipt. Resolve endpoint/direction contradictions before using results as a performance baseline. MQTT-over-WebSocket is distinct from native WebSocket.
- **Cite as (APA 7):** (Amirkhanov et al., 2025, pp. 683, 685–688, 692–693)

### F24: CoAP, WebSocket and MQTT on identical low-cost hardware: MQTT's RTT depends strongly on QoS
- **Claim:** CoAP achieved the lowest average RTT and highest protocol efficiency, closely followed by WebSocket; MQTT performance depended on the QoS profile; moving from LAN to a realistic Internet configuration did not change protocol efficiency significantly.
- **Source:** [@mijovic2016comparing]
- **Page / section:** —
- **Evidence:** "The performance of MQTT protocol strongly depend on the Quality of Service (QoS) profile."
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✔ verified — Verified only against the DOI-matched abstract retrieved from OpenAlex: hardware equivalence, CoAP/WebSocket ranking, QoS sensitivity and LAN/Internet efficiency statement match. Missing PDF; exact numbers, methods and publication pages remain unverified.
- **Relevance:** supports — most direct predecessor for the WebSocket-vs-MQTT part of RQ1 (and for RQ4's efficiency ratio); HTTP is missing.
- **Cite as (APA 7):** (Mijovic et al., 2016)

### F25: MQTT and WebSocket show similar average round-trip latency over a WAN path
- **Claim:** Round-trip times between servers in Italy and Brazil were similar for MQTT and WebSocket for a given payload size but depended on the network path.
- **Source:** [@silva2018latency]
- **Page / section:** —
- **Evidence:** "The average latency samples using each of the protocols were similar"
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✔ verified — Verified only against the DOI-matched abstract from OpenAlex: Italy–Brazil RTT path and similar protocol averages match. Missing PDF; no page citation or quantitative transfer claim.
- **Relevance:** supports — suggests path effects dominate protocol effects, which argues for the isolated test network considered in the thesis.
- **Cite as (APA 7):** (Silva et al., 2018)

### F26: An ESP8266 abstract recommends WebSocket for its tested RTT context
- **Claim:** The abstract describes local RTT tests between an ESP8266 and Node.js servers and recommends WebSocket over MQTT in its tested context. Its wording “RTT of at least 1 millisecond” is ambiguous; no precise threshold or universal low-RTT advantage can be established without the full text.
- **Source:** [@oliveira2018comparison]
- **Page / section:** —
- **Evidence:** "It has been found that the use of WebSocket is more appropriate than MQTT in applications with RTT of at least 1 millisecond"
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✘ heading overinterpreted ambiguous abstract; narrowed to its context-specific recommendation — Verified the ESP8266/Node.js/local-network description and quoted “at least 1 millisecond” wording in the DOI-matched abstract. That wording is ambiguous and cannot establish an independent threshold or a general low-latency superiority claim.
- **Relevance:** extends — microcontroller hardware (out of scope as substitute for the Pi), two protocols only.
- **Cite as (APA 7):** (Oliveira et al., 2018)

### F27: Loss/delay emulation studies cover MQTT, CoAP, MQTT-SN, DDS and QUIC — not HTTP polling or WebSocket
- **Claim:** Thangavel et al. found MQTT faster than CoAP at low loss and slower at high loss; Liri et al. vary loss, delay and disruption for CoAP, MQTT, MQTT-SN and QUIC; Chen and Kunz emulate a low-bandwidth, high-latency, high-loss access network for MQTT, CoAP, DDS and a custom UDP protocol.
- **Source:** [@thangavel2014performance]; [@liri2018robustness]; [@chen2016performance]
- **Page / section:** —
- **Evidence:** "MQTT messages have lower delay than CoAP messages at lower packet loss rates and higher delay than CoAP messages at higher loss rates" (Thangavel et al.)
- **Basis:** abstract (Thangavel's result is additionally confirmed second-hand in Babovic et al., 2016, p. 6978, and Seoane et al., 2021, p. 7)
- **Verification (Task B, 2026-10-03):** ✔ verified — Verified the DOI-matched abstracts of Thangavel, Liri and Chen from OpenAlex: loss-dependent MQTT/CoAP delay, four-protocol impairment study and emulator-based constrained access network. Full texts remain missing; second-hand mentions are not treated as full-text verification.
- **Relevance:** gap + method inspiration — impairment methodology is established, but the thesis' protocol triple has not been subjected to it in the screened literature.
- **Cite as (APA 7):** (Thangavel et al., 2014; Liri et al., 2018; Chen & Kunz, 2016)

### F28: Raspberry Pi HTTP/REST precedents and a further AMQP/CoAP/MQTT comparison omit WebSocket
- **Claim:** Tandale et al. implemented CoAP, MQTT and REST on a Raspberry Pi 3 gateway and compared time and bandwidth over 4G and broadband; Joshi et al. compare MQTT, HTTP and CoAP in a Raspberry Pi smart-home system; Moraes et al. compare AMQP, CoAP and MQTT on throughput, message size and packet loss.
- **Source:** [@tandale2017empirical]; [@joshi2017performance]; [@moraes2019performance]
- **Page / section:** —
- **Evidence:** "These protocols are implemented on arm based device Raspberry Pi3" (Tandale et al.; abstract)
- **Basis:** abstract (Joshi et al. additionally second-hand: Al-Masri et al., 2020, p. 94900, report that MQTT had a much lower latency than HTTP in that home-automation testbed)
- **Verification (Task B, 2026-10-03):** ✘ heading no longer implies Moraes used Raspberry Pi — Verified the three DOI-matched abstracts from OpenAlex. Tandale spells the platform “arm based device Raspberry Pi3”; Joshi explicitly includes Raspberry Pi and MQTT/HTTP/CoAP; Moraes gives protocol/metric coverage but does not identify Raspberry Pi hardware.
- **Relevance:** supports / gap — Tandale and Joshi confirm Raspberry Pi as an evaluation platform; Moraes provides protocol/metric coverage without an abstract-level hardware identification. None of the three abstracts includes WebSocket.
- **Cite as (APA 7):** (Tandale et al., 2017; Joshi et al., 2017; Moraes et al., 2019)

### F29: WebSocket has been compared with CoAP, MQTT and XMPP on response time under load
- **Claim:** A smart-parking implementation measured response time of CoAP, MQTT, XMPP and WebSocket while varying traffic load.
- **Source:** [@kayal2017comparison]
- **Page / section:** —
- **Evidence:** "measured their response time by varying the traffic load"
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✔ verified — Verified only against DOI-matched OpenAlex abstract: smart parking, CoAP/MQTT/XMPP/WebSocket and response time under varying load. PDF absent; no full-text result inferred.
- **Relevance:** extends — another WebSocket-inclusive comparison without HTTP polling.
- **Cite as (APA 7):** (Kayal & Perros, 2017)

### F30: A photovoltaic-system abstract reports efficiency and speed benefits for MQTT and AMQP
- **Claim:** A comparison of HTTP, MQTT and AMQP in a chain of solar farms concludes that MQTT and AMQP improve efficiency and speed.
- **Source:** [@tran2024analysis]
- **Page / section:** —
- **Evidence:** "The results show that MQTT and AMQP play a role in enhancing overall efficiency and speed"
- **Basis:** abstract
- **Verification (Task B, 2026-10-03):** ✘ heading implied an explicit HTTP ranking beyond the abstract; corrected — Verified only against DOI-matched OpenAlex abstract: solar-farm chain, HTTP/MQTT/AMQP and claimed efficiency/speed improvement. PDF absent; numerical ranking and measurement method remain unverified.
- **Relevance:** supports — the only energy-domain protocol comparison found; metrics and method unknown until the full text is read.
- **Cite as (APA 7):** (Tran et al., 2024)

### F31: Bayılmış’s full text compares CoAP/MQTT/WebSocket using inter-arrival delay rather than sample delivery latency
- **Claim:** The recovered publisher PDF describes an experiment on a WeMOS D1/ESP8266EX and an i7/8 GB laptop with CoAP, MQTT and native WebSocket. Table 3 specifies 10,000 messages per size (8–1024 bytes) and a 10 ms wait. Sec. 4.1 defines average delay using successive packet arrival times at the server; this does not establish an end-to-end, timestamped sample-delivery latency. Wi-Fi and a mobile 4.5G path are described. CPU/RAM consumption and payload-format alternatives are not experimental outcomes here.
- **Source:** [@bayilmis2022survey] (existing source; full-text status also updated in Related Work F22)
- **Page / section:** pp. 1101–1103, Sec. 4.1–4.2; Table 3 on p. 1102 (PDF pages 8–10)
- **Evidence:** "The average latency between the packages is calculated on the server" (p. 1101; sentence excerpt)
- **Basis:** full text (newly recovered local publisher PDF; abstract and Sec. 4 inspected during Task B)
- **Verification (Task B, 2026-10-03):** ✘ earlier abstract-only evidence superseded — local PDF pages 1 and 8–10 confirm printed pagination, experiment and arrival-interval definition. No exact graph values inferred. The prior acquisition gap is closed; see Related Work F22 for throughput, charge and efficiency limits.
- **Relevance:** supports / method caution — another native-WebSocket/MQTT experiment exists, but its reported delay is not directly comparable to the thesis’ sample-delivery latency. It does not include HTTP polling or Raspberry Pi CPU/RAM measurements.
- **Cite as (APA 7):** (Bayılmış et al., 2022, pp. 1101–1103)

### F32: A smart-room predecessor explicitly compares all three response times (publisher abstract)
- **Claim:** Kaur and Khanna implement MQTT, HTTP and WebSocket using a NodeMCU controller, sensors and Node-RED, and state that response-time delays were measured and compared. HTTP polling cadence, endpoint definitions, results and statistics remain unverified without the chapter.
- **Source:** [@kaur2022implementation]
- **Page / section:** Abstract, publisher chapter page (no page citation)
- **Evidence:** "The response time delays of all these protocols for the smart room test bed have been found and compared."
- **Basis:** abstract, read directly at https://link.springer.com/chapter/10.1007/978-3-030-89554-9_8; Crossref metadata rechecked
- **Verification (Task B, 2026-10-03):** ✔ verified — Publisher chapter abstract re-read directly; NodeMCU, Node-RED and the three-protocol response-time comparison match the quote. Full chapter remains subscription content and no publication-page finding is asserted.
- **Relevance:** extends — closes the previous title-only gap; acquisition remains priority 1. Do not claim the protocol triple itself is novel.
- **Cite as (APA 7):** (Kaur & Khanna, 2022)

### F33: The three protocols already appear in a Raspberry Pi comparative experiment
- **Claim:** Năstase et al. compare MQTT, HTTP REST and native WebSocket alongside three other protocols, using a Raspberry Pi 3 client, PC server and 100-Mbps LAN switch. Ten JSON messages are captured with Wireshark; reported MQTT average RTT is 0.448 ms. HTTP/WebSocket results appear graphically; exact values were not transcribed.
- **Source:** [@nastase2017experimental]
- **Page / section:** pp. 407–411; Fig. 13 visually inspected on p. 411
- **Evidence:** "MQTT and XMPP performed the best" (p. 411)
- **Basis:** full text, existing PDF, all ten pages read; DOI rechecked in Crossref
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed pp. 407–411 (PDF 5–9) confirm setup, ten JSON messages and stated MQTT 0.448 ms. Fig. 13 on p. 411 rendered and visually checked; no precise HTTP/WebSocket values inferred from bars. The conclusion is protocol coverage, not a definitive ranking.
- **Relevance:** supports — direct hardware/protocol precedent; the three-protocol comparison is already established.
- **Cite as (APA 7):** (Năstase et al., 2017, pp. 407–411)

### F34: Năstase's traffic and timing definitions leave comparability gaps
- **Claim:** MQTT splits measurements across four topics; HTTP uses separate write/query clients; WebSocket confirms client sends. Polling cadence, repeated runs, dispersion and clock uncertainty are not documented. The RTT definition on p. 407 mentions only travel from source to destination, without an operational timing procedure.
- **Source:** [@nastase2017experimental]
- **Page / section:** pp. 407–411 (Secs. 4–5)
- **Evidence:** "the other protocols write all topics in one message" (p. 411)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed pp. 407–411 confirm topic splitting, HTTP write/query clients and WebSocket confirmation; p. 407’s RTT description is source-to-destination only. No repeat/dispersion/clock/polling procedure found in Secs. 4–5. Quotation checked visually on p. 411.
- **Relevance:** gap — separate application sample identity from packet counts and match message layouts/endpoints in the thesis. The study measures latency and overhead but omits CPU/RAM and payload-format variation.
- **Cite as (APA 7):** (Năstase et al., 2017, pp. 407–411)

### F35: NTP uncertainty and repetitions are documented in a polling benchmark
- **Claim:** Pimentel and Nickerson check `ntpq -p` before and after tests: client offsets below 2 ms, server below 1 ms. They treat a 1-ms protocol difference as uncertain. Table 1 reports means and SD for 36 cases, each with 1,200 measurements, across four client locations.
- **Source:** [@pimentel2012communicating]
- **Page / section:** pp. 48–50
- **Evidence:** "the offset remained below 2 ms" (p. 48)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed pp. 48–50 confirm ntpq before/after checks, <2 ms client/<1 ms server offsets, uncertain 1 ms difference, 36 tests and N=1200 with mean/SD per Table 1.
- **Relevance:** method inspiration — validates checking NTP offsets alongside measurements; successive protocol runs leave network-state confounding.
- **Cite as (APA 7):** (Pimentel & Nickerson, 2012, pp. 48–50)

## Methodological gaps in related work
- **The protocol triple already has precedents.** [@nastase2017experimental] compares MQTT, HTTP REST and native WebSocket on Raspberry Pi hardware, but does not document periodic HTTP polling cadence. [@kaur2022implementation] confirms a further response-time comparison in its abstract; the chapter remains unacquired. The defensible gap is the combined four metric dimensions under the thesis' documented control conditions, not the presence of three protocols.
- **WebSocket mostly as a tunnel, not as a protocol of its own.** [@babovic2016web], [@enache2023mqttws], [@amirkhanov2025evaluating] measure MQTT *over* WebSocket; a native WebSocket data stream next to MQTT and HTTP polling is rare. [@almasri2020investigating] explicitly defers WebSocket to future work (p. 94907).
- **Polling interval not treated as a variable in IoT studies.** Polling-vs-push latency is studied in web engineering — [@vandevyvere2020comparing], [@pimentel2012communicating], [@lasocha2021comparison] — on servers/browsers, not on constrained gateways, and not together with MQTT. IoT studies with HTTP use request/response per sample without discussing interval matching — [@khaleefah2025empirical].
- **Inconsistent latency definitions.** Sender-side round trip [@khaleefah2025empirical], publisher→broker→subscriber return to the same host [@seoane2021performance], round-trip echo [@babovic2016web], time-to-completion [@silva2021performance], "latency on the client" incl. polling wait [@vandevyvere2020comparing]; unclear inclusion of connection set-up is criticised in [@almasri2020investigating] (p. 94901).
- **Clock handling varies.** Same-host placement in [@seoane2021performance] and [@babovic2016web]; NTP rejected in Babovic's configuration; cross-device timestamps without an operational clock-synchronisation procedure in [@silva2021performance]. The continuation identifies a positive counterexample: [@pimentel2012communicating] checks NTP offsets before/after tests and considers uncertainty when interpreting small differences (pp. 48–49).
- **Weak statistics.** Means without dispersion and no documented independent session repetition in [@khaleefah2025empirical]; second-hand numbers without method in [@enache2023mqttws]; no own measurements in [@naik2017choice]. Positive exceptions: [@silva2021performance] (10 runs, SD, CI), [@seoane2021performance] (95 % CI), [@gundogan2018ndn] (1,000 runs). No study read reports randomised test order.
- **Impairment only for CoAP/MQTT-type protocols.** netem-style loss/delay experiments in [@seoane2021performance], [@thangavel2014performance], [@liri2018robustness], [@chen2016performance] do not include HTTP polling or WebSocket.
- **Metric dimensions not combined.** [@seoane2021performance] combines latency, bandwidth and CPU, but for CoAP/MQTT only; [@khaleefah2025empirical] combines latency, overhead, delivery rate and energy, but without CPU/RAM, payload-format variation or WebSocket; [@mishra2021stress] combines latency and CPU for MQTT brokers only. No study read covers latency/loss + CPU/RAM + payload format + overhead for the thesis' three protocols in one hardware experiment.
- **Application context.** The reviewed RQ1 evidence includes PV [@tran2024analysis] and smart-home/smart-room prototypes [@joshi2017performance], [@kaur2022implementation], currently abstract-only. It does not establish the complete four-dimension comparison for a home energy-monitoring testbed. This is a screened-set limitation, not proof that no such study exists.

## Measurement implications from the continuation (agent synthesis, not locked decisions)

The recovered sources make endpoint consistency more important than a predicted protocol ranking. The following are operational suggestions derived from F7, F10, F14 and F33–F35; they do not change `docs/methodology.md` or introduce mandatory RQ5 conditions.

- **Sample delivery latency:** identify a replayed sample by `(device_id, sequence_id)`; record its availability at the emulator and its first receipt at the same consumer boundary for all protocols. State whether persistence/display is included. Calculate latency only for received unique samples.
- **HTTP request RTT:** record request start to response completion separately. A fast request can still return old data, so its duration is not interchangeable with sample delivery latency or data age.
- **Freshness and skipped samples:** record the generation/availability timestamp carried by the returned sample. A latest-value endpoint can overwrite samples between polls; classify these as sampling omissions, separately from failed HTTP requests and packet loss observed in a network capture. Pimentel's queued-sample endpoint preserves a different delivery contract.
- **Application delivery rate:** use eligible generated unique samples as the denominator and unique delivered sample IDs as the numerator. Predefine the end-of-run drain period or delivery deadline; report duplicates and late arrivals separately. A baseline of zero observed missing samples remains an answer within RQ1.
- **Clock uncertainty:** check and retain the configured NTP synchronisation evidence before and after each run; document its uncertainty when judging small differences. Pimentel's reported offsets are an example of a check, not a universal accuracy guarantee for this testbed. Additional synchronisation tooling is not required by this note.

## PDF page offsets
| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| bayilmis2022survey | 1094; printed = PDF page + 1093; pp. 1101–1103 = PDF pages 8–10 |
| seoane2021performance | 1 (article no. 108338, paginated 1–22) |
| silva2021performance | 1 (article no. 4879, "x of 30") |
| khaleefah2025empirical | 74 |
| babovic2016web | 6974 |
| mishra2021stress | 1 (article no. 5817, "x of 20") |
| enache2023mqttws | 46 |
| almasri2020investigating | 94880 |
| lasocha2021comparison | 67 |
| vandevyvere2020comparing | author version, own pagination 1–16; printed LNCS pages (87–101 per Crossref) not seen → cited by section |
| gundogan2018ndn | arXiv v3, no proceedings pagination (159–171 per Crossref not seen) → cited by section |
| naik2017choice | author-accepted manuscript without printed page numbers (proceedings pp. 1–7 per Crossref) → cited by section |
| nastase2017experimental | 403; pages 1–10 inspected locally, including visual check of Fig. 13 on printed p. 411 |
| pimentel2012communicating | 45; pages 1–9 inspected locally, ending at printed p. 53 |
| amirkhanov2025evaluating | 679; publisher PDF has 16 pages, Methods and Discussion inspected through web PDF extraction; no local PDF acquired |

## Cross-references (for other RQs)
- [Related work / RQ4, continuation] nastase2017experimental — all three target protocols already compared on Raspberry Pi 3; use the actual methodological gaps in F33–F34 to frame the contribution.
- [Related work, continuation] kaur2022implementation — publisher abstract confirms a native three-protocol response-time comparison; hardware NodeMCU/Node-RED; chapter acquisition remains essential.
- [RQ4, continuation] pimentel2012communicating — polling returns queued readings, which differs from latest-value retrieval and affects useful-byte counting; pp. 47–48.
- [RQ2] seoane2021performance — CPU usage of CoAP and MQTT per QoS level and cipher suite, measured with `perf` on a Raspberry Pi 3 (Sec. 6.1.2 and MQTT counterpart).
- [RQ2] mishra2021stress — CPU usage of six MQTT brokers at peak message rate per QoS level (Tables on pp. 11–12).
- [RQ2] vandevyvere2020comparing — server CPU and memory of HTTP polling vs. SSE as client numbers grow (Sec. 5.2, Sec. 6).
- [RQ2] khaleefah2025empirical — energy per message for MQTT/CoAP/HTTP on a Raspberry Pi 4 (Table I, p. 77); no CPU/RAM.
- [RQ2] werlinder2020comparing (already held by lit-rq2) — MQTT vs. WebSocket scalability; may also contain latency figures useful for RQ1. Not analysed here.
- [RQ3] babovic2016web — latency contribution of message encodings (XML, JSON, Protocol Buffers, AMF) incl. decoding times in the browser (Sec. VII-D, pp. 6986–6988).
- [RQ4] seoane2021performance — analytical and measured packet counts and bytes per message for each MQTT QoS level incl. TCP handshake/teardown (Sec. 5 and Sec. 6.2, pp. 12–18).
- [RQ4] khaleefah2025empirical — per-message overhead in bytes for MQTT/CoAP/HTTP (Table I, p. 77).
- [RQ4] enache2023mqttws — bytes for connect/subscribe/publish/disconnect, MQTT over TCP vs. over WebSocket (Table 5, p. 48); second-hand data.
- [RQ4] mijovic2016comparing — "protocol efficiency" (overhead ratio) for CoAP, WebSocket, MQTT; abstract only, on to-acquire list.
- [RQ4] naik2017choice — qualitative message-size/overhead ranking (Sec. IV-A).
- [RQ5 optional] seoane2021performance, liri2018robustness, chen2016performance, thangavel2014performance — netem/emulator designs for loss, delay and disruption.
- [Related work] almasri2020investigating, naik2017choice — protocol surveys; wytrebowicz2021messaging, mishra2020mqtt, manowska2022mqtt (PDFs already in `literature/pdfs/`, held by other agents) were only skimmed and contain no own latency/loss comparison of the three thesis protocols.
- [Related work] Tightiz & Yang (2020), "A Comprehensive Review on IoT Protocols' Features in Smart Grid Communication", Energies, DOI 10.3390/en13112762 — seen in search results only (not read); candidate for the energy-domain context.

## Open questions
- **Kaur & Khanna (2022):** response-time comparison and NodeMCU/Node-RED hardware are now confirmed from the publisher abstract. Acquire the chapter to verify timing endpoints, polling cadence and metrics. Alongside Năstase (2017), this rules out positioning the protocol triple alone as a new contribution; any stronger novelty claim still needs a broader review.
- **NTP accuracy:** given F17, should one-way latency in the thesis be complemented by an RTT-based or same-host measurement, and should chrony offsets be logged per run? This affects `docs/methodology.md` (currently: "NTP-synchronized timestamps") — decision for Felix, not changed here.
- **Loss definition for polling:** samples that are overwritten between two polls are not "lost packets" in the network sense. The thesis needs an explicit definition (see F7).
- **Baseline delivery:** keep the locked scope. A zero observed application-loss rate is a legitimate RQ1 result and should be reported with observation count and deadline. Netem resilience remains optional RQ5; a broader impairment experiment must not be silently moved into mandatory RQ1.
- **Source quality:** khaleefah2025empirical appears in a first-volume journal and contains editing artefacts (e.g. an unrelated sentence in the hardware description on p. 76); enache2023mqttws reports no own measurements. Both should be used as supporting, not primary, evidence.
- **Not verified in the continuation:** printed publication pagination for the author/preprint versions of Van de Vyvere, Gündoğan and Naik; abstract-only F24–F30 against publisher full texts; F31 is now checked against the recovered local Bayılmış PDF; the conference label "ICWE 2020". F23 is now checked against the Amirkhanov publisher PDF. Pimentel's publisher-format PDF has been acquired and verified as a nine-page PDF; its provenance is the academic CiteSeerX repository.
- **Search coverage:** the Semantic Scholar API was rate-limited (1 successful keyword query out of 7 attempts); OpenAlex and Crossref were used instead. IEEE Xplore and ACM DL were not queried directly (no API access); their content was reached only via Crossref/OpenAlex indexing. A manual IEEE Xplore query by Felix (`MQTT AND WebSocket AND HTTP AND latency`) would be a useful completeness check.
