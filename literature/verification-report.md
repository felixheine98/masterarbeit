# Verification report

Agent: lit-verifier (coordinated Task B) · Last updated: 2026-10-03

**Task A is complete and integrated into the main workspace. Task B is complete with explicit evidence limitations.** Completion means every finding and DOI was audited; it does not mean every source has a verified full text. Corrected findings retain a ✘ and the original problem for audit history.

## Task A — existing sources

The original Task A ran in `.claude/worktrees/lit-verifier-task-a`. Its seven-entry bibliography, 24 lookup records, four original acquisition requests, 25 findings, source ledger and report were imported into the main workspace before Task B. The worktree was preserved. Task A resolved all seven recorded references; five full texts were readable then. Bayılmış became available during Task B.

| Original source | Verified identity and suitability | Current full-text status |
|---|---|---|
| Viswanathan (Pitt, 2017) | Candidate identified by author/institution; Felix must confirm identity. MQTT power consumption, not serialization formats. | Abstract/repository record only; PDF missing |
| Jara Ochoa et al. (2023), PMC10224120 | Correct ID and DOI 10.3390/s23104896; NodeMCU MQTT/HTTP power comparison, not JSON/CBOR/Protobuf. | Publisher XML verified; cite sections, no printed pages |
| Dizdarević et al. (2019), arXiv1804.01747 | DOI 10.1145/3292674; protocol survey, weak RQ3 fit, excludes WebSocket. | arXiv v2 verified; final ACM pagination unavailable |
| Bayılmış et al. (2022), PII S2352864822000347 | DOI 10.1016/j.dcan.2022.03.013; own CoAP/MQTT/WebSocket experiment, no serialization or CPU/RAM comparison. | Legal publisher PDF obtained in Task B; Related Work F22 verified |
| Sarafov (2018), TUM | Paper DOI 10.2313/NET-2018-03-1_02, not whole-volume identifier. Grey seminar literature; useful overhead-method inspiration, no HTTP polling. | PDF verified, pp. 7–14 |
| Muller (2014), arXiv1409.3367 | Cranfield MSc thesis; secondary and inconsistent WebSocket overhead numbers. | PDF verified; printed body page = PDF index−10 |
| Mishra/Guru (2026), IJRASET | DOI correct, but quantitative evidence unsuitable because of defects read directly in the paper. | PDF verified, pp. 883–890; findings document defects |

Task A's original absence of Bayılmış findings and its acquisition request are superseded by Task B. `sources-existing.md` preserves the original assignments with corrected suitability notes. `docs/thesis-struktur.md` now uses actual format-comparison sources in RQ3 and places power studies with energy background.

### IJRASET assessment

Exclude Mishra/Guru's quantitative claims from the thesis evidence base. Printed p. 885 contains unfilled node-count and simulation-time placeholders; overhead is defined as a ratio but reported in bytes on p. 887; HTTP 0% delivery versus MQTT 100% is insufficiently explained; and ref. 9 on p. 890 supplies incorrect metadata for the Dizdarević survey. The bibliography/verification findings are retained for provenance, while the active thesis outline excludes its numerical evidence.

The original Task-A categorical statement that the venue has no credible peer review was too strong. Its historical list/indexing observations do not independently establish the review process, which was not examined. First-author student status is not a reason to reject a paper. The recommendation rests on the inspected reporting defects. The original Task A checked Crossref notice fields for its four Crossref articles and found no notices; absence of such metadata is not a guarantee of scientific validity.

## Task B — findings, quotations and pagination

All **152 numbered findings across six files** were audited. Each has a dated status describing the witness or limitation. Coverage includes page offsets, verbatim quotations, paraphrase scope, reported values, numerical synthesis, Related Work coverage/gap statements and RQ4 framing formulas. Graph-only claims in Friesel/Petersen/Năstase were visually checked; precise unlabeled bar values were not invented.

| File | Findings | ✔ at stated evidence basis | ✘ corrected | ✘ unresolved evidence |
|---|---:|---:|---:|---:|
| RQ1 latency | 36 | 20 | 16 | 0 |
| RQ2 resources | 15 | 5 | 10 | 0 |
| RQ3 payload | 29 | 20 | 9 | 0 |
| RQ4 overhead | 18 | 12 | 5 | 1 |
| Related Work | 29 | 27 | 0 | 2 |
| Existing sources | 25 | 21 | 4 | 0 |
| **Total** | **152** | **105** | **44** | **3** |

These are audit outcomes, not source-quality grades. Related Work's 27 checks include substantial corrections/qualification recorded beneath retained verification marks, so 44 is the count of explicit corrected ✘ markers, not an exhaustive count of edits. Some ✔ entries verify only abstracts, secondary source reports or the presence of a source defect. RQ1 uses DOI-matched OpenAlex abstract metadata for several unavailable papers; this is identified in each finding. Related Work's Oliveira/Silva entries still fail its fresh primary-content check despite that abstract corroboration. Amirkhanov's publisher PDF was read online; a local archive remains missing.

### Material errors corrected

- **Hardware and communication paths:** Seoane's numerical latency scenario moves publisher/subscriber into one VM; the Pi belongs to another setup. Năstase uses a wired 100 Mbps LAN switch. Babovic's Flash/Silverlight socket results do not describe native HTML5 WebSocket. Several CPU figures belong to PC/cloud/Android systems rather than the thesis Pi.
- **Measurement meanings:** Saif reports cumulative allocated heap bytes, not live RAM/RSS. Its ps CPU metric is averaged over process lifetime, unlike psutil interval CPU. Official psutil documentation quotations were replaced with actual wording; comparisons require matching counter semantics. Ten repetitions are a design precedent, not a validated statistical minimum.
- **Locators and numbers:** CBOR's shortest-float MUST is RFC8949 Sec.4.2.1, p.26. MQTT5 CONNECT Properties is Sec.3.1.2.11. Amirkhanov's numerical table is p.692. Viotti benchmarks 27 selected documents, not the 400+ population; 9.1% is an average of per-format medians. Kumar/Appelqvist percentage arithmetic, Hong payload-share baselines and Seoane's maximum TLS increment were corrected explicitly.
- **Source inconsistencies:** Silva's prose/Table7 latency values disagree; Paul's throughput baselines conflict; Amirkhanov describes opposing HTTP paths. Jara Ochoa's prose versus table power means differ. These are disclosed rather than reconciled by guessing.
- **Overhead accounting:** Sarafov's model simplifications are not normative header sizes. TLS1.3 includes encrypted content type/padding as well as outer framing. Năstase's useful-byte numerator exceeds its raw-message total without explanation. Source-specific retransmission exclusions, single-hop boundaries and MQTT-over-WebSocket are stated.
- **Research gap:** Albraheem already reports Android resources; Tusa already combines formats/transports with resources and message bytes; other predecessors compare protocol subsets or the protocol triple. The bounded contribution is all four dimensions for MQTT, HTTP polling and native WebSocket on a common Pi experiment with a fixed smart-plug trace and live validation, qualified to the screened evidence.

### Detailed evidence records

- `verification-task-b-rq1-rq2.md`: 51 findings, page mappings, online/abstract limitations.
- `verification-task-b-rq3-rq4.md`: 47 findings, figures, arithmetic, normative framing and counting boundaries.
- `verification-task-b-related.md`: 29 findings, coverage table/gaps, retrieved Bayılmış full text.
- `verification-task-b-existing.md`: 25 imported findings and corrected source-assignment/quality statements.
- `verification-task-b-doi.json`: all registry responses, per-owner metadata and manual exception decisions.

## Task B — bibliography and DOI audit

All **80 unique DOIs** in the consolidated bibliography were queried. **76** have matching Crossref registrations; **3** are registered with DataCite (Friesel, Sarafov, Karagiannis); **1**, Hong10.7236/IJASC.2023.12.1.9, is registered with **KISTI**, confirmed by the doi.org registration-agency endpoint and the printed publisher PDF. Its DOI redirects to KoreaScience, although that destination returned an empty response during the resolver check. Crossref/DataCite404 is not an invalid DOI.

**No confirmed wrong DOI or conflicting DOI/key assignment was found.** There are 132 per-agent bibliography entries, consolidated into **102 references**; **30 repeated entries** are expected shared sources. Duplicate keys do not carry conflicting DOIs, and the same DOI is not assigned competing keys. Registry spelling/format exceptions were manually reviewed: padded pages/issues, omitted subtitles, name particles and erroneous author fields. Where the PDF supports the existing bibliography over malformed registry data (Ford or Maltsev), it was retained. Manowska's online2022/issue2023 distinction and Karagiannis's volume discrepancy remain disclosed metadata limits.

Bayılmış's local file was added to every owning bibliography entry and its four repeated acquisition requests were removed. All 132 per-agent entries passed the field-separator/brace/duplicate-field check. References without DOIs are outside this DOI coverage; it is not a blanket metadata verification of every no-DOI specification/web document. Merged outputs are regenerated exclusively through `scripts/merge-literature.sh`.

## Remaining evidence requiring attention

1. **Thangavel, RQ4 F6:** prior full-text copy was not saved. Quotation, pages and overhead ratio remain explicitly UNVERIFIED; obtain the IEEE/legal author full text before use.
2. **Oliveira/Silva Related Work F18/F19:** primary content unavailable in this check. Indexed abstract metadata corroborates identity/content but does not clear full-text or fresh primary-source claims.
3. **Kaur/Khanna, Mijovic and other abstract-only comparisons:** full texts remain important before finalising protocol-policy details or the gap. Unknown dimensions stay unknown.
4. **Viswanathan:** confirm which work was intended and supply its full text if retained. Jara Ochoa PDF is needed only for printed pages; Dizdarević's published ACM version is needed for final pagination/version comparison.
5. **Grey literature and source conflicts:** use primary RFC/OASIS material for framing and avoid inconsistent source values as exact baselines. Citation-style/FH guidance, Manowska reference-year convention and Karagiannis volume remain open; they did not block the audit.

No new research topic or experiment was added. Task B retrieved one existing source's PDF (Bayılmış). Lookup/acquisition requests are recorded in per-verifier logs; remaining requests are in generated `to-acquire.md`. Historical citation counts were not independently refreshed and do not substantiate novelty. The next work can use the corrected evidence while keeping these limits visible.

## Final integration checks

`bash scripts/merge-literature.sh` completed: **363 logged records**, **102 references**, **30 duplicates skipped**, and **46 outstanding per-agent acquisition rows (36 unique source keys)**. Task B added **117 log records** after the Task-A import. All 152 finding markers were counted; all citation keys resolve, including grouped/page-qualified citations; every bibliography file path exists; all 80 merged DOIs match the audit set; no verifier log row remains pending. Bayılmış is absent from the outstanding rows. These consistency checks complement the full-text audit and do not replace it.
