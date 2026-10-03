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

## Task B — DOI audit, 2026-10-03

Each unique DOI from the merged bibliography is queried against Crossref; DataCite is a fallback for identifiers registered there. These are identifier checks, not new topic searches. Rows are recorded at request time; results are reconciled after requests finish.

Supplementary exception checks are recorded in a separate table below the automated registry rows.
The Hong registry exception is checked against doi.org registration-agency and resolver metadata, with the printed publisher PDF as an independent source.

| Date | Agent | Database | Query string | Filters | Hits | Screened | Included | Notes |
|------|-------|----------|--------------|---------|------|----------|----------|-------|
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1007/978-3-030-50578-3_7` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1007/978-3-030-58923-3_23` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1007/978-3-030-89554-9_8` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1007/s10723-021-09577-9` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1007/s44227-024-00021-4` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1016/j.comnet.2018.12.012` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1016/j.comnet.2021.108338` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1016/j.dcan.2022.03.013` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/access.2016.2615181` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/access.2020.2993363` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/access.2020.3035849` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/access.2024.3486054` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/apwimob64015.2024.10792961` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/ccgrid59990.2024.00048` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/ccgrid68966.2026.00056` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/ccnc49032.2021.9369499` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/ccnc49032.2021.9369565` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/compsac.2016.51` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/comst.2015.2444095` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/cscn53733.2021.9686113` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/iccerec.2016.7814989` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/icecds.2017.8389890` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/icin.2017.7899436` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/icoin.2017.7899537` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/iemcon.2019.8936206` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/iscc.2018.8538692` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/isgteurope.2017.8260268` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/issnip.2014.6827678` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/lanman.2018.8475048` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/mcom.2019.1800788` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/metroi4.2018.8428348` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/mic.2012.64` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/mipro.2014.6859715` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/mownet.2016.7496622` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/qrs-c51114.2020.00090` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/rtsi.2016.7740559` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/sai.2017.8252264` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/smc.2019.8914552` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1109/syseng.2017.8088251` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1145/3267955.3267967` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.1145/3292674` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.11591/eei.v12i5.5236` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.14279/tuj.eceasst.80.1134` | Exact DOI; Task B | 0 | 1 | 0 new | DataCite verified; Crossref 404; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.14569/ijacsa.2022.0130295` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.14569/ijacsa.2023.0141038` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | DataCite | `https://api.datacite.org/dois/10.14279/tuj.eceasst.80.1134` | Exact DOI; Crossref 404 fallback | 1 | 1 | 0 new | DataCite verified; Crossref 404; not a DOI defect merely because Crossref does not register it |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc6202` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc6455` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc8259` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc8446` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc8949` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc9110` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc9112` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.17487/rfc9293` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.22214/ijraset.2026.77541` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.2313/net-2018-03-1_02` | Exact DOI; Task B | 0 | 1 | 0 new | DataCite verified; Crossref 404; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.2352/issn.2470-1173.2021.3.mobmu-038` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | DataCite | `https://api.datacite.org/dois/10.2313/net-2018-03-1_02` | Exact DOI; Crossref 404 fallback | 1 | 1 | 0 new | DataCite verified; Crossref 404; not a DOI defect merely because Crossref does not register it |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.23919/cisti49556.2020.9140905` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.23939/acps2024.01.009` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.2478/sbeef-2023-0008` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.24846/v26i4y201704` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.32877/bt.v8i2.3223` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/app11114879` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/electronics12010017` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/en12101957` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/en13154035` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/en14185817` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/s21134559` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/s21206904` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/s23104896` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/s24092781` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/technologies13120583` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3390/telecom7020043` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.33971/ijmrai.1.2.10` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.35784/jcsi.2452` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.3934/energy.2024037` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.5121/ijcnc.2022.14201` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.5281/zenodo.51613` | Exact DOI; Task B | 0 | 1 | 0 new | DataCite verified; Crossref 404; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.53894/ijirss.v8i1.4414` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.55056/jec.745` | Exact DOI; Task B | 1 | 1 | 0 new | Crossref verified; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | DataCite | `https://api.datacite.org/dois/10.5281/zenodo.51613` | Exact DOI; Crossref 404 fallback | 1 | 1 | 0 new | DataCite verified; Crossref 404; not a DOI defect merely because Crossref does not register it |
| 2026-10-03 | lit-verifier | Crossref | `https://api.crossref.org/works/10.7236/ijasc.2023.12.1.9` | Exact DOI; Task B | unresolved | 1 | 0 new | unresolved; metadata retained in verification-task-b-doi.json |
| 2026-10-03 | lit-verifier | DataCite | `https://api.datacite.org/dois/10.7236/ijasc.2023.12.1.9` | Exact DOI; Crossref 404 fallback | unresolved | 1 | 0 new | unresolved; not a DOI defect merely because Crossref does not register it |

| Date | Agent | Database | Query string | Filters | Hits | Screened | Included | Notes |
|------|-------|----------|--------------|---------|------|----------|----------|-------|
| 2026-10-03 | lit-verifier | DOI registration agency / resolver | `https://doi.org/ra/10.7236/IJASC.2023.12.1.9; https://doi.org/10.7236/IJASC.2023.12.1.9` | Hong DOI exception; printed DOI confirmed in publisher PDF | 1 | 1 | 0 new | KISTI confirmed by doi.org agency API; DOI302 redirects to Koreascience but destination returned empty response. Printed publisher PDF p.9 independently confirms DOI/title/authors/year. Web tool failed; curl agency request succeeded. |
