# Thesis Overview

## Basics
- Master's thesis, Web Engineering & IT Solutions (part-time), FH Kufstein
- Written in English
- Submission window: roughly mid-November to mid-May
- Author works professionally as IT Manager (cosmetics company)
- Title: *Evaluation of IoT Communication Protocols for Home-Based Energy Monitoring Systems: A Comparative Analysis of MQTT, HTTP Polling, and WebSockets*
- Novelty: four metric dimensions within a single consistent hardware experiment

## Research questions
- **RQ1** Latency and packet loss across protocols
- **RQ2** CPU/RAM resource consumption on the Raspberry Pi (psutil-based)
- **RQ3** Payload-format comparison (JSON vs. CBOR/Protobuf) — replaced the earlier edge-energy RQ (INA219/INA226)
- **RQ4** Protocol overhead and efficiency ratio (Wireshark/tcpdump; per-message header overhead plus full-connection efficiency including handshakes and keep-alives)
- **RQ5 (optional, low priority)** Network resilience under controlled disruption via `tc`/netem — only after RQ1–RQ4 are complete

## Hardware and stack
- Raspberry Pi 4, six Shelly Plus Plug S Gen2, INA219/INA226 I²C sensor
- Device lineup: PC, home server (permanent loads), router, TV, charger, air fryer / microwave
- Rationale: realistic household mix for external validity
- Software: Python (paho-mqtt, psutil), Mosquitto, InfluxDB, Next.js, Wireshark/tcpdump, `tc`/netem

## Current state
- Structure refactored; ML/anomaly-detection component fully removed
- RQ3 and RQ4 added to fill capacity freed by the ML removal
- Literature researched for RQ3 and RQ4 (see `literature/sources-existing.md`)
- Supervisor saw an earlier ML-inclusive version; a short update summary was prepared
- **Open:** supervisor meeting to align on the ML-free structure

## Optional / deprioritized
- MQTT QoS 0/1/2 comparison
- CoAP as a fourth protocol (highest effort — new client/server implementation)
