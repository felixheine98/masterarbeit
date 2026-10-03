# Thesis-Struktur – aktueller Stand

**Stand:** 03.10.2026
**Titel:** *Evaluation of IoT Communication Protocols for Home-Based Energy Monitoring Systems: A Comparative Analysis of MQTT, HTTP Polling, and WebSockets*
**Studiengang:** Web Engineering & IT Solutions (berufsbegleitend), FH Kufstein
**Sprache der Arbeit:** Englisch
**Abgabefenster:** ca. Mitte November bis Mitte Mai

---

## Kernidee in einem Satz

Drei Protokolle (MQTT, HTTP Polling, WebSockets) werden in **einem einzigen, konsistenten Hardware-Experiment** über **vier Metrik-Dimensionen** verglichen – genau diese Kombination ist das Neuheitsargument.

---

## Forschungsfragen

| RQ | Thema | Messung / Werkzeug |
|----|-------|--------------------|
| **RQ1** | Latenz und Paketverlust | NTP-synchronisierte Zeitstempel |
| **RQ2** | CPU-/RAM-Verbrauch auf dem Raspberry Pi | `psutil` |
| **RQ3** | Payload-Format: JSON vs. CBOR / Protobuf | Größe, Serialisierungszeit, Wirkung auf RQ1/RQ2 |
| **RQ4** | Protokoll-Overhead und Effizienz-Ratio | Wireshark / `tcpdump` – Header-Overhead pro Nachricht + Gesamtverbindung inkl. Handshakes und Keep-Alives |
| *RQ5 (optional)* | Netzwerk-Resilienz unter kontrollierter Störung | `tc` / netem – nur wenn RQ1–RQ4 fertig sind |

---

## Kapitelstruktur

### 1 Introduction
- 1.1 Motivation – Energiemonitoring im Haushalt, Rolle der Kommunikation
- 1.2 Problem Statement — the screened evidence leaves a gap in the joint evaluation of the selected protocols, payload formats and four metric dimensions in a consistent home-energy-monitoring experiment; avoid claiming that no prior three-protocol comparison exists
- 1.3 Research Questions (RQ1–RQ4, optional RQ5)
- 1.4 Contribution / Novelty
- 1.5 Scope and Delimitations
  - Thread: excluded network technology (IPv6 mesh over IEEE 802.15.4)
  - Matter: excluded application interoperability stack with its own data/interaction models and security; exclusion is a scope decision, not a different-network-layer claim
  - Keine physischen Wand-/Distanztests → reproduzierbare netem-Simulation stattdessen
  - Kein ML / keine Anomalieerkennung
- 1.6 Structure of the Thesis

### 2 Fundamentals
- 2.1 Home Energy Monitoring – Use Cases, typische Lastprofile
- 2.2 **Requirements for IoT Communication** *(= „Schritt 0“: Vergleichskriterien definieren)*
  - Latenz, Zuverlässigkeit / Paketverlust
  - Ressourcenbedarf auf Edge-Geräten
  - Overhead / Bandbreiteneffizienz
  - Skalierbarkeit, Robustheit bei Verbindungsstörungen
  - Reichweite / Funkabdeckung *(nur theoretisch – begründen, warum nicht gemessen)*
  - → daraus die Vergleichskriterien für Kapitel 4 ableiten
- 2.3 Communication Patterns – Request/Response vs. Publish/Subscribe vs. Bidirectional Streaming
- 2.4 MQTT (Broker, Topics, QoS 0/1/2, Keep-Alive)
- 2.5 HTTP Polling
- 2.6 WebSockets
- 2.7 Payload Formats – JSON, CBOR, Protocol Buffers
- 2.8 Smart Plugs as Data Sources – Shelly Plus Plug S Gen2 (RPC-API, MQTT-Support)

### 3 Related Work *(= „Schritt 3“: Literaturrecherche)*
- 3.1 Protocol Comparisons in IoT (Latenz, Ressourcen)
  - Dizdarević et al. (2019), protocol survey; excludes WebSocket and does not compare serialization formats
  - Bayılmış et al. (2022), survey plus CoAP/MQTT/WebSocket experiment on ESP8266 and a laptop; full text verified
  - Năstase et al. (2017), protocol comparison on Raspberry Pi 3 and PC over a wired 100 Mbps switch
  - Jara Ochoa et al. (2023, PMC10224120), MQTT/HTTP power consumption on NodeMCU; energy background only, no CPU/RAM or payload-format comparison
  - Viswanathan (Pitt, 2017), MQTT power-consumption thesis: source identity still requires confirmation; abstract only
- 3.2 Payload Formats in Constrained Environments (RQ3)
  - Petersen et al. (2017), serializer × middleware comparisons on Raspberry Pis; distinguish uncompressed from compressed payload sizes
  - Tusa and Clayman (2021), JSON/XDR × transport with server CPU/RAM and message bytes; MQTT not experimentally evaluated
  - Empirical JSON/CBOR/Protobuf findings and limitations: `literature/findings/rq3-payload.md`
- 3.3 Protocol Overhead and Efficiency (RQ4)
  - RFC 6455 and MQTT specification as primary framing evidence; empirical packet/session accounting in `literature/findings/rq4-overhead.md`
  - Sarafov (2018, TUM seminar): qualified model/method inspiration; no HTTP polling, simplified byte model
  - Muller (2014, arXiv:1409.3367): secondary overhead figures are inconsistent; use primary specifications for sizes
  - Mishra and Guru (2026, IJRASET): retain only in the verification record; exclude from quantitative evidence because simulation placeholders, metric inconsistency and citation defects prevent reliable interpretation
- 3.4 **Emerging Smart-Home Standards: Thread and Matter** – als Abgrenzung
  - Distinguish Thread networking from Matter application interoperability; explain the separate scope reasons using Thread Group documentation and CSA Matter Core Specification 1.2, Secs. 2.1–2.3 (see related-work findings F28–F29)
- 3.5 Research Gap → Überleitung zur eigenen Arbeit

### 4 Methodology
- 4.1 Research Design – quantitatives Experiment
- 4.2 **Two-Scenario Design**
  - **Kontrolliertes Szenario:** echter Shelly-Trace aufgezeichnet, eingefroren + gehasht, von einem Shelly-Emulator auf separater Maschine abgespielt
  - **Live-Validierung:** reale Geräte im Haushalt
- 4.3 Hardware Setup
  - Raspberry Pi 4
  - 6× Shelly Plus Plug S Gen2: PC, Homeserver (Dauerlasten), Router, TV, Ladegerät, Airfryer/Mikrowelle
  - Begründung: realistischer Haushaltsmix → externe Validität
  - Testnetz: ggf. separater Travel-Router als isoliertes Netz
- 4.4 Software Stack – Python (paho-mqtt, psutil), Mosquitto, InfluxDB, Next.js-Dashboard, Wireshark/tcpdump, `tc`/netem
- 4.5 Fair-Comparison Controls
  - Nur das Protokoll variiert: identischer Payload, gleiches Sendeintervall, gleiche Hardware und gleiches Netz
  - MQTT-QoS dokumentiert, HTTP-Polling-Intervall abgeglichen
  - NTP-synchronisierte Zeitstempel
- 4.6 Metrics and Measurement Procedure (je RQ)
- 4.7 Statistical Approach – randomisierte Testreihenfolge, wiederholte Durchläufe, Mittelwert ± Standardabweichung
- 4.8 Threats to Validity

### 5 Implementation
- 5.1 Systemarchitektur (Diagramm: Shelly / Emulator → Pi → InfluxDB → Dashboard)
- 5.2 Shelly-Emulator und Trace-Replay
- 5.3 MQTT-Pipeline
- 5.4 HTTP-Polling-Pipeline
- 5.5 WebSocket-Pipeline
- 5.6 Payload-Serialisierung (JSON / CBOR / Protobuf)
- 5.7 Messinfrastruktur (psutil-Logger, Paketmitschnitte, netem-Profile)

### 6 Results
- 6.1 RQ1 – Latency and Packet Loss
- 6.2 RQ2 – Resource Consumption
- 6.3 RQ3 – Payload Formats
- 6.4 RQ4 – Overhead and Efficiency
- 6.5 Live-Validierung vs. kontrolliertes Szenario
- *6.6 RQ5 – Resilience (optional)*

### 7 Discussion
- 7.1 Interpretation je RQ
- 7.2 Trade-offs / Empfehlung je Use Case (z. B. Echtzeit-Dashboard vs. periodisches Logging)
- 7.3 Vergleich mit der Literatur
- 7.4 Limitations

### 8 Conclusion and Future Work
- 8.1 Zusammenfassung
- 8.2 Future Work
  - MQTT-QoS-Vergleich (0/1/2)
  - CoAP als viertes Protokoll
  - Thread / Matter
  - Physische Reichweiten-/Wandtests
  - Energiemanagement in dynamischen Umgebungen

### Appendix
- Trace-Hashes, netem-Profile, Konfigurationen, Rohdaten, Code-Repository

---

## Arbeitsschritte (aus den Notizen „zum Weitermachen“)

- [ ] **Schritt 0** – Anforderungen an Kommunikation sammeln → Vergleichskriterien definieren (→ Kap. 2.2)
- [ ] **Schritt 1** – Geräte / Technologien / Use Cases festhalten: Shelly vs. andere Verbraucher, was gemessen werden kann (→ Kap. 2.8, 4.3)
- [ ] **Schritt 2** – Forschungsfragen schärfen, daraus weitere Suchbegriffe ableiten (→ Kap. 1.3)
- [ ] **Schritt 3** – Literaturrecherche erweitern, v. a. Thread/Matter als Abgrenzung (→ Kap. 3)

---

## Offene Punkte

- [ ] Betreuer-Termin: Freigabe der ML-freien Struktur
- [ ] Rolle des INA219/INA226 klären – seit RQ3 auf Payload-Formate umgestellt wurde, ist unklar, ob der Sensor noch gebraucht wird
- [ ] Entscheidung Travel-Router als isoliertes Testnetz
- [x] Thread/Matter boundary: primary sources verified and English wording prepared for 1.5 + 3.4 in `literature/findings/related-work.md`

## Research continuation — 2026-10-03

The existing research files remain the evidence base. Search logs, bibliography and outstanding acquisitions are consolidated by `scripts/merge-literature.sh`; completed source retrieval must be distinguished from unresolved abstract-only evidence.

| Area | Evidence file | Consequence for the thesis |
|------|---------------|---------------------------|
| RQ1 | `literature/findings/rq1-latency.md` | Separate native WebSocket from MQTT-over-WebSocket; distinguish HTTP polling from POST/GET transactions; assess timestamp uncertainty and application sample loss |
| RQ3 | `literature/findings/rq3-payload.md` | Existing format × transport experiments include Raspberry Pis; document libraries, compression and numeric precision, and avoid claiming the whole combination is new |
| RQ4 | `literature/findings/rq4-overhead.md` | Define the byte-counting layer and observation window; separate message overhead from full-session traffic and state which retransmissions are included |
| Related Work | `literature/findings/related-work.md` | Delimit the contribution against Năstase, Tusa/Clayman and Petersen; qualify conclusions to the screened evidence and keep unread dimensions unknown |

The contribution is the consistent evaluation of MQTT, HTTP polling and native WebSocket telemetry across latency/delivery, Raspberry Pi CPU/RAM, JSON versus CBOR/Protobuf payloads and protocol/session efficiency with a frozen real smart-plug trace and live validation. Prior work already covers important subsets. Kaur/Khanna remains a priority full-text check before finalising the research-gap paragraph.

## Literature verification — 2026-10-03

Task A has been imported from its separate worktree. Task B has audited all 152 findings and all 80 unique DOIs; the consolidated status and evidence limits are in `literature/verification-report.md`. Use the corrected findings, retaining the stated full-text/abstract basis. Thangavel RQ4 F6 remains unverified; Oliveira/Silva Related Work quotations still need primary evidence; Kaur/Khanna and other abstract-only predecessors need full-text checks before finalising the gap. Mishra/Guru is excluded from quantitative evidence because of inspected reporting defects. No protocol, hardware or metric scope was added.
