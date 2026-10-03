# Findings — RQ2: CPU/RAM resource consumption of MQTT, HTTP polling and WebSockets on the Raspberry Pi

Agent: lit-rq2 · Last updated: 2026-10-03

## Summary

The literature that actually *measures* CPU and memory of IoT application protocols on Raspberry-Pi-class Linux hardware is thin and fragmented. Resource figures exist mainly for **MQTT brokers** — and there mostly on PCs, cloud VMs or containers that only emulate Raspberry Pi resource limits (Mishra et al., 2021; Paul et al., 2026) — while the studies that do use real Raspberry Pis usually report only latency/throughput and no CPU/RAM at all (Ford et al., 2022; Dizdarević et al., 2023; Silva et al., 2021). The few Raspberry Pi studies with resource data either cover other protocol pairs (MQTT vs. CoAP: Seoane et al., 2021; MQTT over TCP vs. QUIC: Kumar & Dezfouli, 2019) or rely on a single run. **No source was found in this screened evidence set that compares MQTT, HTTP polling and WebSockets for CPU and RAM on a Raspberry Pi within one experiment**; the only direct MQTT-vs-WebSocket resource comparison with full text is a master's thesis on AWS EC2 with different broker runtimes (Werlinder, 2020). Measurement methods are heterogeneous (perf CPU cycles, `top`, `ps` at 100 ms, Docker Stats at 1 s, CloudWatch at 1 min, or not stated), repetitions range from one to ten, and **no peer-reviewed methodological paper on psutil-based sampling was found** — the thesis' psutil approach can be justified from the tool documentation and by analogy to the process-level sampling used in these studies. This supports the thesis' novelty argument, but it also means the related-work basis for RQ2 is weaker than for the other RQs until the paywalled items (especially `lima2019performance`) are read.

Evidence classes used below: **[RPi]** real Raspberry Pi hardware · **[PC/VM]** desktop, cloud or container hardware · **[grey]** not peer-reviewed (thesis, preprint, documentation).

## Findings

### A. Resource measurements on real Raspberry Pi hardware

### F1: CPU cost of MQTT on a Raspberry Pi 3 is dominated by security mode, not by QoS level
- **Claim:** On a Raspberry Pi 3 acting as MQTT publisher (Mosquitto), enabling TLS raised CPU use by roughly 27 % (PSK) to 36 % (PKI), whereas the QoS level made no visible difference to CPU use. The authors themselves doubt whether their tool captured kernel-side TCP processing.
- **Source:** [@seoane2021performance]
- **Page / section:** p. 15 (QoS/CPU result and caveat), p. 21 (percentages)
- **Evidence:** "CPU usage by TCP may not being monitored by PERF tool." (p. 15)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 15 confirms the authors’ QoS result and perf/kernel caveat; p. 21 reports 27%/36% TLS CPU-cycle increases. This is relative CPU-cycle cost, not percentage-point utilization or measured energy.
- **Relevance:** extends — closest peer-reviewed Raspberry Pi CPU study, but MQTT vs. CoAP only (no HTTP, no WebSocket); warns that a per-process metric can miss kernel network-stack work, which matters when comparing protocols with different transport behaviour.
- **Cite as (APA 7):** (Seoane et al., 2021, p. 15)

### F2: Seoane et al. measure CPU as perf CPU cycles of the protocol process, not as utilisation percentage or RAM
- **Claim:** Seoane et al. quantify CPU cost using Linux perf CPU cycles/instructions over 500 CoAP requests or MQTT messages; the monitored MQTT process is explicitly the publisher application on the Raspberry Pi. CPU results use average cycles per exchange with 95% confidence intervals, rather than a utilisation percentage. Memory is not measured, and the authors concede that a Raspberry Pi 3 is not really a constrained device.
- **Source:** [@seoane2021performance]
- **Page / section:** p. 10 (tool), p. 13 (confidence intervals), p. 8 (device choice)
- **Evidence:** "With respect to CPU usage analysis, PERF tool for Raspberry Pi OS was employed." (p. 10)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ generic client-process attribution was too broad; explicitly distinguished MQTT publisher and cycle metric — Printed p. 10 describes perf CPU cycles/instructions over 500 requests/messages and explicitly identifies the MQTT publisher process; p. 13 defines averaged CPU cycles per exchange and 95% CIs; p. 8 qualifies the device as non-constrained.
- **Relevance:** method inspiration — shows process-scoped CPU accounting on a Raspberry Pi and CI reporting; a different metric (cycles) than the thesis' psutil percentage, so absolute numbers are not comparable.
- **Cite as (APA 7):** (Seoane et al., 2021, p. 10)

### F3: Broker CPU and memory on a Raspberry Pi 3 measured with `top` — from a single run
- **Claim:** Kumar and Dezfouli run subscriber, publisher and Mosquitto-based broker on Raspberry Pi 3 Model B boards and record the broker's memory usage and processor utilisation with `top` while 100 connections each send one message per second. The resource curves come from one experiment; the comparison is MQTT over TCP vs. MQTT over QUIC, not across application protocols.
- **Source:** [@kumar2019implementation]
- **Page / section:** Sec. IV (testbed), Sec. IV-C (resource measurement) — arXiv v2, journal page numbers UNVERIFIED
- **Evidence:** "Both figures present the results of a single experiment" (Sec. IV-C)
- **Basis:** full text (arXiv version of the Computer Networks article)
- **Verification (Task B, 2026-10-03):** ✔ verified — ArXiv Sec. IV (PDF 12) confirms Raspberry Pi 3 and repeat/median timing procedure; Sec. IV-C (PDF 14) confirms top, 100 connections, 1 msg/s per connection, restart-triggered half-open connections and a single resource experiment. Quote shortened to one sentence; no journal-page mapping inferred.
- **Relevance:** method inspiration / gap — precedent for time-series CPU and RAM of a broker on a Raspberry Pi at a 1 msg/s per-connection rate (similar order of magnitude to a home-monitoring send interval), but without repetition or dispersion measures.
- **Cite as (APA 7):** (Kumar & Dezfouli, 2019, Sec. IV-C)

### F4: Raspberry Pi MQTT studies frequently omit CPU/RAM altogether
- **Claim:** Ford et al. benchmark Raspberry Pi Zero W, Zero 2 W and 3B as Mosquitto brokers and clients, but restrict the metrics to transmission time and throughput; they also state that little work on MQTT performance on Raspberry Pi exists. The same pattern holds for Dizdarević et al., who build a three-node Raspberry Pi (Cortex-A72, 8 GB) broker testbed and report response times only.
- **Source:** [@ford2022performance]; [@dizdarevic2023engineering]
- **Page / section:** Ford: p. 3; Dizdarević: Sec. III (testbed), Abstract/Sec. IV (metrics)
- **Evidence:** "We focused on two parameters, namely the transmission time and throughput." (Ford et al., 2022, p. 3); "The hardware configuration of the testbed mainly consists of three Raspberry Pis (ARM Cortex A72, 8GB) and one server" (Dizdarević et al., 2023, Sec. III)
- **Basis:** full text (Ford: publisher PDF; Dizdarević: arXiv preprint; publication status not established by this full-text reading)
- **Verification (Task B, 2026-10-03):** ✘ “not peer-reviewed” inferred from preprint alone; changed to publication status not established by this reading — Ford printed p. 3 confirms transmission time/throughput; Dizdarević author version Sec. III-A (PDF 2) confirms Cortex-A72/8GB hardware and Sec. IV reports timing. No protocol-process CPU/RAM measurement found in their evaluations.
- **Relevance:** supports — documents the gap RQ2 fills: Raspberry Pi protocol benchmarks exist, but resource consumption on the device is not part of them.
- **Cite as (APA 7):** (Ford et al., 2022, p. 3); (Dizdarević et al., 2023, Sec. III)

### B. Broker resource benchmarks on non-Raspberry-Pi hardware

### F5: The tested Mosquitto version saturates one core on a PC benchmark
- **Claim:** In a stress test of six brokers on a PC testbed and on Google Cloud, Mosquitto 1.4.15 reached about 32,000 msg/s at QoS 0 with an average process CPU usage of 84.29 % of one core (local testbed). Because Mosquitto is single-threaded, the authors recommend it (or Bevywise) over the scalable brokers when hardware is resource-constrained.
- **Source:** [@mishra2021stress]
- **Page / section:** p. 11 (Table 6), p. 17 (recommendation)
- **Evidence:** "Mosquitto or Bevywise MQTT Route can be taken as better choices over other scalable brokers." (p. 17)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ heading treated a PC result as a Pi ceiling and relevance predicted small CPU differences; narrowed to implementation evidence and testable expectation — Printed p. 11 Table 6 confirms 32016 msg/s and 84.29% local process CPU for Mosquitto 1.4.15; p. 17 recommends non-scalable brokers on constrained hardware. Neither Pi capacity nor household-load CPU differences were measured here.
- **Relevance:** supports — the authors’ constrained-hardware recommendation supports selecting Mosquitto. This PC/cloud test does not establish the Raspberry Pi’s capacity or predict absolute CPU differences at six-device household load; these need measurement in the thesis.
- **Cite as (APA 7):** (Mishra et al., 2021, p. 17)

### F6: Mishra et al. define "process CPU usage" but do not name the tool, do not measure memory, and report the best of three samples
- **Claim:** CPU is reported as average process (non-scalable brokers) or system (scalable brokers) CPU usage, defined via a web article rather than a named measurement tool; RAM is not a metric. Per QoS level three samples were taken and only the best one was used.
- **Source:** [@mishra2021stress]
- **Page / section:** p. 2 (metrics), p. 10 (sampling), p. 13 (definition)
- **Evidence:** "We had taken 3 samples for each QoS in each segment and the best result with the maximum rate of message delivery, and zero message drop was considered for comparison." (p. 10)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 10 confirms best-of-three selection; p. 13 defines process CPU via [40] and later system CPU for scalable brokers. Full-text check found no named CPU measurement utility or RAM outcome.
- **Relevance:** contradicts good practice / gap — best-of-three selection without dispersion is exactly what the thesis' design (randomised order, repeated runs, mean ± SD) improves on.
- **Cite as (APA 7):** (Mishra et al., 2021, p. 10)

### F7: Existing broker evaluations overlook CPU and memory footprint; container-level sampling at 1 s is used to close that gap
- **Claim:** Paul et al. argue that existing message-broker evaluations focus on throughput and latency and overlook CPU/memory footprint. They sample the broker container's CPU usage and resident set size via the Docker Stats API at 1-second intervals, on VMs sized to mirror Raspberry-Pi-class hardware (1 vCPU/2 GB to 4 vCPU/8 GB) — not on physical Raspberry Pis.
- **Source:** [@paul2026benchmarking]
- **Page / section:** Abstract; Sec. IV-B (metrics); Sec. IV-C (VM configurations) — arXiv v1, proceedings page numbers UNVERIFIED
- **Evidence:** "Broker container CPU usage as a percentage of allocated vCPUs, sampled via Docker [28] Stats API at 1-second intervals." (Sec. IV-B)
- **Basis:** full text (arXiv preprint; a proceedings version exists at IEEE CCGrid 2026 but was not read)
- **Verification (Task B, 2026-10-03):** ✔ verified — ArXiv Sec. IV-B/C (PDF 5) confirms Docker Stats, 1 s sampling, RSS and VM resource limits; abstract states the resource-footprint gap. Table III nonetheless lists earlier studies with resource metrics, so this does not prove all previous work omitted resources.
- **Relevance:** method inspiration — precedent for (a) isolating the measured component, (b) reporting RSS as the memory metric, (c) a 1 s sampling interval; and supports the claim that resource footprint is under-reported. **[PC/VM]**.
- **Cite as (APA 7):** (Paul et al., 2026, Sec. IV-B)

### F8: Under Raspberry-Pi-like limits Mosquitto stays stable but its memory grows with load; JVM/BEAM brokers need far more RAM
- **Claim:** In Sec. V-B, the authors describe Mosquitto as stable up to about 10K msg/s on 1 vCPU/2 GB, while HiveMQ and Artemis consume 487 MB and 1.3 GB. The same section later says Mosquitto improves from 26K to 40K msg/s from VM1 to VM2, which conflicts with that 10K ceiling. Its reported memory rises to 284–308 MB (2 vCPU/4 GB) and 500–620 MB (4 vCPU/8 GB). Treat the memory values as conditional reported results and the VM1 throughput ceiling as unresolved source inconsistency.
- **Source:** [@paul2026benchmarking]
- **Page / section:** Sec. V-B (Throughput vs Client Scaling) — arXiv v1
- **Evidence:** "Mosquitto’s single-threaded architecture caps it at around 10K msg/s, but it remains stable within that range." (Sec. V-B)
- **Basis:** full text (arXiv preprint)
- **Verification (Task B, 2026-10-03):** ✘ source contradicts its own 10K/26K baseline; 10K cannot be used as an unqualified measured ceiling — ArXiv Sec. V-B (PDF 7–8) confirms the cited memory values and a 10K msg/s VM1 statement. The same section later describes VM1 Mosquitto as 26K msg/s; this source-internal throughput discrepancy is now explicit.
- **Relevance:** extends — gives an order of magnitude for broker RAM that the thesis can contrast with its own low-load Raspberry Pi 4 measurements; shows memory is load-dependent, so RAM must be sampled over the whole run rather than once. **[PC/VM]**, thousands of client pairs — far above the thesis' six devices.
- **Cite as (APA 7):** (Paul et al., 2026, Sec. V-B)

### C. WebSocket and HTTP in resource comparisons

### F9: The only full-text MQTT-vs-WebSocket resource comparison found is a master's thesis on AWS — and the implementation confounds the protocol
- **Claim:** Werlinder compares an EMQX (MQTT) broker cluster with a Socket.IO (WebSocket) cluster plus Redis on AWS EC2 and concludes that WebSocket is better for memory usage and CPU utilisation and MQTT for network usage. Clients differ as well (paho-mqtt in Python vs. socket.io-client in JavaScript), so the result mixes protocol and runtime effects. Metrics come from CloudWatch at one-minute resolution, averaged over an eight-minute peak window.
- **Source:** [@werlinder2020comparing]
- **Page / section:** p. iii (abstract), p. 19 (clients), p. 20 (data collection), p. 21 (averaging window), p. 38 (CloudWatch interval, validity)
- **Evidence:** "The findings of this study indicate that WebSocket is best suited for memory usage and CPU utilization." (p. iii)
- **Basis:** full text — **[grey]** master's thesis, **[PC/VM]**
- **Verification (Task B, 2026-10-03):** ✘ relevance overclaimed that the ranking exists only in grey literature; narrowed to the reviewed full texts — Local thesis PDF 5 = p. iii; PDFs 29/30/31/48 = printed pp. 19/20/21/38 confirm runtime/client mismatch, Redis, CloudWatch and eight-minute peak averaging. Only this inspected evidence set supports the grey-literature observation.
- **Relevance:** extends / gap — among the inspected full texts, this MQTT-vs-WebSocket CPU/RAM ranking comes from grey literature, on cloud instances, at thousands of connections and with coarse sampling; the thesis tests whether any such ranking holds on a Raspberry Pi at household scale with one language (Python) for all clients.
- **Cite as (APA 7):** (Werlinder, 2020, p. iii)

### F10: Process-level sampling at 100 ms shows an HTTP-based pub/sub design costing more device CPU and memory than an MQTT-based one
- **Claim:** In VirtualBox VMs, Saif and Matrawy compare HTTP/3 publish–subscribe with MQTT-over-QUIC. They sample ps every 100 ms and define CPU as CPU time over process duration. Profiling reports roughly ten times the total heap bytes allocated for H3, primarily from X.509/TLS handling; this is an allocation metric, not live heap or RSS. H3 also has higher and less predictable CPU use in that implementation.
- **Source:** [@saif2021pure]
- **Page / section:** Sec. V (setup), Sec. VI-C (device overhead), Sec. VII (conclusions) — arXiv v3, proceedings page numbers UNVERIFIED
- **Evidence:** "H3 used approximately 10 times the memory as MQTT-over-QUIC." (Sec. VI-C; metric explained as total allocated heap bytes in the preceding paragraph)
- **Basis:** full text (arXiv version of the IEEE CSCN 2021 paper)
- **Verification (Task B, 2026-10-03):** ✘ allocation metric conflated with memory footprint and lifetime ps CPU conflated with psutil interval CPU; corrected — ArXiv Secs. V and VI-C (PDF 2–4) confirm VirtualBox, 100 ms ps sampling, process-lifetime CPU ratio and profiling. Memory metric is total heap bytes allocated, not instantaneous RSS/live heap.
- **Relevance:** method inspiration — precedent for 100 ms process observation and implementation confounds. ps lifetime CPU percentage and psutil interval CPU percentage both relate CPU time to wall time, but their averaging windows differ and their values are not automatically interchangeable. HTTP/3/QUIC is indirect evidence for HTTP/1.1 polling. **[PC/VM]**.
- **Cite as (APA 7):** (Saif & Matrawy, 2021, Sec. VI-C)

### F11: Survey-level CPU/memory rankings rest on very few primary studies and exclude HTTP and WebSocket
- **Claim:** The IEEE Access survey by Al-Masri et al. can cite only one study for CPU and memory consumption (an MSc thesis covering MQTT, CoAP, AMQP and DDS — MQTT lowest in memory, CoAP lowest in CPU) and one for power (HTTP 5.3× MQTT). The authors themselves note that the underlying studies differ in test environment, QoS settings and whether initialisation is included.
- **Source:** [@almasri2020investigating]
- **Page / section:** p. 94901 (subsection D.3 "Performance comparison on CPU, memory and power consumption" under "Scalability & Performance")
- **Evidence:** "these studies varied in the degree to which the testing environments were deployed" (p. 94901)
- **Basis:** full text (section read; remainder of the 32-page survey only screened)
- **Verification (Task B, 2026-10-03):** ✔ verified — Printed p. 94901 (PDF 22), subsection D.3, cites one CPU/memory study and one power study and discusses environment/QoS/initialization differences. CPU/memory ranking omits HTTP/WebSocket, while HTTP does appear in power comparison.
- **Relevance:** supports — an authoritative statement that CPU/memory evidence is sparse and not comparable across studies; neither HTTP nor WebSocket appears in the CPU/memory ranking.
- **Cite as (APA 7):** (Al-Masri et al., 2020, p. 94901)

### D. Measurement methodology

### F12: psutil's per-process CPU percentage needs a defined interval; the first non-blocking reading must be discarded
- **Claim:** `Process.cpu_percent()` either blocks for a given interval and compares CPU times before and after, or (non-blocking) returns utilisation since the previous call; the first non-blocking call returns a meaningless 0.0, at least 0.1 s between calls is recommended for accuracy, and values above 100 % are possible for multi-threaded processes because the value is not divided by the core count.
- **Source:** [@rodola2026psutil]
- **Page / section:** Official stable psutil 7.2.2 documentation, `Process.cpu_percent(interval=None)`, https://psutil.readthedocs.io/stable/#psutil.Process.cpu_percent (no pagination; accessed 2026-10-03)
- **Evidence:** "at least 0.1 seconds between calls"
- **Basis:** full text — **[grey]** software documentation
- **Verification (Task B, 2026-10-03):** ✘ quote/version did not match current inspected documentation; corrected using the stable API entry — Re-read official stable psutil 7.2.2 Process.cpu_percent entry at https://psutil.readthedocs.io/stable/#psutil.Process.cpu_percent: first non-blocking sample, >=0.1 s recommendation and >100% process semantics match. Replaced the non-verbatim earlier quote and development-version label.
- **Relevance:** method inspiration — fixes three reporting requirements for the thesis: state the sampling interval (≥ 0.1 s; 1 s as in Paul et al. is defensible), drop the priming sample, and state whether CPU is per core (0–400 % on a Raspberry Pi 4) or normalised.
- **Cite as (APA 7):** (Rodola, 2026, `Process.cpu_percent`)

### F13: psutil RSS maps to top RES; cross-study comparability still depends on measurement scope
- **Claim:** `Process.memory_info()` returns `rss` and `vms` as the portable fields; on UNIX `rss` matches the RES column of `top` and `vms` the VIRT column.
- **Source:** [@rodola2026psutil]
- **Page / section:** Official stable psutil 7.2.2 documentation, `Process.memory_info()`, https://psutil.readthedocs.io/stable/#psutil.Process.memory_info (no pagination; accessed 2026-10-03)
- **Evidence:** "this is the non-swapped physical memory a process has used."
- **Basis:** full text — **[grey]** software documentation
- **Verification (Task B, 2026-10-03):** ✘ non-verbatim quotation and unconditional cross-tool comparability corrected — Re-read official stable psutil Process.memory_info entry: portable rss/vms, byte units and UNIX top RES/VIRT mapping match. Replaced the non-verbatim quote; comparability with other tools requires matching counter scope and semantics.
- **Relevance:** method inspiration — reporting RSS and bytes/MiB provides a defined process-memory measure. Comparison with top or container metrics requires the same counter semantics, component scope and sampling window; matching names alone does not establish equivalence. Shared pages also limit sums/comparisons across processes.
- **Cite as (APA 7):** (Rodola, 2026, `Process.memory_info`)

### F14: Repetition counts in comparable Raspberry Pi studies cluster around ten runs with averaging
- **Claim:** Raspberry Pi protocol benchmarks that report their procedure repeat each experiment at least ten times and average (Ford et al.; Dizdarević et al.; Silva et al., who additionally report standard deviation, min/max, median and confidence interval); Kumar and Dezfouli use the median of 10 experiments × 10 iterations with at least five minutes between experiments for their timing metrics.
- **Source:** [@ford2022performance]; [@dizdarevic2023engineering]; [@silva2021performance]; [@kumar2019implementation]
- **Page / section:** Ford p. 6; Dizdarević Sec. IV; Silva p. 19; Kumar Sec. IV
- **Evidence:** "each experiment was conducted several times (minimum 10 times), and the results depicted in the figures correspond to the performance results averaged from the repeated experimental runs." (Ford et al., 2022, p. 6)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ precedent presented as a validated lower bound; narrowed to design precedent — Ford p. 6 confirms >=10 averaged repetitions; Dizdarević Sec. IV (PDF 4), Silva p. 19 and Kumar Sec. IV (PDF 12) confirm the stated repeat counts/statistics. The studies provide precedents, not a statistical justification that n=10 is sufficient for this thesis.
- **Relevance:** method inspiration — ten repeated runs are a documented precedent in these studies, not a statistically validated minimum for this thesis. Choose repetitions and report dispersion for the thesis’ own variability and uncertainty.
- **Cite as (APA 7):** (Ford et al., 2022, p. 6); (Silva et al., 2021, p. 19)

### F15: Two inspected Raspberry Pi benchmarks use the Lite OS image
- **Claim:** Both Raspberry Pi benchmark papers from Jacksonville State University run Raspberry Pi OS Lite, a minimal image without desktop environment, and average repeated runs. Neither isolates or reports the residual OS load quantitatively.
- **Source:** [@gamess2022performance]; [@ford2022performance]
- **Page / section:** Gamess & Hernandez p. 821; Ford et al. p. 5
- **Evidence:** "The “Lite” option is a minimal image consisting of 493 packages without an X-window manager." (Gamess & Hernandez, 2022, p. 821)
- **Basis:** full text
- **Verification (Task B, 2026-10-03):** ✘ heading generalised two studies into usual practice; narrowed to the two inspected benchmarks — Gamess printed p. 821 (PDF 3) explicitly chooses Lite/headless and describes 493 packages; Ford p. 5 chooses Lite and p. 6 averages repeated runs. No residual OS-load quantification found; neither source isolates the causal effect of choosing Lite.
- **Relevance:** method inspiration — supports using Raspberry Pi OS Lite and, beyond that, measuring per process (psutil `Process`) plus an idle baseline, since system-wide figures on a Raspberry Pi that also runs InfluxDB/Next.js would mix in unrelated load.
- **Cite as (APA 7):** (Gamess & Hernandez, 2022, p. 821)

## Methodological gaps in related work

- **No three-way comparison on the target hardware found in the inspected evidence.** No inspected source measures CPU and RAM of MQTT, HTTP polling and WebSockets on a Raspberry Pi in one experiment. Raspberry Pi resource studies cover MQTT vs. CoAP [@seoane2021performance] or MQTT/TCP vs. MQTT/QUIC [@kumar2019implementation]; the MQTT-vs-WebSocket comparison is on EC2 [@werlinder2020comparing]; the HTTP-vs-MQTT one is HTTP/3 on VMs [@saif2021pure].
- **Raspberry Pi benchmarks without resource metrics.** [@ford2022performance], [@dizdarevic2023engineering], [@silva2021performance] and [@gentile2024performance] use Raspberry Pi 3/4/Zero hardware but report only time-based metrics.
- **Resource benchmarks without Raspberry Pi.** [@mishra2021stress] (PC + GCP) and [@paul2026benchmarking] (cloud VMs "mirroring" Raspberry Pi limits) infer suitability for constrained devices from x86 hardware.
- **Broker-centric view.** Resource figures concern the broker/server almost exclusively; client-side cost (e.g. paho-mqtt vs. an HTTP polling loop vs. a WebSocket client in Python) is measured only for the publisher process in [@seoane2021performance] and [@saif2021pure], the inspected sources do not establish a matched Python-client comparison across all three protocols.
- **Stress-test load levels.** Broker studies operate at 10³–10⁵ msg/s and hundreds to thousands of clients [@mishra2021stress; @paul2026benchmarking; @werlinder2020comparing]; none reports resource use at household scale (a handful of devices, one message every few seconds), where idle/keep-alive and polling overhead rather than throughput dominate.
- **Measurement tool unclear or coarse.** [@mishra2021stress] names no tool; [@werlinder2020comparing] relies on one-minute CloudWatch data; [@seoane2021performance] may miss kernel TCP processing (p. 15).
- **Single runs / selective reporting.** Resource curves from one experiment [@kumar2019implementation]; best of three samples [@mishra2021stress, p. 10]; no dispersion for CPU/RAM in [@werlinder2020comparing].
- **Implementation confounds.** Protocol comparisons use different runtimes per protocol (Erlang EMQX vs. Node.js Socket.IO, Python vs. JavaScript clients [@werlinder2020comparing]; TLS/X.509 handling dominating HTTP/3 cost [@saif2021pure]); the survey level confirms that environments and settings differ between studies [@almasri2020investigating, p. 94901].
- **Memory rarely reported.** Of the peer-reviewed Raspberry Pi studies read, only [@kumar2019implementation] reports RAM; [@seoane2021performance] and [@mishra2021stress] report CPU only.
- **No validated psutil methodology.** No peer-reviewed source on accuracy, sampling interval or observer overhead of psutil / `/proc`-based sampling on single-board computers was found (two dedicated searches). Only the tool documentation [@rodola2026psutil] is available.

## PDF page offsets

| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| seoane2021performance | 1 (article no. 108338, pages 1–22; offset 0) |
| mishra2021stress | 1 ("1 of 20", article no. 5817; offset 0) |
| ford2022performance | 1 (offset 0) |
| almasri2020investigating | 94880 (printed = PDF page + 94879; PDF p. 22 = p. 94901) |
| gamess2022performance | 819 (printed = PDF page + 818; PDF p. 3 = p. 821) |
| werlinder2020comparing | front matter roman (PDF p. 5 = p. iii); body printed = PDF page − 10 (PDF p. 29 = p. 19, PDF p. 48 = p. 38) |
| silva2021performance | 1 ("1 of 30", article no. 4879; offset 0) |
| babovic2016web | 6974 (printed = PDF page + 6973; PDF p. 10 = p. 6983) |
| paul2026benchmarking | no printed pagination (arXiv v1) — cited by section |
| dizdarevic2023engineering | no printed pagination (arXiv v1) — cited by section |
| kumar2019implementation | arXiv v2 pagination 1–19 ≠ journal pp. 28–45 — cited by section |
| saif2021pure | no printed pagination (arXiv v3) ≠ proceedings pp. 36–39 — cited by section |
| rodola2026psutil | web documentation — cited by API entry |

## Cross-references (for other RQs)

- [RQ1] `silva2021performance` — MQTT/CoAP/OPC UA time-to-completion on a Raspberry Pi 3 testbed and FIT-IoT; 10 repetitions with AVG/STDEV/CI (pp. 18–19). No CPU/RAM.
- [RQ1, RQ3] `babovic2016web` — latency of WebSocket vs. HTTP long-polling/polling and of message encodings (XML, JSON, Protocol Buffers etc.) for IoT web applications; server is an Intel i5-3320M machine with 4 GB RAM (p. 6983), not constrained hardware. No CPU/RAM.
- [RQ1] `gentile2024performance` — MQTT vs. MQTTS message transit time on two Raspberry Pi 4 (8 GB) behind an OpenWrt router; no CPU/RAM metrics found in the text.
- [RQ1, RQ5] `dizdarevic2023engineering` — broker response time under emulated delay/variance/packet loss on Raspberry Pis (Sec. IV); useful netem-style precedent.
- [RQ1] `ford2022performance` — transmission time and throughput vs. payload size, QoS, TLS and WiFi bandwidth on Raspberry Pi Zero W / Zero 2 W / 3B.
- [RQ4] `seoane2021performance` — bandwidth and packet counts per message exchange for MQTT QoS 0–2 with/without TLS (pp. 13–15), captured with Wireshark.
- [RQ4] `werlinder2020comparing` — network usage of MQTT vs. WebSocket brokers (MQTT lower; p. iii).
- [Related Work] `wytrebowicz2021messaging` — qualitative comparison of messaging protocols incl. HTTP and WebSocket as carriers; no measurements.
- [Related Work] `almasri2020investigating` — broad survey of IoT messaging protocols; only p. 94901 was read in detail here.
- [Related Work / RQ2 context] `naik2017choice` (PDF collected by another agent) — relative, non-experimental ranking in which HTTP requires the highest power and resources (Fig. 3, subsection B "Power Consumption vs. Resource Requirement" of the author manuscript). Not added to this agent's bib; whoever owns the entry should note that the ranking is derived from literature, not measured.
- [RQ4 owner / lit-verifier] `mishra2026performance` = existing source IJRASET DOI 10.22214/ijraset.2026.77541 — reports "CPU Energy Usage (%)" for MQTT, CoAP and HTTP, but from an **NS-3 simulation**, not a device measurement, and its parameter table on p. 885 still contains unfilled template placeholders ("[Insert Number, e.g., 20 Nodes]", "[Insert Time, e.g., 200s]"). The CPU figures should not be used as evidence for RQ2, and the source's reliability for RQ4 should be re-checked.
- [existing sources] PMC10224120 (power consumption MQTT vs. HTTP; another agent holds the full text as `jaraochoa2023power`) and Viswanathan (power consumption of MQTT) concern energy rather than CPU/RAM; they are adjacent to RQ2 only through the "CPU as proxy for energy" argument made by Seoane et al. (2021, p. 1).

## Open questions

- **Is CPU/RAM measured on the Raspberry Pi as a whole or per process, and for which processes?** The literature suggests per-process (broker / server and client separately) plus an idle baseline; the HTTP and WebSocket server implementations to be measured should be fixed in `docs/methodology.md` so that the three protocols share one language/runtime where possible (see the confound in F9).
- **Kernel-side cost.** Per-process user+system time may under-represent TCP/network-stack work (F1). Should a system-wide `psutil.cpu_times()` delta be recorded alongside the per-process values?
- **Sampling interval.** 100 ms (Saif & Matrawy) vs. 1 s (Paul et al.) vs. psutil's ≥ 0.1 s recommendation — no source quantifies the observer overhead of psutil itself on a Raspberry Pi. A short self-measurement (sampler on/off) would close this.
- **Unread key sources.** `lima2019performance` (CPU usage of an MQTT gateway on a Raspberry Pi Zero W), `koziolek2020comparison`, `gheorghepop2020performance`, `bender2021opensource`, `elhajj2024testing`, `guaman2020comparative`, `dizdarevic2024benchmarking`, `cui2017comparison`, `tsaqief2025comparative` are on the to-acquire list; the summary above may need revision once they are read — in particular the "no three-way comparison" statement should be re-checked against `tsaqief2025comparative`. Bayılmış’s recovered full text is now inspected in RQ1 F31 and Related Work F22; its experiment reports hardware specifications, not CPU/RAM consumption.
- **Energy.** RQ2 is locked to CPU/RAM (the INA219 energy RQ was replaced). Several sources treat CPU as a proxy for energy; should the thesis state this explicitly as a limitation rather than a claim?
- **Preprint status.** `dizdarevic2023engineering` is an arXiv-only preprint; `paul2026benchmarking`, `kumar2019implementation` and `saif2021pure` were read as arXiv versions of peer-reviewed papers — page numbers of the published versions are still to be verified.
