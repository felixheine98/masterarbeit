# Search Log — lit-verifier

One row per search, written at the time the search is run. Merged into `literature/search-log.md` by `scripts/merge-literature.sh`.

Task A (verification of `literature/sources-existing.md`): these are identifier look-ups and verification queries, not topic searches. "Included" = the look-up confirmed/identified a listed source.

| Date | Agent | Database | Query string | Filters | Hits | Screened | Included | Notes |
|------|-------|----------|--------------|---------|------|----------|----------|-------|
| 2026-10-03 | lit-verifier | arXiv API | `id_list=1804.01747,1409.3367` | – | 2 | 2 | 2 | 1804.01747 = Dizdarević et al. survey (journal DOI 10.1145/3292674); 1409.3367 = Muller, "HTML5 WebSocket protocol and its application to distributed computing" (MSc thesis, no journal ref). PDFs downloaded from arXiv. |
| 2026-10-03 | lit-verifier | Crossref | `works/10.22214/ijraset.2026.77541` | – | 1 | 1 | 1 | Mishra & Guru, IJRASET 14(2), 883–890, 2026. DOI resolves directly to the PDF (downloaded). |
| 2026-10-03 | lit-verifier | Europe PMC REST | `search?query=PMCID:PMC10224120&resultType=core` | – | 1 | 1 | 1 | Jara Ochoa et al., Sensors 23(10):4896, DOI 10.3390/s23104896, OA CC BY. Topic is power consumption, not payload formats. |
| 2026-10-03 | lit-verifier | Crossref | `works/10.1145/3292674` | – | 1 | 1 | 1 | ACM Computing Surveys 51(6), pp. 1–29, issued 2019-01-28; no update/retraction notice. |
| 2026-10-03 | lit-verifier | Crossref | `works/10.3390/s23104896` | – | 1 | 1 | 1 | Metadata matches Europe PMC; no update/retraction notice. |
| 2026-10-03 | lit-verifier | Crossref | `works?filter=alternative-id:S2352864822000347` | – | 1 | 1 | 1 | PII → DOI 10.1016/j.dcan.2022.03.013, Bayılmış et al., Digital Communications and Networks 8(6), 1094–1104, 2022; no update/retraction notice. |
| 2026-10-03 | lit-verifier | TUM NET publisher site | `https://www.net.in.tum.de/fileadmin/TUM/NET/NET-2018-03-1.pdf` (proceedings volume) | – | 1 | 1 | 1 | Proceedings FI/IITM WS 2017/18; TOC lists Sarafov, "Comparison of IoT Data Protocol Overhead", p. 7. |
| 2026-10-03 | lit-verifier | DataCite / doi.org | `10.2313/NET-2018-03-1_02` (also tried Crossref: not found) | – | 1 | 1 | 1 | DOI registered with DataCite (not Crossref); resolves to per-paper PDF, downloaded. |
| 2026-10-03 | lit-verifier | Unpaywall | `10.3390/s23104896` | – | 1 | 1 | 1 | gold OA, publisher PDF URL (MDPI) — download returned HTTP 403 for scripts. |
| 2026-10-03 | lit-verifier | Unpaywall | `10.1016/j.dcan.2022.03.013` | – | 1 | 1 | 1 | gold OA (CC BY-NC-ND), only location = ScienceDirect PDF — returned bot-check HTML / 403 for scripts. |
| 2026-10-03 | lit-verifier | Unpaywall | `10.22214/ijraset.2026.77541` | – | 1 | 1 | 1 | OA, `journal_is_in_doaj: false`. |
| 2026-10-03 | lit-verifier | Unpaywall | `10.1145/3292674` | – | 1 | 1 | 1 | green OA: arXiv (submitted version) and UPC repository hdl 2117/129556 (accepted version, no direct PDF URL). |
| 2026-10-03 | lit-verifier | Semantic Scholar + OpenAlex | `paper/DOI:10.1016/j.dcan.2022.03.013` (fields title, year, venue, externalIds, openAccessPdf); OpenAlex `works/doi:…` locations | – | 1 | 1 | 1 | Metadata confirmed; only PDF location is ScienceDirect; Kocaeli AVESIS repository record has no PDF link. |
| 2026-10-03 | lit-verifier | Europe PMC REST | `PMC10224120/fullTextXML` | – | 1 | 1 | 1 | Full text (JATS XML) retrieved and saved; Europe PMC and PMC PDF render endpoints returned a bot-check page (not a PDF). |
| 2026-10-03 | lit-verifier | Elsevier API (text-mining links from Crossref) | `content/article/PII:S2352864822000347?httpAccept=text/plain` | – | 0 | 0 | 0 | HTTP 400 without API key; no full text obtained. |
| 2026-10-03 | lit-verifier | Semantic Scholar | `paper/search?query=Viswanathan JSON CBOR Protocol Buffers serialization IoT` | – | 0 | 0 | 0 | No result returned (empty/rate-limited response). |
| 2026-10-03 | lit-verifier | Web search | `Viswanathan University of Pittsburgh JSON CBOR Protocol Buffers serialization formats IoT evaluation` | – | 9 | 9 | 0 | No Viswanathan/Pittsburgh source on payload formats found. |
| 2026-10-03 | lit-verifier | Web search | `Viswanathan "University of Pittsburgh" thesis "Protocol Buffers" OR "CBOR" OR "JSON" serialization performance d-scholarship.pitt.edu` | – | 10 | 10 | 0 | No match. |
| 2026-10-03 | lit-verifier | Crossref | `works?query.author=Viswanathan&query.bibliographic=JSON Protocol Buffers serialization performance&rows=8` | – | 8 | 8 | 0 | No relevant match. |
| 2026-10-03 | lit-verifier | Web search | `Viswanathan Pittsburgh "data serialization" OR "payload format" IoT MQTT JSON "Protocol Buffers" comparison report pitt.edu` | – | 9 | 9 | 1 | Found Abhishek Viswanathan, "Analysis of Power Consumption of the MQTT Protocol", Univ. of Pittsburgh 2017 (d-scholarship item 32399). Only Viswanathan/Pittsburgh IoT-protocol source found; topic is power consumption, not payload formats. |
| 2026-10-03 | lit-verifier | D-Scholarship@Pitt (repository page) | `https://d-scholarship.pitt.edu/32399/` | – | 1 | 1 | 1 | Record metadata + abstract read (Masters thesis, M.S. Telecommunications, 80 pages, created 2017-06-15). PDF download link returned bot-check HTML; legacy PDF URL returns 404. |
| 2026-10-03 | lit-verifier | Web search | `IJRASET "International Journal for Research in Applied Science and Engineering Technology" predatory journal Scopus indexed UGC CARE Beall's list` | – | 9 | 9 | 0 | Venue assessment only; secondary claims checked against primary lists below. |
| 2026-10-03 | lit-verifier | beallslist.net | `https://beallslist.net/standalone-journals/` grep "IJRASET" | – | 1 | 1 | 0 | IJRASET is listed among potential predatory stand-alone journals. |
| 2026-10-03 | lit-verifier | DOAJ API | `search/journals/issn:2321-9653` (IJRASET) and `issn:2352-8648` (Digital Communications and Networks) | – | 0 / 1 | 1 | 0 | IJRASET not in DOAJ; Digital Communications and Networks is in DOAJ. |
