# Findings — RQ3: Payload formats (JSON vs. CBOR vs. Protocol Buffers)

Agent: lit-rq3 · Last updated: 2026-10-03

## Summary
The studies reviewed generally report smaller messages for schema-driven binary formats (Protocol Buffers, Avro) than for JSON. Schema-less binary formats (CBOR, MessagePack) often provide smaller savings because their object encodings retain field names. Verified individual comparisons in the synthesis table report roughly 23–29 % reductions for CBOR and 64–91 % for Protocol Buffers; these ranges describe the selected payloads, not universal bounds. Float-heavy documents can instead grow when encoded as CBOR. Encode/decode speed depends on the library and hardware, and the balance between computation and transmission depends on the experimental conditions. The continuation identified a Raspberry Pi serialization × middleware experiment and a server-side encoding × transport × resource experiment, so broad claims that these combinations have never been measured are not supported. The remaining gap within this search is a common evaluation of MQTT, HTTP polling and WebSocket, with JSON/CBOR/Protobuf payloads, latency/delivery outcomes, CPU/RAM and packet-capture efficiency in one Raspberry Pi home-energy testbed. Existing studies use different protocol sets, large or generic payloads, or server hardware.

Evidence status: Task B (2026-10-03) checked all F1–F29 against the locally available full texts or documentation snapshots, including sections, quoted wording, numerical bases and page offsets. Individual verification lines preserve discovered problems and their corrections. F1–F25 preserve the previous full-text research batch; only passages explicitly marked as rechecked were reread during the preceding research continuation. Several sources use arXiv/accepted versions and are cited by section. On 2026-10-03 the continuation visually verified Friesel Fig. 1 and Petersen Figs. 2–3; this revealed and corrected a compressed/uncompressed size mix-up in F16 and the synthesis table. New findings F26–F29 are based on full-text passages read during this continuation.

## Findings

### F1: JSON is a text format with four primitive and two structured types
- **Claim:** JSON is defined as a lightweight, text-based, language-independent interchange format with decimal-text numbers. RFC 8259 recommends expecting no greater numeric range or precision than IEEE 754 binary64 for broad interoperability; integers from −(2^53)+1 to (2^53)−1 can agree exactly between such implementations. This is interoperability guidance, not a universal precision restriction on JSON implementations.
- **Source:** [@bray2017json]
- **Page / section:** p. 1 (abstract); Sec. 1, p. 3; Sec. 6, p. 7–8 (RFC page numbers)
- **Evidence:** "JavaScript Object Notation (JSON) is a lightweight, text-based, language-independent data interchange format."
- **Basis:** full text
- **Relevance:** supports — primary definition of the baseline format used in RQ1/RQ2/RQ4 and compared in RQ3.
- **Cite as (APA 7):** (Bray, 2017, p. 1)
- **Verification (Task B, 2026-10-03):** ✘ overstrong interoperability restriction — corrected to RFC 8259 Sec. 6 guidance; abstract quote and printed pp. 1, 3, 7–8 verified in the local RFC text.

### F2: CBOR's design goals rank small code size above small message size, and it is schema-less by design
- **Claim:** CBOR was designed for constrained nodes: a compact encoder/decoder is a higher-priority objective than a compact encoding, data must be decodable without a schema, and JSON is treated as the upper bound for size.
- **Source:** [@bormann2020cbor]
- **Page / section:** Sec. 1.1, p. 5 (objectives 2–4); abstract, p. 1
- **Evidence:** "Data must be able to be decoded without a schema description."
- **Basis:** full text
- **Relevance:** supports — explains *why* CBOR savings over JSON are moderate (keys stay in the message) and frames the schema-less vs. schema-driven trade-off of RQ3.
- **Cite as (APA 7):** (Bormann & Hoffman, 2020, p. 5)
- **Verification (Task B, 2026-10-03):** ✔ verified — RFC 8949 p. 5, objectives 2–4 and their priority order; JSON upper bound is a design objective, not a guarantee for every encoded input.

### F3: Preferred CBOR serialization uses the shortest value-preserving float representation; deterministic encoding requires it
- **Claim:** Preferred CBOR serialization uses the shortest floating-point representation that preserves the value (16/32/64 bit). Sec. 4.1 does not impose preferred serialization on every encoder/decoder; the MUST requirement quoted below appears in Sec. 4.2.1 for core deterministic encoding.
- **Source:** [@bormann2020cbor]
- **Page / section:** Sec. 4.1, p. 25 (preference and its optional enforcement); Sec. 4.2.1, p. 26 (quoted MUST requirement)
- **Evidence:** "Floating-point values also MUST use the shortest form that preserves the value, e.g., 1.5 is encoded as 0xf93e00 (binary16) and 1000000.5 as 0xfa49742408 (binary32)."
- **Basis:** full text
- **Relevance:** method inspiration — power/voltage/current readings are floats; the thesis must document whether the chosen CBOR library applies shortest-float encoding (see F22).
- **Cite as (APA 7):** (Bormann & Hoffman, 2020, p. 26)
- **Verification (Task B, 2026-10-03):** ✘ wrong section / normative scope — the quotation is Sec. 4.2.1 p. 26, not Sec. 4.1; corrected using pp. 25–26 and distinguished preferred from deterministic requirements.

### F4: Protocol Buffers messages carry field numbers instead of names and cannot be interpreted without the .proto schema
- **Claim:** On the wire, a Protobuf message is a series of records keyed by field number and wire type; names and declared types exist only in the schema, so the format is not self-describing.
- **Source:** [@google2026protobuf]
- **Page / section:** "Encoding" page, Sec. "Message Structure"; "Overview" page, Sec. "When are Protocol Buffers not a Good Fit?" (web documentation, no pagination; overview heading confirmed from the existing text snapshot in the continuation)
- **Evidence:** "That is, you cannot fully interpret one without access to its corresponding .proto file."
- **Basis:** full text (web page snapshot of 2026-10-03)
- **Relevance:** supports — primary source for the mechanism behind Protobuf's size advantage and its interoperability cost.
- **Cite as (APA 7):** (Google LLC, 2026, "Overview")
- **Verification (Task B, 2026-10-03):** ✔ verified — both local Google snapshots read; Overview heading/quote and Encoding Message Structure support the claim. The citation year remains bibliography metadata, not a newly inferred publication date.

### F5: Schema-less vs. schema-driven is the central conceptual distinction
- **Claim:** A format is schema-less if its output can be deserialized without prior knowledge of the structure; schema-driven formats leave structural information out of the message, which typically yields more compact output, while schema-less formats are perceived as easier to use.
- **Source:** [@viotti2022survey]
- **Page / section:** Sec. 1.4 (and Sec. 1.5)
- **Evidence:** "A serialization specification is schema-less if it produces bit-strings that can be deserialized without prior knowledge of its structure and schema-driven otherwise."
- **Basis:** full text (arXiv preprint, not peer-reviewed)
- **Relevance:** supports — gives the thesis a citable taxonomy: JSON (textual, schema-less), CBOR (binary, schema-less), Protobuf (binary, schema-driven).
- **Cite as (APA 7):** (Viotti & Kinderkhedia, 2022b, Sec. 1.4)
- **Verification (Task B, 2026-10-03):** ✔ verified — arXiv survey Sec. 1.4 and adjacent taxonomy read (PDF p. 6); quote and qualified schema taxonomy agree.

### F6: Across 27 selected JSON test cases, per-format medians average 9.1 % for schema-less formats and 50.6 % for schema-driven formats
- **Claim:** The benchmark selects 27 JSON test cases from a SchemaStore population of over 400 documents; it does not benchmark every document in that population. Table 64 averages the individual schema-less format medians to 9.1 % (CBOR itself: 22.5 %; MessagePack: 22.7 %). Table 65 gives 50.6 % as the corresponding schema-driven average of medians, more than five times 9.1 %. Against compressed JSON, the source reports negative group median/mean reductions for schema-less binary formats. These are selected-case and group summaries, not a pooled median or a CBOR-specific 9.1 % saving.
- **Source:** [@viotti2022benchmark]
- **Page / section:** Secs. 1.2 and 6 (27 selected cases), Sec. 8.1 (Table 64), Sec. 8.2 (Table 65), Sec. 8.4.2 and abstract (compressed comparison)
- **Evidence:** "the median size reduction of the selection of schema-driven binary serialization specifications listed in Table 6 is more than five times higher that the schema-less binary serialization specification size reductions"
- **Basis:** full text (arXiv preprint, not peer-reviewed; dataset-selection passages, Tables 64–65 and compression discussion checked in Task B)
- **Relevance:** supports — contextualizes RQ3 size expectations. The compressed-JSON result is background only; adding compression to the experimental matrix is outside the locked comparison unless explicitly approved.
- **Cite as (APA 7):** (Viotti & Kinderkhedia, 2022a, Sec. 8.1–8.2)
- **Verification (Task B, 2026-10-03):** ✘ population confused with measured sample and grouped statistic — corrected to 27 selected cases and the average of per-format medians; Tables 64–65 read (PDF pp. 108, 110), compressed comparison checked in abstract/Sec. 8.4.2.

### F7: Existing size benchmarks are hard to reproduce because payloads and schemas are not disclosed
- **Claim:** A review of earlier serialization benchmarks finds that several do not publish the JSON documents or schema definitions used, so results cannot be corroborated.
- **Source:** [@viotti2022benchmark]
- **Page / section:** Sec. 2.1, subsection "Reproducibility and Representativity"
- **Evidence:** "Therefore, it is not possible to corroborate their findings or contextualize their results."
- **Basis:** full text (arXiv preprint)
- **Relevance:** method inspiration — supports publishing the frozen, hashed Shelly trace and the .proto/CDDL definitions with the thesis.
- **Cite as (APA 7):** (Viotti & Kinderkhedia, 2022a, Sec. 2)
- **Verification (Task B, 2026-10-03):** ✘ section too broad — exact subsection is Sec. 2.1, Reproducibility and Representativity (PDF p. 4); corrected; quote and claim verified.

### F8: On IoT message objects, Protocol Buffers needs well under half the bytes of JSON; CBOR and MessagePack save roughly a quarter (microcontroller study — context only)
- **Claim:** Across a mixed benchmark of public MQTT broker payloads and datasets from two smartphone studies, mean encoded sizes were JSON 111 B, CBOR 85 B, MessagePack 85 B, Protocol Buffers 40 B (schema size not counted). Objects contained 1–13 key-value pairs; the smartphone datasets were the largest and most text-heavy. Embedded timing was measured on 8- to 32-bit microcontrollers, not on Linux-class devices; formats without embedded implementations were measured for size using C++/Python libraries.
- **Source:** [@friesel2021data]
- **Page / section:** p. 2 (Fig. 1 and Sec. 3)
- **Evidence:** "We see that Avro, XDR, and Protocol Buffers provide the most efficient encoding and are thus cheapest to transmit, and JSON is least compact."
- **Basis:** full text; mean values and legend visually verified in Fig. 1 during the continuation; setup reread on printed pp. 1–2
- **Relevance:** supports — closest payload type to the thesis (small MQTT sensor messages). **Context only regarding hardware:** ATmega328P, MSP430, ESP8266, STM32; CBOR was measured for size only (no embedded implementation benchmarked).
- **Cite as (APA 7):** (Friesel & Spinczyk, 2021, p. 2)
- **Verification (Task B, 2026-10-03):** ✔ verified — local PDF p. 3 = printed p. 2; Fig. 1 rendered and read: mean labels 111/85/85/40 B, not medians. Methods on printed pp. 1–2 confirm mixed payload sources and off-device size measurements.

### F9: Whether compact encoding or fast encoding matters more depends on the cost ratio of CPU cycles to transmitted bytes
- **Claim:** With a slow, power-hungry radio, transmission cost per byte exceeds computation cost per clock cycle by about four orders of magnitude, so message size dominates; with fast Wi-Fi the difference between formats becomes small relative to the device's overall consumption. The authors conclude there is no single best format.
- **Source:** [@friesel2021data]
- **Page / section:** p. 2–3 (Sec. 3)
- **Evidence:** "From an energy perspective, spending an additional 9,000 CPU cycles to save a single byte of data is already worth it."
- **Basis:** full text
- **Relevance:** extends — on a mains-powered Raspberry Pi with Wi-Fi/Ethernet the trade-off shifts; this justifies measuring size *and* CPU time separately in RQ3 instead of assuming size dominates. Microcontroller context.
- **Cite as (APA 7):** (Friesel & Spinczyk, 2021, pp. 2–3)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 2–3 / PDF pp. 3–4; 0.5 nJ/cycle versus 5–10 µJ/B and the 9,000-cycle quotation checked; the Wi-Fi qualification is specific to the cited energy model.

### F10: Prior serialization studies were mostly run on smartphones or x86 machines, not on IoT devices
- **Claim:** The authors motivate their work with the observation that the cost of (de)serialization and transmission on IoT hardware is largely undocumented.
- **Source:** [@friesel2021data]
- **Page / section:** p. 1 (Sec. 1)
- **Evidence:** "Previous studies are often bound to specific use cases and evaluated on powerful Android smartphones or even x86 computers, not IoT devices."
- **Basis:** full text
- **Relevance:** supports — historical motivation for this microcontroller study. The thesis examines a Raspberry Pi home-energy configuration; F26 confirms that earlier Pi format × middleware measurements already exist, so this passage cannot establish their absence.
- **Cite as (APA 7):** (Friesel & Spinczyk, 2021, p. 1)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed p. 1 / PDF p. 2, Sec. 1; quote matches. Relevance narrowed to historical motivation because F26 documents existing Raspberry Pi work.

### F11: For a 418-byte JSON telemetry message, CBOR and MessagePack save about 28 %, Protocol Buffers about 67 %
- **Claim:** For one container-tracking telemetry record, Table 2 reports JSON 418 B, MessagePack 301 B, CBOR 298 B, Protocol Buffers 138 B and struct+zlib 127 B. The reported reductions are 28.0 %, 28.4 %, 66.7 % and 69.2 %. Recomputing (418−size)/418 gives 28.0 %, 28.7 %, 67.0 % and 69.6 %, respectively; the CBOR, Protobuf and struct+zlib percentages therefore disagree with the displayed byte counts. The size ranking and <160 B feasibility result remain supported. The authors attribute size differences to field-name transmission in schema-less formats.
- **Source:** [@kumar2026evaluating]
- **Page / section:** p. 16 (Table 2, Sec. 5.1); mechanism p. 5; conclusion p. 24
- **Evidence:** "Only Struct+Zlib (127 bytes, 69.2% reduction) and Protocol Buffers (138 bytes, 66.7% reduction) meet the <160-byte requirement" — reported percentages, not independently correct arithmetic.
- **Basis:** full text
- **Relevance:** supports — the only recent peer-reviewed study found that compares exactly JSON, CBOR and Protobuf on a sensor-telemetry record; gives a concrete expectation for the Shelly payload.
- **Cite as (APA 7):** (Kumar et al., 2026, p. 16)
- **Verification (Task B, 2026-10-03):** ✘ source-internal percentage errors — Table 2 byte counts and quote match p. 16, but CBOR/Protobuf/struct+zlib percentages do not match the 418 B baseline; reported and recomputed values now separated.

### F12: In a loaded server system, network I/O rather than deserialization CPU time dominated performance
- **Claim:** Under load with up to 1000 emulated devices, throughput/latency curves of CBOR, MessagePack, Protobuf and struct+zlib almost coincide; the authors conclude that reducing transmitted bytes matters more than the CPU cost differences between formats.
- **Source:** [@kumar2026evaluating]
- **Page / section:** p. 17 (Sec. 5.2)
- **Evidence:** "network I/O, not CPU-bound deserialization, dominates system performance"
- **Basis:** full text
- **Relevance:** extends — a hypothesis to test on the Pi: format-induced latency differences may be within noise at the thesis' message rates, while size differences are deterministic.
- **Cite as (APA 7):** (Kumar et al., 2026, p. 17)
- **Verification (Task B, 2026-10-03):** ✔ verified — p. 17, Sec. 5.2; near-coincident curves and network-I/O interpretation apply through 1000 emulated devices; not generalized beyond this regime.

### F13: Kumar et al. did not measure device-side cost; serialization speed, RAM and CPU on the device are taken from the literature
- **Claim:** Payloads were generated with Python libraries on emulated devices; device-side serialization speed, RAM usage, CPU cycles and energy are inferred from other publications, which the authors list as their first limitation.
- **Source:** [@kumar2026evaluating]
- **Page / section:** p. 23 (Sec. 6.5); also p. 14 (Sec. 4.5.1)
- **Evidence:** "we infer device-side performance characteristics (serialization speed, RAM usage, CPU cycles, energy consumption) from the authoritative literature"
- **Basis:** full text
- **Relevance:** supports (gap) — even the most recent comparison leaves sender-side CPU/RAM unmeasured; the thesis measures it with psutil on the Pi (link to RQ2).
- **Cite as (APA 7):** (Kumar et al., 2026, p. 23)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 14, 23; device-side feasibility and first limitation explicitly infer costs from literature, rather than measuring them. PDF line-break hyphen in performance joined for the verbatim quotation.

### F14: Schema-driven formats win on maintainability arguments in the authors' assessment, schema-less ones on flexibility
- **Claim:** Kumar et al. recommend Protocol Buffers over a hand-written binary format because of type safety, forward/backward compatibility and code generation; Friesel & Spinczyk recommend schema-less JSON/MessagePack where message formats evolve quickly and resources allow.
- **Source:** [@kumar2026evaluating]; [@friesel2021data]
- **Page / section:** Kumar p. 23; Friesel p. 4 (Sec. 4)
- **Evidence:** "we also recommend the schema-less JSON and MessagePack formats due to their ease of use" (Friesel & Spinczyk, 2021, p. 4)
- **Basis:** full text
- **Relevance:** extends — both are qualitative judgements, not measured developer effort; usable for the discussion of the schema trade-off.
- **Cite as (APA 7):** (Kumar et al., 2026, p. 23; Friesel & Spinczyk, 2021, p. 4)
- **Verification (Task B, 2026-10-03):** ✔ verified — Kumar p. 23 recommendations and Friesel printed p. 4 / PDF p. 5 read; quoted preference is conditional and qualitative, as stated.

### F15: Protobuf's static schema causes integration effort on the platform side
- **Claim:** In an IoT platform (ThingsBoard), JSON is used for external device communication because it is easy to integrate; accepting Protobuf from devices requires a developer to define and compile a schema per device type unless the platform compiles schemas dynamically.
- **Source:** [@shvaika2024advancing]
- **Page / section:** p. 130 (Sec. 3); p. 131 (Sec. 4)
- **Evidence:** "Protobuf’s static nature necessitates additional developer intervention for each new device type, undermining the platform’s universality and scalability, especially in cloud deployments."
- **Basis:** full text
- **Relevance:** supports — citable evidence for the developer-effort/interoperability side of RQ3. Note: authors are affiliated with ThingsBoard, Inc.; the paper proposes a solution; its short format comparison (Sec. 2) was not examined in detail here and should not be cited for numbers.
- **Cite as (APA 7):** (Shvaika et al., 2024, p. 130)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 130–131 / PDF pp. 5–6; schema compilation/integration claim and quotation checked. Vendor affiliation retained as a limitation.

### F16: In a smart-grid message benchmark, Protobuf was faster and smaller than JSON and CBOR
- **Claim:** For IEC 61850 logical-node messages serialized with Java libraries, uncompressed sizes were JSON (Jackson) 9241 B, CBOR (Jackson) 6623 B, ProtoBuf (ProtoStuff) 2870 B, MsgPack 2217 B and Avro (Jackson) 2446 B. Average serialization/deserialization times were JSON (Jackson) 54/101 µs, CBOR (Jackson) 73/85 µs and ProtoBuf (ProtoStuff) 18/16 µs. The separate compressed sizes were 3027, 2823, 2312, 1975 and 2029 B respectively; those compressed values were incorrectly used as the ordinary sizes in the previous batch and are corrected here.
- **Source:** [@petersen2017smartgrid]
- **Page / section:** Sec. III (Fig. 2, Fig. 3); Sec. IV — accepted-manuscript pp. 3–4, 6 (proceedings pp. 1339–1346; exact proceedings page UNVERIFIED because only the accepted version was read)
- **Evidence:** "When it comes to speed, especially for constrained devices, Protocol Buffers (ProtoStuff), ProtoStuff, Kryo and FST perform particularly well and produce quite compact output."
- **Basis:** full text (accepted version); timing values, byte values and compressed/uncompressed legend visually verified in Figs. 2–3 during the continuation
- **Relevance:** supports — an energy-domain serialization comparison including JSON, CBOR and Protobuf; the sibling study F26 adds combined middleware measurements on Raspberry Pi hardware.
- **Cite as (APA 7):** (Petersen et al., 2017, Sec. III–IV)
- **Verification (Task B, 2026-10-03):** ✔ verified — accepted-manuscript pp. 3–4 / PDF pp. 4–5; Figs. 2–3 rendered and read, confirming all transcribed timing/size values and compressed/uncompressed legend. Quotation is on manuscript p. 6 / PDF p. 7; proceedings pagination remains unwitnessed.

### F17: The serialization library can matter more than the format
- **Claim:** For the same format, library choice changed serialization time by more than an order of magnitude (for JSON more than 40×), and serializer memory use ranged from 1 to 22 MB.
- **Source:** [@petersen2017smartgrid]
- **Page / section:** Sec. IV — accepted-manuscript p. 5
- **Evidence:** "the speed of the serialization library might differ a lot, for JSON, it could be more than 40 times as long"
- **Basis:** full text (accepted version)
- **Relevance:** method inspiration — the thesis must name and version the Python libraries (e.g. `json`, `cbor2`, `protobuf`) and state whether C-accelerated back ends were used; results are library-specific.
- **Cite as (APA 7):** (Petersen et al., 2017, Sec. IV)
- **Verification (Task B, 2026-10-03):** ✔ verified — accepted-manuscript p. 5 / PDF p. 6; >40× wording and 1–22 MB serializer-memory range checked. Fig. 2 also supports the library variation.

### F18: Petersen et al. argue for constrained devices but measured on a laptop
- **Claim:** The benchmark ran on Windows 10 with an Intel i7-4600U and 8 GB RAM; BeagleBone/Odroid are mentioned only as motivation. The authors assume relative results transfer to any system.
- **Source:** [@petersen2017smartgrid]
- **Page / section:** Sec. II (hardware, accepted-manuscript p. 2 / PDF p. 3); start of Sec. III (quoted transfer assumption, manuscript p. 3 / PDF p. 4)
- **Evidence:** "The results for one serializer relative to the other serializers should be the same on any system, as long as the system does not run out of memory."
- **Basis:** full text (accepted version)
- **Relevance:** supports (limitation) — this isolated serialization benchmark was on a laptop. The sibling [@petersen2017communication] was subsequently verified to use Raspberry Pi 3 Model B devices (F26), so this finding must not be generalized into an absence of Raspberry Pi serialization comparisons. The secondary BeagleBone Black description remains unsupported by these two read studies.
- **Cite as (APA 7):** (Petersen et al., 2017, Secs. II–III)
- **Verification (Task B, 2026-10-03):** ✘ quotation section locator — hardware is in Sec. II but quoted transfer assumption starts Sec. III, manuscript p. 3; locator/citation corrected, laptop limitation retained only for this paper.

### F19: Converting large JSON vehicle messages to Protobuf cut the size by a factor of ten; a Raspberry Pi was used only as protocol client
- **Claim:** For 5,739 real status messages, the average size was 12,187 B as JSON, 1,157 B as Protobuf and 3,536 B as FlatBuffers; Protobuf serialization took 708 µs and deserialization 69 µs on average. Serialization was measured in a VM on a laptop (C++), while a Raspberry Pi 3B acted as client in the separate messaging-protocol experiments (MQTT, AMQP, CoAP).
- **Source:** [@proos2020performance]
- **Page / section:** p. 14 (results); p. 13 (setup)
- **Evidence:** "This is more than a factor ten smaller compared to the original JSON size (average of 12,187 bytes) and a factor three smaller than the average serialized message size when using Flatbuffers (3,536 bytes)."
- **Basis:** full text
- **Relevance:** supports / method inspiration — closest existing design to the thesis (formats × protocols incl. MQTT, with a Pi), but JSON is only the source representation (not benchmarked for time), CBOR is absent, HTTP/WebSocket are absent, and format cost is not measured on the Pi.
- **Cite as (APA 7):** (Proos & Carlsson, 2020, p. 14)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 13–14 / PDF pp. 4–5; 5739 messages, 12187/1157/3536 B, 708/69 µs and separate VM/Pi roles checked. Line-break hyphen in factor-ten quote joined.

### F20: Smaller messages come at a memory cost; Protobuf used more process memory than FlatBuffers
- **Claim:** Peak resident memory of the serialization programs averaged 5.87 MB (Protobuf) vs. 3.76 MB (FlatBuffers) for serialization and 5.28 MB vs. 2.04 MB for deserialization; the authors stress these are relative, not absolute, footprints. They state that latency and bandwidth use follow message size.
- **Source:** [@proos2020performance]
- **Page / section:** p. 14 (memory); p. 15 (discussion)
- **Evidence:** "both latencies and bandwidth usage are directly related to the message size"
- **Basis:** full text
- **Relevance:** method inspiration — peak RSS via `getrusage` is comparable to the psutil-based RSS measurement planned for RQ2/RQ3.
- **Cite as (APA 7):** (Proos & Carlsson, 2020, pp. 14–15)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 13–15 / PDF pp. 4–6; getrusage peak RSS, 5.87/3.76 and 5.28/2.04 MB verified. Process-level figures include shared libraries and input structures, as the source warns.

### F21: Schema-less binary formats saved on average 15 % over JSON on IoT test payloads; Protobuf was smallest but needs the structure known in advance (microcontroller study — context only)
- **Claim:** Across ten test payloads, MessagePack and the authors' PSON format were on average 15 % smaller than raw JSON (30–40 % for some payloads). Embedded timings use ESP32 and Arduino UNO; the size comparison also includes Avro, Thrift and YAML encoded in Java on a computer, rather than on those microcontrollers. Protocol Buffers and Thrift give the smallest encodings. CBOR was not measured.
- **Source:** [@luis2021pson]
- **Page / section:** p. 15 (sizes); p. 14 (Protobuf remark)
- **Evidence:** "On average, PSON and MessagePack generate payloads that are 15% smaller than a raw JSON, but depending on the payload, it can be improved by 30–40%"
- **Basis:** full text
- **Relevance:** supports — second independent data point for "schema-less binary ≈ 15–30 % smaller than JSON". **Context only:** ESP32/Arduino hardware; first author is affiliated with the vendor of PSON (Thinger.io), so the comparison is not neutral.
- **Cite as (APA 7):** (Luis et al., 2021, p. 15)
- **Verification (Task B, 2026-10-03):** ✘ size-test hardware qualification — Thrift (also Avro/YAML) sizes were computed off-device in Java; corrected. Printed pp. 14–15 confirm the 15 %/30–40 % quotation and ProtoBuf/Thrift ranking.

### F22: CBOR can be larger than JSON for float-heavy data
- **Claim:** Converting a large corpus of web JSON files to CBOR saved 18.8 % on average (up to 80 %), but some files grew, in the worst case by 52.9 %; the files that grew were numeric documents with many floating-point numbers, because the encoder wrote every float as an 8-byte double.
- **Source:** [@lenders2025leaner]
- **Page / section:** Sec. III-D (arXiv v2)
- **Evidence:** "Our CBOR encoder encodes all floats to 8 byte double precision floats, i.e., a JSON-encoded “5.5” (3 bytes) encodes to CBOR as fb 4016000000000000 (9 bytes)."
- **Basis:** full text (arXiv version; peer-reviewed version in IEEE TNSM, early access)
- **Relevance:** extends / partly contradicts the general "binary is smaller" expectation — Shelly readings (e.g. `apower: 5.5`) are short decimal floats, so the CBOR result in the thesis depends on float handling (see F3). Web context, not IoT hardware.
- **Cite as (APA 7):** (Lenders et al., 2025, Sec. III-D)
- **Verification (Task B, 2026-10-03):** ✔ verified — arXiv Sec. III-D, PDF p. 7; 18.8 % mean, 80 % maximum gain, −52.9 % minimum gain and 9 B double-encoding example checked. This is the chosen encoder behavior, not unavoidable CBOR expansion.

### F23: A large HTTP object showed a 9.1-second JSON-to-CBOR transfer saving; percentile improvements were smaller
- **Claim:** In a local HTTP setup, the object with the largest absolute transfer-time saving changed from 66.0 s (JSON) to 56.9 s (CBOR), a 9.1 s or 13.8 % improvement for a 100 MB object. At the 99th percentile the difference was 187.0−173.5 = 13.5 ms for objects around 400 kB. The passage does not establish 13.8 % as the greatest relative saving across all objects, or prove that smaller objects never benefit.
- **Source:** [@lenders2025leaner]
- **Page / section:** Sec. III-E (arXiv v2)
- **Evidence:** "In the maximum we can save up to 66.0 s−56.9 s = 9.1 s, a reduction by 13.8%, in this local setup"
- **Basis:** full text (arXiv version)
- **Relevance:** extends — one of very few measurements of payload format → transfer time over HTTP; suggests that for sub-kilobyte telemetry the latency effect is likely small and that RQ3 should report efficiency (bytes on the wire) as the primary outcome.
- **Cite as (APA 7):** (Lenders et al., 2025, Sec. III-E)
- **Verification (Task B, 2026-10-03):** ✘ unsupported relative maximum / only-large-object conclusion — corrected to the largest absolute saving and the separately reported 99th percentile; Sec. III-E, PDF pp. 7–8, quote and arithmetic checked.

### F24: In a JVM size benchmark, Protobuf reduced the median message by 81 %, CBOR by 23 %
- **Claim:** For the smaller-message, 15-epoch variant of a nested business-record schema (Table 3), median sizes were JSON 984 B, Protobuf 186 B (−81.10 %), MessagePack 744 B (−24.39 %), CBOR 756 B (−23.17 %) and Avro 160 B (−83.74 %). The 30-epoch larger-message variant in Table 2 instead gives Protobuf −33.06 % and CBOR −14.98 %. Thus the selected 81 %/23 % result is workload-specific. The study reports sizes using JVM libraries (with a command-line exception for JsonBinPack), not timing, CPU or memory.
- **Source:** [@maltsev2024beyond]
- **Page / section:** pp. 11–12 (schema/libraries and two benchmark variants); p. 14 (Tables 2–3 and Conclusion)
- **Evidence:** "it's possible to achieve more than a 30 % median reduction in serialized size compared with JSON"
- **Basis:** full text
- **Relevance:** supports — third independent data point for the size ranking. Not IoT (inter-service communication), regional journal; use as corroboration only.
- **Cite as (APA 7):** (Maltsev & Muliarevych, 2024, p. 14)
- **Verification (Task B, 2026-10-03):** ✘ benchmark variant omitted — Table 3 figures verified and contextualized with Table 2: the 81.10 % Protobuf saving is the smaller-message variant, versus 33.06 % in the larger variant. Printed pp. 11–14 read.

### F25: Across many format × transport combinations, schema-based binary formats serialized fastest and text formats slowest
- **Claim:** In a benchmark of serialization formats combined with streaming technologies on scientific datasets, text formats had the slowest and schema-based ("protocol-based") binary formats the fastest serialization, with schema-less binary formats in between.
- **Source:** [@jackson2024streaming]
- **Page / section:** Sec. V (arXiv v2; journal pagination not read)
- **Evidence:** "Binary-encoded methods without protocol support methods fall between these two extremes."
- **Basis:** full text (arXiv v2 of the IEEE Access article)
- **Relevance:** supports — general ordering text < schema-less binary < schema-driven binary for speed. Not IoT and not constrained hardware; background only.
- **Cite as (APA 7):** (Jackson et al., 2024, Sec. V)
- **Verification (Task B, 2026-10-03):** ✔ verified — arXiv Sec. V, serialization-latency discussion (PDF p. 8); quote includes the original repeated word methods. Speed ranking retained as this benchmark's observation, not a universal guarantee.

## Continuation — 2026-10-03

### F26: A prior smart-grid experiment already combined JSON, CBOR and Protobuf with middleware on Raspberry Pi hardware
- **Claim:** Petersen et al. evaluated ten middleware frameworks and 25 serializers, including JSON, CBOR and Protobuf implementations, on a pair of Raspberry Pi 3 Model B devices using Oracle JDK 1.8.0_111. Their Ethernet interfaces limited the link to 100 Mbit/s. Each middleware × serializer × messaging-pattern test used an IEC 61850 logical node with generated values and was repeated ten times. Outcomes were throughput and serialization-inclusive latency derived by sending the data back to the original device and dividing elapsed time by two, not independently timestamped one-way latency. The paper excludes memory and refers to prior work for data loss; it does not jointly evaluate MQTT/HTTP-polling/WebSocket.
- **Source:** [@petersen2017communication]
- **Page / section:** Sec. II (Methods), Sec. IV-D (Compared to Previous Results), Sec. V (Conclusions); accepted version PDF pp. 2–3, 6–7, without printed page numbers → cite sections
- **Evidence:** "The tests were performed in Java using Oracle JDK 1.8.0_111, on a pair of Raspberry Pi 3’s (Model B)"
- **Basis:** full text; methods and exclusions read directly; no numerical chart cells transcribed
- **Relevance:** contradicts the former broad Raspberry Pi / format × middleware gap; supports a narrower gap around the target protocol trio and four metric dimensions. The older standalone timing/size results reproduced in Fig. 8 remain laptop results, not new Pi measurements.
- **Cite as (APA 7):** (Petersen et al., 2017, Secs. II, V); disambiguate the two Petersen 2017 entries in the final reference list.
- **Verification (Task B, 2026-10-03):** ✔ verified — accepted PDF pp. 2–3, 6–7; hardware, JDK, ten repetitions and exclusions checked. Added the source's round-trip-derived latency method to avoid implying direct one-way measurements.

### F27: A prior IoT study combined payload encoding, transport, CPU/RAM and network-byte counts
- **Claim:** Tusa and Clayman compared JSON and XDR over HTTP REST, WebSocket and UDP using Python/Java edge microservices. CPU utilization, memory use, received bytes and reply bytes were measured on server clusters running CentOS 7, interconnected by 1 Gbit/s Ethernet; the edge cluster used AMD Opteron servers with 32 GB RAM. MQTT is future work; CBOR and Protobuf are not measured formats. The protocol experiment uses HTTP POST with a 202 reply, rather than polling. It is a directly relevant combined-design precedent, although its hardware, workload and formats differ from the thesis.
- **Source:** [@tusa2021impact]
- **Page / section:** pp. 8–9 (Table 1, Table 2), p. 11 (metrics/HTTP behavior), p. 18 (MQTT future work)
- **Evidence:** "the CPU usage and Memory usage"
- **Basis:** full text, selected methods/results/conclusion passages read during continuation
- **Relevance:** contradicts a generic absence of combined encoding × transport × resources measurements; method inspiration for evaluating the same workload while changing a format or interface.
- **Cite as (APA 7):** (Tusa & Clayman, 2021, pp. 8–11, 18)
- **Verification (Task B, 2026-10-03):** ✔ verified — printed pp. 8–9, 11, 18; Table 1 confirms measured format/transport combinations, Table 2/server deployment confirms hardware, p. 11 HTTP POST/202 and metrics, p. 18 MQTT future work and the quotation.

### F28: Within Python WebSocket, changing the encoding reduced traffic without a comparable reported CPU improvement
- **Claim:** At the authors' 300-message/s setting, the Python JSON/WebSocket and XDR/WebSocket implementations received approximately 400 MB and 200 MB respectively during the experiment. Both were reported at approximately 25 % CPU, while Python JSON/REST was near 100 %. Thus a payload byte saving does not imply a proportional CPU saving. These are approximate values described in the result text, not an isolated encode/decode microbenchmark or estimates for CBOR/Protobuf on a Pi.
- **Source:** [@tusa2021impact]
- **Page / section:** p. 12, Sec. 6.2 (Experiment Set 2)
- **Evidence:** "regardless of the data encoding type."
- **Basis:** full text, numerical results taken from the prose rather than estimated from a chart
- **Relevance:** extends — separates transmission-size benefit from CPU benefit; Python is relevant to the planned stack, but XDR remains context only, not an added experimental format.
- **Cite as (APA 7):** (Tusa & Clayman, 2021, p. 12)
- **Verification (Task B, 2026-10-03):** ✔ verified — p. 12 Sec. 6.2 prose; 300 messages/s, approximately 400/200 MB, 25 %/25 % and near-100 % JSON/REST checked. Values remain approximate prose reports, not chart estimates.

### F29: Delivery counts over a fixed window can detect backlog without identifying network packet loss
- **Claim:** In their 10,000-message/s Python JSON/REST experiment, 36 million measurements were generated but approximately one million were received/decoded in one hour. The investigation attributed the mismatch to queued measurements, synchronous HTTP interaction and low decoding throughput. Reliability/delay was assessed through produced-versus-received counts over the experiment lifespan, rather than per-message network-loss and latency measurements. This distinction should be preserved when discussing the source.
- **Source:** [@tusa2021impact]
- **Page / section:** pp. 11–12, Sec. 6.1
- **Evidence:** "most of the generated measurements were still queued"
- **Basis:** full text
- **Relevance:** method inspiration / cross-reference to RQ1 — distinguishes application backlog from network packet loss. The source's statement that REST/TCP eliminates data loss is not adopted as a general guarantee.
- **Cite as (APA 7):** (Tusa & Clayman, 2021, pp. 11–12)
- **Verification (Task B, 2026-10-03):** ✔ verified — pp. 11–12 Sec. 6.1; 36 million generated, about one million decoded, synchronous POST and queued remainder checked. Quote is verbatim across a column line break; no packet-loss guarantee adopted.

### Verification notes
- Visually confirmed Friesel Fig. 1 means: JSON 111 B, CBOR 85 B, MessagePack 85 B, Protobuf 40 B. Corrected the dataset description: it mixes broker messages and smartphone-study datasets.
- Visually confirmed Petersen Fig. 2 timing values and Fig. 3 legends. Earlier compressed values were mistakenly treated as uncompressed values; F16 and the synthesis are corrected. This changes the reported CBOR saving from about 7 % to 28.3 % and the Protobuf saving from about 24 % to 68.9 % in this particular benchmark.
- Confirmed the Protobuf overview section title from the existing snapshot; no new publication date was inferred.
- The formerly broad research-gap assertions are superseded by the qualified gaps below. No new protocol, payload format, compression experiment or hardware platform is added to the locked thesis scope.

## Synthesis table (uncompressed size relative to JSON, as reported)

| Source | Payload | CBOR | MessagePack | Protobuf | Hardware of measurement |
|---|---|---|---|---|---|
| Friesel & Spinczyk (2021, p. 2) | broker + smartphone-study objects, mean 111 B | 85 B (≈ −23 %) | 85 B (≈ −23 %) | 40 B (≈ −64 %) | size computed off-device; timing on MCUs |
| Kumar et al. (2026, p. 16) | container telemetry, 418 B | 298 B (≈ −28.7 %) | 301 B (≈ −28.0 %) | 138 B (≈ −67.0 %) | Python on emulated devices |
| Petersen et al. (2017, Sec. III; serialization paper) | IEC 61850 nodes, 9241 B | 6623 B (≈ −28.3 %) | 2217 B (≈ −76.0 %) | 2870 B (≈ −68.9 %) | laptop, JVM; Fig. 3 uncompressed series |
| Maltsev & Muliarevych (2024, p. 14) | business record, median 984 B | 756 B (−23.2 %) | 744 B (−24.4 %) | 186 B (−81.1 %) | JVM |
| Proos & Carlsson (2020, p. 14) | vehicle status, 12,187 B | – | – | 1,157 B (≈ −91 %) | laptop VM, C++ |
| Viotti & Kinderkhedia (2022a, Sec. 8.1) | 27 cases selected from 400+ SchemaStore docs | CBOR median −22.5 % | MessagePack median −22.7 % | Protobuf median −70.6 % | n/a (size only) |

Percentages marked ≈ are computed here from the reported byte values, not quoted from the sources. **Task B correction:** Kumar's Table 2 reports 28.4 % for CBOR and 66.7 % for Protobuf, but its byte counts imply 28.7 % and 67.0 %; the synthesis uses the recomputed percentages. Viotti's row now uses the individual format medians; its 9.1 %/50.6 % figures are averages of medians across format groups. All six synthesis rows and their numerator/baseline arithmetic were checked in Task B; Friesel/Petersen graph labels were visually checked.

## Methodological gaps in related work
- A Raspberry Pi format × middleware comparison exists: [@petersen2017communication] measures combined throughput/latency for JSON/CBOR/Protobuf and other serializers in Java. It does not isolate encode/decode time on the Pi or measure CPU/RAM and packet-capture efficiency together. The preceding standalone serializer benchmark [@petersen2017smartgrid] uses a laptop.
- Format × transport comparisons exist in [@proos2020performance], [@petersen2017communication] and [@tusa2021impact]. None of these read studies compares MQTT, HTTP polling and WebSocket together while measuring the four thesis dimensions. Tusa uses JSON/XDR, HTTP POST rather than polling, server hardware, and leaves MQTT to future work. Consequently, the gap is the common target configuration and measurement coverage, not the combination concept itself.
- Device-side CPU and RAM are inferred in [@kumar2026evaluating] (stated limitation, p. 23). [@proos2020performance] reports process RSS; [@petersen2017smartgrid] reports serializer memory; [@tusa2021impact] measures edge CPU/RAM on servers. These sources do not provide matched sender/receiver Python resource measurements on the thesis' Pi home-energy testbed.
- Results are library- and language-specific (Java, C/C++, Python), requiring the thesis to disclose library versions and back ends. [@tusa2021impact] includes Python JSON/WebSocket and XDR/WebSocket, but no read study benchmarks the thesis' JSON/CBOR/Protobuf Python stack under the common target conditions.
- Test payloads are not small float-heavy energy telemetry; where floats dominate, CBOR may not be smaller than JSON — [@lenders2025leaner]. No source uses smart-plug/energy-meter payloads.
- Payloads and schemas are frequently unpublished, which blocks replication — criticised in [@viotti2022benchmark].
- Developer effort and interoperability are argued qualitatively only; no source quantifies them — [@shvaika2024advancing], [@kumar2026evaluating], [@friesel2021data].
- Vendor involvement: [@luis2021pson] (Thinger.io) and [@shvaika2024advancing] (ThingsBoard) evaluate or promote their own technology.

## PDF page offsets
| bibkey | PDF page 1 = printed page |
|--------|---------------------------|
| proos2020performance | 10 (proceedings pp. 10–18) |
| friesel2021data | PDF p. 1 is an unnumbered cover sheet; PDF p. 2 = printed p. 1 (pp. 1–4) |
| luis2021pson | 1 (article no. 4559, pp. 1–18) |
| kumar2026evaluating | 1 (article no. 43, pp. 1–29) |
| shvaika2024advancing | 126 (pp. 126–135) |
| maltsev2024beyond | 9 (pp. 9–15) |
| petersen2017smartgrid | PDF p. 1 is a repository cover sheet; PDF p. 2 = manuscript p. 1. Accepted version with its own pagination 1–8; proceedings pagination is 1339–1346 (Crossref) but was not seen → cite by section |
| petersen2017communication | PDF p. 1 is DTU cover sheet; PDF pp. 2–7 contain the six-page accepted manuscript without visible printed page numbers → cite sections; Crossref proceedings pp. 1–6 are not used as witnessed page citations |
| tusa2021impact | PDF p. 1 = article p. 1; explicit printed headers `Page 2 of 20` through `Page 20 of 20` verify pp. 2–20; cite article pages, not article number 32 |
| bormann2020cbor | 1 (RFC page numbers = PDF pages) |
| bray2017json | plain-text RFC (`bray2017json.txt`), RFC page markers `[Page n]` |
| viotti2022survey, viotti2022benchmark, lenders2025leaner, jackson2024streaming | arXiv versions → cite by section |
| google2026protobuf | web documentation, text snapshots `google2026protobuf-overview.txt`, `google2026protobuf-encoding.txt` → cite by page title/section |

## Cross-references (for other RQs)
- [Related work/RQ1/RQ2/RQ4] tusa2021impact — transport/format/resource combined precedent; JSON/XDR, HTTP POST/WebSocket/UDP, CPU/RAM and received/reply bytes, server hardware. See F27–F29. Bytes are reported without a verified per-layer packet-capture breakdown, so they are not equivalent to the planned efficiency ratio.
- [Related work/RQ1/RQ2/RQ4] petersen2017communication — Raspberry Pi 3 Model B format × middleware throughput/latency precedent; excludes memory/data loss in this experiment (Sec. V); figures reproduce some earlier laptop serializer measurements. See F26. Do not generalize the previous standalone paper's laptop limitation to this sibling.
- [RQ4] proos2020performance — per-message protocol overhead for MQTT (QoS 0–2), AMQP and CoAP measured in bytes on the wire (Fig. 8, pp. 15–16); MQTT QoS 2 at roughly 250 B per message.
- [RQ1] proos2020performance — latency of MQTT/AMQP/CoAP under emulated mobile-network conditions with a Raspberry Pi 3B client (pp. 15–17).
- [RQ2] proos2020performance — peak RSS via `getrusage` as memory metric (p. 13); kumar2026evaluating — server-side scaling results (pp. 16–20).
- [RQ1/RQ4] lenders2025leaner — HTTP request/response time as a function of body size (Sec. III-E).
- [RQ1/RQ4] da Silva et al. 2021 (Applied Sciences, doi:10.3390/app11114879) and Wytrębowicz et al. 2021 (Sensors, doi:10.3390/s21206904) cite Proos & Carlsson; PDFs already exist in `literature/pdfs/` from other agents — not researched here.
- [Related work] Iglesias-Urkia et al. 2019 (IEC 61850 + CoAP + CBOR, on to-acquire list) — energy-domain IoT integration; CoAP is boundary material.
- [Existing source] PMC10224120 appears to be Molina Araque et al. 2023, "Yet Another Compact Time Series Data Representation Using CBOR Templates (YACTS)", Sensors 23(11), 5124, doi:10.3390/s23115124 (matched by title in two search results; identity of the PMC ID not checked — for lit-verifier).

## Open questions
- Semantic Scholar was unavailable for this agent (HTTP 429 on all but one request). IEEE Xplore and ACM DL were not queried directly (no API access); coverage relied on OpenAlex, arXiv, Crossref and web search. A manual IEEE Xplore query by Felix (`("CBOR" OR "Protocol Buffers") AND JSON AND (IoT OR "Raspberry Pi")`) would close this gap.
- Popic et al. 2016/2017, Iglesias-Urkia et al. 2019 and Huseynov et al. 2024 are paywalled or bot-blocked (see `to-acquire.d/lit-rq3.md`); none was used for a finding.
- Biswal & Almallah 2019, "Analytical assessment of binary data serialization techniques in IoT context" (thesis) is cited by several sources as a Protobuf/FlatBuffers/MessagePack/BSON sensor-node evaluation; institution, document type and location could not be verified — not included.
- F4 and F16 verification requests are closed: the existing overview snapshot contains the heading, and Petersen Figs. 2–3 were visually checked. The Fig. 3 series mix-up is corrected explicitly above.
- F18: the sibling doi:10.1109/ISGTEurope.2017.8260268 uses Raspberry Pi 3 Model B, not BeagleBone Black. The separate middleware paper doi:10.5220/0006303302190226 was not checked here. Do not repeat the secondary BeagleBone description as established.
- Tusa Sec. 6.3 setup lists ten attributes whereas its surrounding prose describes one; Sec. 6.4 describes the ten-attribute extension. Avoid relying on that inconsistent setup cell. The quoted Sec. 6.2 results have an unambiguous one-attribute setup.
- Tusa's REST comparison manages multiple HTTP connections whereas WebSocket remains persistent (p. 17). The REST-vs-stream traffic difference is specific to this implementation and cannot be transferred to keep-alive HTTP polling without measuring it.
- In the final reference list, disambiguate the two Petersen 2017 works with APA year suffixes. Historical short-form references to the serialization paper above remain identifiable by bibkey.
- Excluded for language: Balich 2026 (Spanish, JSON vs. CBOR for industrial systems) and Rishwan 2024 (Indonesian, WebSocket with JSON vs. Protobuf) — not included as evidence; F27–F28 now provide an English-language format × WebSocket precedent.
- APA 7 suffixes for the two Viotti & Kinderkhedia 2022 preprints are assigned here by title order (benchmark = 2022a, survey = 2022b); re-check once the final reference list exists.
