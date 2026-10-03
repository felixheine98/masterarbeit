# Verification report

Agent: lit-verifier · Last updated: 2026-10-03

## Task A — Existing sources (`literature/sources-existing.md`)

Task B (findings check of the other agents, merge, DOI check of `references.bib`) has **not** been run yet. `scripts/merge-literature.sh` was not run; the merged views do not yet contain the lit-verifier files.

### What was checked
For each of the 7 listed sources: identifier resolution and existence; title, authors, year, venue against Crossref (4 DOIs), the arXiv API (2 IDs), Europe PMC (1 PMCID), DataCite (TUM DOI) and the University of Pittsburgh repository record; Crossref update/retraction fields; legal full-text availability (Unpaywall, arXiv, publisher, repository); and, where full text was readable, 4–6 findings with verbatim-checked quotes. Every look-up is logged in `literature/search-logs/lit-verifier.md`.

### Result per source
| # | Source (bibkey) | Assigned | Status | Full text | Findings |
|---|---|---|---|---|---|
| 1 | `viswanathan2017analysis` — Viswanathan, *Analysis of Power Consumption of the MQTT Protocol*, MSc thesis, Univ. of Pittsburgh, 2017 | RQ3 | Exists; **identity unconfirmed + topic mismatch** | not obtained (to-acquire) | none (abstract only) |
| 2 | `jaraochoa2023power` — Jara Ochoa et al., Sensors 23(10):4896, 2023 (PMC10224120) | RQ3 | Verified; **topic mismatch** | XML full text read; PDF not obtained (to-acquire) | 5, by section |
| 3 | `dizdarevic2019survey` — Dizdarević et al., ACM Computing Surveys 51(6), 2019 (arXiv:1804.01747) | RQ3 | Verified; weak fit | arXiv preprint PDF | 5, by section |
| 4 | `bayilmis2022survey` — Bayılmış et al., Digital Communications and Networks 8(6):1094–1104, 2022 (PII S2352864822000347) | RQ3 | Metadata verified; content unread | not obtained (to-acquire) | none |
| 5 | `sarafov2018comparison` — Sarafov, TUM seminar proceedings NET-2018-03-1, pp. 7–14, 2018 | RQ4 | Verified; grey literature | PDF | 6, with pages |
| 6 | `muller2014websocket` — Muller, MSc thesis, Cranfield Univ., 2014 (arXiv:1409.3367) | RQ4 | Verified; grey literature | PDF | 4, with pages |
| 7 | `mishra2026performance` — Mishra & Guru, IJRASET 14(2):883–890, 2026 | RQ4 | Exists; **venue and paper not acceptable** | PDF | 5, with pages (documenting defects) |

No retraction or correction notice is registered in Crossref for sources 2, 3, 4 and 7. Sources 1, 5 and 6 have no Crossref record, so this check is not applicable to them.

### What was wrong
1. **Viswanathan (RQ3)** — no identifier had been recorded. The only matching work found is Abhishek Viswanathan's 2017 master's thesis on MQTT power consumption on a Raspberry Pi. Per its abstract it varies QoS, payload *size* and authentication; it is not about payload *formats*. The match rests on author + institution only.
2. **PMC10224120 (RQ3)** — the ID is correct, but the article is a power-consumption comparison of MQTT and HTTP on a NodeMCU. It contains no JSON/CBOR/Protobuf comparison. Minor internal inconsistency in the article: HTTP average power is 667.33 mW in the text and 670.16 mW in its Tables 2 and 3.
3. **Dizdarević (RQ3)** — recorded only by arXiv ID; the citable version is the ACM Computing Surveys article (DOI 10.1145/3292674; title begins with "A Survey…", the arXiv title does not). It is a protocol survey that mentions JSON and XML in passing; "CBOR" and "Protocol Buffers" do not occur in the text. WebSockets are explicitly out of its scope.
4. **Sarafov (RQ4)** — "NET-2018-03-1" identifies the whole proceedings volume; the paper itself is DOI 10.2313/NET-2018-03-1_02, pp. 7–14. It is a student seminar paper (not peer-reviewed) and does not cover HTTP polling. The DOI is registered with DataCite, so a Crossref-only check (Task B) will report it as "not found" — that is expected, not an error.
5. **arXiv:1409.3367 (RQ4)** — recorded as "arXiv paper"; it is an MSc thesis (Cranfield University) on WebSockets for distributed computing. Its overhead numbers are quoted from secondary sources and contradict each other (frame prefix "4-12 bytes" on p. 9 vs. "between 8 and 20 bytes" on p. 10).
6. **IJRASET (RQ4)** — see assessment below.

**Consequence for RQ3:** none of the three RQ3 sources that could be read actually addresses serialization formats; the fourth is unread. RQ3 currently has no verified existing source on JSON vs. CBOR/Protobuf.

### Assessment of the IJRASET source (`mishra2026performance`)
**Not peer-reviewed in any credible sense and not appropriate for a master's thesis. Recommendation: remove it and replace it with a peer-reviewed measurement study.**

Venue — confirmed in this session:
- IJRASET is listed on Beall's list of potential predatory stand-alone journals (beallslist.net, checked directly).
- ISSN 2321-9653 is not in DOAJ (DOAJ API: 0 hits; Unpaywall: `journal_is_in_doaj: false`).
- The article footer advertises "SJ Impact Factor 7.538", "ISRA Journal Impact Factor 7.894" and "IC Value 45.98" — none of these is a recognised citation metric.
- The DOI was created at Crossref on 2026-02-19 for the February 2026 issue.

Venue — reported by secondary web sources, not independently confirmed: not indexed in Scopus or Web of Science. The journal's own stated review process was not examined.

Paper — read in full (pp. 883–890):
- Table 1 (simulation parameters) still contains template placeholders: "[Insert Number, e.g., 20 Nodes]" and "[Insert Time, e.g., 200s]" (p. 885). The simulated setup is therefore unspecified and not reproducible.
- "Bandwidth overhead" is defined as a ratio (p. 885) but reported in bytes (p. 887) with no derivation.
- Headline result: HTTP delivers 0 % of packets at 500 iterations while MQTT, also over TCP, delivers 100 % (p. 887) — implausible and unexplained.
- Reference [9] cites the Dizdarević survey with wrong co-authors, title and journal (p. 890). The other 28 references were not checked.
- Table numbering is inconsistent ("Table I" in the text, "Table: 2" in the caption); first author is a final-year B.Tech student.
- Pure NS-3 simulation, no hardware.

Any of the placeholder, reference or plausibility defects would normally be caught by peer review. The paper's direction of result (HTTP has more overhead than MQTT) can be supported from better sources.

### Still unverifiable (missing full text)
- `bayilmis2022survey` — open access, but ScienceDirect serves a bot-check page to scripts and no repository copy with a PDF was found. Content and RQ3 relevance unchecked.
- `viswanathan2017analysis` — public PDF on D-Scholarship@Pitt, but the download is behind a bot check. Only the repository record and abstract were read.
- `jaraochoa2023power` — content verified from the publisher XML, but **printed page numbers are unverified**; findings cite sections.
- `dizdarevic2019survey` — content verified from the arXiv preprint v2; **page numbers of the published ACM article are unverified** (the preprint has none), and the ACM article number was not confirmed (Crossref gives only pages 1–29). Text may differ slightly from the version of record.
- Not checked at all: the accuracy of the remaining references in the IJRASET paper; Scopus/Web of Science indexing of any venue from a primary source.

### Needs Felix's attention
1. **Drop or replace the IJRASET source** (`mishra2026performance`).
2. **Confirm the Viswanathan source**: is "Analysis of Power Consumption of the MQTT Protocol" (Pitt, 2017) the one meant? If a different Viswanathan work on payload formats was intended, supply its title or link.
3. **Re-assign RQ3 sources**: `jaraochoa2023power` and `viswanathan2017analysis` belong to RQ2 (resource/energy) if they are kept; `dizdarevic2019survey` belongs to Related Work. RQ3 then depends on what `lit-rq3` finds.
4. **Download three freely available PDFs in a browser** and save them to `literature/pdfs/`: `bayilmis2022survey.pdf`, `viswanathan2017analysis.pdf`, `jaraochoa2023power.pdf` (links in `literature/to-acquire.d/lit-verifier.md`). Optional via FH library: the ACM version of Dizdarević et al.
5. **Decide on grey literature for RQ4**: `sarafov2018comparison` (seminar paper) and `muller2014websocket` (MSc thesis) are not peer-reviewed. Sarafov is methodologically close to RQ4 and worth keeping as method inspiration; Muller's figures should be replaced by RFC 6455 and own measurements. Check whether the FH Kufstein guide restricts grey literature.

### Files written in Task A
- `literature/bib/lit-verifier.bib` (7 entries)
- `literature/search-logs/lit-verifier.md` (24 logged look-ups)
- `literature/to-acquire.d/lit-verifier.md` (4 items)
- `literature/findings/existing-sources.md` (25 findings from 5 sources)
- `literature/sources-existing.md` (verified column, resolved references, notes)
- `literature/pdfs/` (git-ignored): `sarafov2018comparison.pdf`, `muller2014websocket.pdf`, `dizdarevic2019survey.pdf`, `mishra2026performance.pdf`, `jaraochoa2023power.fulltext.xml`

## Task B — Findings check
Not started (waits for lit-rq1 … lit-rq4 and lit-related-work to finish).
