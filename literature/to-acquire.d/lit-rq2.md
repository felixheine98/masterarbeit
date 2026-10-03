# To acquire — lit-rq2

Priority order (top = most valuable for RQ2). DOIs verified via Crossref on 2026-10-03. None of these has been read; nothing from them is cited with a page number in the findings.

| bibkey | Title | DOI | Why it matters |
|--------|-------|-----|----------------|
| lima2019performance | A Performance Evaluation of Raspberry Pi Zero W Based Gateway Running MQTT Broker for IoT (IEEE IEMCON 2019) | 10.1109/iemcon.2019.8936206 | Closest match to RQ2 found: CPU usage, temperature and received-message rate of an MQTT gateway on a Raspberry Pi under different QoS levels (per the IEEE Xplore search-result summary and the descriptions in ford2022performance p. 3 and gamess2022performance p. 820). Paywalled (IEEE Xplore). |
| koziolek2020comparison | A Comparison of MQTT Brokers for Distributed IoT Edge Computing (LNCS, Springer 2020) | 10.1007/978-3-030-58923-3_23 | Peer-reviewed broker comparison for edge deployments; expected to contain resource/scalability criteria for broker selection (Mosquitto vs. EMQX vs. HiveMQ etc.). Paywalled (SpringerLink). |
| gheorghepop2020performance | A Performance Benchmarking Methodology for MQTT Broker Implementations (IEEE QRS-C 2020) | 10.1109/qrs-c51114.2020.00090 | Methodology paper — could justify the thesis' measurement procedure (metrics, repetitions, load profiles). Paywalled (IEEE Xplore). |
| bender2021opensource | Open-Source MQTT Evaluation (IEEE CCNC 2021) | 10.1109/ccnc49032.2021.9369499 | Short TUM paper benchmarking open-source MQTT brokers; check for CPU/RAM figures and tooling. Paywalled (IEEE Xplore). |
| elhajj2024testing | Testing the Security and Performance of MQTT Protocol on Raspberry Pi for IoT Applications (IEEE APWiMob 2024) | 10.1109/apwimob64015.2024.10792961 | Recent Raspberry Pi MQTT performance study; check whether CPU/RAM are measured and with which tool. Paywalled (IEEE Xplore). |
| guaman2020comparative | Comparative Performance Analysis between MQTT and CoAP Protocols for IoT with Raspberry PI 3 in IEEE 802.11 Environments (CISTI 2020) | 10.23919/cisti49556.2020.9140905 | Raspberry Pi 3 protocol comparison in a home WLAN; cited by ford2022performance (p. 3). Check for resource metrics. Paywalled (IEEE Xplore). |
| dizdarevic2024benchmarking | Benchmarking Performance of Various MQTT Broker Implementations in a Compute Continuum (IEEE CCGrid 2024) | 10.1109/ccgrid59990.2024.00048 | Likely the peer-reviewed follow-up of the arXiv preprint dizdarevic2023engineering (Raspberry Pi broker testbed); would replace the preprint as citable source and may add resource metrics. Paywalled (IEEE Xplore). |
| tsaqief2025comparative | Comparative Performance Analysis Between the MQTT and WebSocket Protocols (bit-Tech 8(2), 2025) | 10.32877/bt.v8i2.3223 | Direct MQTT-vs-WebSocket comparison. Open access, but the journal site is behind a Cloudflare bot check — open the DOI in a browser and save the PDF. Low-tier venue; check quality before citing. |
| cui2017comparison | Comparison of IoT Application Layer Protocols (MSc thesis, Auburn University, 2017) | — (https://etd.auburn.edu/bitstream/handle/10415/5713/Pinchen_thesis.pdf) | Primary source behind the CPU/memory ranking reported in almasri2020investigating (p. 94901): CPU and memory of MQTT, CoAP, AMQP, DDS. Open repository, but the server timed out three times on 2026-10-03 — retry in a browser. |
| oliveira2018comparison | Comparison Between MQTT and WebSocket Protocols for IoT Applications Using ESP8266 (IEEE MetroInd4.0&IoT 2018) | 10.1109/metroi4.2018.8428348 | Only MQTT-vs-WebSocket device-side study found in an IEEE venue. **ESP8266 microcontroller — context only, not equivalent evidence for the Raspberry Pi** (see scope rules). Low priority. Paywalled. |

## Optional: published versions of preprints that were read (for printed page numbers)

| bibkey | Published version | DOI | Note |
|--------|-------------------|-----|------|
| paul2026benchmarking | IEEE CCGrid 2026, pp. 472–481 | 10.1109/ccgrid68966.2026.00056 | Findings currently cite sections of arXiv:2603.21600v1. |
| kumar2019implementation | Computer Networks 150 (2019), pp. 28–45 | 10.1016/j.comnet.2018.12.012 | Findings currently cite sections of arXiv:1810.07730v2. |
| saif2021pure | IEEE CSCN 2021, pp. 36–39 | 10.1109/cscn53733.2021.9686113 | Findings currently cite sections of arXiv:2106.12684v3. |

Task B retrieval (2026-10-03): `bayilmis2022survey` is now available at `literature/pdfs/bayilmis2022survey.pdf`; legal publisher copy from Karabük University. Removed from outstanding acquisitions. Full-text findings: `related-work.md` F22.
