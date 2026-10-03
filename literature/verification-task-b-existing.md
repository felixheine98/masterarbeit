# Task B verification — existing-source findings

Agent: lit-verifier · Date: 2026-10-03

All 25 numbered findings in `findings/existing-sources.md` were rechecked against local full texts: Sarafov printed pp. 8–13 (PDF pages 2–7), Muller printed pp. 4, 7–10 and 43 (PDF pages 14, 17–20 and 53), Dizdarević arXiv v2 Secs. 2.2, 3.1, 3.2, 3.6 and 4.2, Jara Ochoa publisher XML Secs. 4.5, 6.1 and 7, and Mishra/Guru printed pp. 885–890 (PDF pages 4–9). Quotes were compared with extracted text, allowing line-break hyphens and XML reference spacing; claim context, source tables and pagination were read separately.

## Results and corrections

21 findings retain a verified status, including qualified source reports and documented source defects. Four findings are marked corrected: S1-F3 distinguishes Sarafov's two-byte MQTT fixed-header simplification and L4–L7 model totals from normative framing; S2-F1 no longer implies a fresh connection for every HTTP polling exchange; S4-F4 shortens the quotation and treats the proposed HTTP/header explanation as the authors' conjecture; S5-F5 replaces an overlong nested quotation with a literal author excerpt.

The paper-level problems remain explicit. Muller gives incompatible WebSocket overhead examples. Jara Ochoa reports conflicting HTTP mean power in prose versus tables/equations and does not establish a formal significance test. Mishra/Guru leaves simulation parameters as placeholders, mixes ratio and byte units, inadequately explains HTTP 0% delivery and provides incorrect metadata for a Dizdarević reference. These findings verify the presence of defects; they do not endorse the reported results.

The historical Task-A categorical assertion about IJRASET's peer review was narrowed. Presence on a potential-predatory list and absence from DOAJ do not independently establish the article's review process. The recommendation to exclude its quantitative claims rests on defects actually read in the paper. First-author student status is not a reason to reject a source.

Bayılmış was retrieved in Task B as a legal publisher PDF from Karabük University and verified by the Related Work auditor (F22). Its record, file fields and outstanding-acquisition lists were updated. The original existing-source ledger keeps the original assignments for provenance but explains their poor RQ3 fit; the single thesis structure now places power studies with energy background and actual serialization studies in RQ3.

## Remaining limits

- Viswanathan: source identity rests on author/institution and requires Felix's confirmation; no full text available.
- Jara Ochoa: XML content verified, no printed PDF page numbers claimed.
- Dizdarević: preprint content verified; final ACM pagination/version differences remain unverified.
- Sarafov and Muller: grey literature; use primary protocol specifications for normative header sizes.

No new literature topic was introduced. Root-level DOI lookup accounting is in `search-logs/lit-verifier.md`; registry responses and manual exceptions are retained in `verification-task-b-doi.json`.
