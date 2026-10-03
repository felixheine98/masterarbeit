# Masterarbeit – Arbeitsrepo

Thesis-Kontext, Literatur-Agents und Recherche-Ergebnisse für Claude Code und OpenAI Codex CLI.

## 1. Einrichten auf dem Homeserver

```bash
# ZIP auf den Server kopieren (vom Rechner aus)
scp masterarbeit.zip user@homeserver:~/

# auf dem Server
unzip masterarbeit.zip && cd masterarbeit
chmod +x scripts/*.sh
sudo apt install poppler-utils      # pdftotext/pdfinfo für Seitenextraktion
git init && git add . && git commit -m "Initial: Thesis-Kontext und Literatur-Agents"
```

Optional ein privates Remote (GitHub/Gitea) hinzufügen, dann hast du Backup und Versionierung aller Agent-Ergebnisse. Die PDFs sind per `.gitignore` ausgenommen und brauchen ein eigenes Backup.

**Als Erstes:** deine aktuelle Gliederung in `docs/thesis-struktur.md` einfügen. Die Datei aus der alten Claude-Session war nicht mehr verfügbar.

## 2. Literatur-Agents mit Claude Code

```bash
cd masterarbeit && claude
```
Dann im Chat zum Beispiel:
> Starte lit-rq1, lit-rq2, lit-rq3, lit-rq4 und lit-related-work parallel und parallel dazu lit-verifier Task A.

Wenn alle fertig sind:
> Führe scripts/merge-literature.sh aus und starte dann lit-verifier Task B.

Claude Code findet die Agents automatisch in `.claude/agents/`. Liste mit `/agents`.

## 3. Literatur-Agents mit Codex

```bash
scripts/run-codex-lit.sh                 # alle Recherche-Agents parallel
scripts/run-codex-lit.sh lit-verifier    # danach der Verifier
```
Die Agents brauchen Netzwerkzugriff. Prüfe mit `codex exec --help`, welche Sandbox-Flags deine Version hat, und setze sie über `CODEX_FLAGS`.

## 4. Ablauf

1. **Recherche:** Agents suchen, laden Open-Access-PDFs, schreiben Suchprotokoll, Findings und BibTeX (jeder in eigene Dateien).
2. **Mergen:** `scripts/merge-literature.sh` erzeugt `search-log.md`, `references.bib`, `to-acquire.md`.
3. **PDFs besorgen:** Quellen aus `literature/to-acquire.md` über die FH-Bibliothek herunterladen, als `literature/pdfs/<bibkey>.pdf` speichern.
4. **Nachziehen:** Den zuständigen Agent bzw. `lit-verifier` erneut laufen lassen, damit er Seitenangaben aus den neuen PDFs extrahiert.
5. **Prüfen:** `lit-verifier` Task B gleicht Zitate und Seiten mit den PDFs ab → `literature/verification-report.md`.
6. **Selbst stichprobenartig gegenlesen**, bevor etwas in die Arbeit wandert. Die Verantwortung für korrekte Zitate bleibt bei dir.

## 5. Zitieren

- Standard: APA 7 mit Seite, z. B. *(Dizdarević et al., 2019, p. 12)*. Bei Quellen ohne Seitenzahlen (arXiv, Standards): *(…, Sec. 4.2)*.
- Den vorgeschriebenen Stil im Leitfaden der FH Kufstein prüfen und ggf. in `AGENTS.md` anpassen.
- Seitenangabe = gedruckte Seite der Zeitschrift/des Tagungsbands, nicht PDF-Seite. Die Agents notieren den Offset pro PDF.
- Zotero: `literature/references.bib` importieren. Oder umgekehrt Zotero + Better BibTeX automatisch in diese Datei exportieren lassen (dann die Agents nur noch in `bib/<agent>.bib` schreiben lassen und mergen).

## Struktur

```
AGENTS.md / CLAUDE.md   Kontext für Codex / Claude Code (CLAUDE.md importiert AGENTS.md)
docs/                   Überblick, Methodik, Gliederung, alte Notizen
literature/             Regeln, Findings, Suchprotokolle, BibTeX, PDFs
scripts/                pdf-page.sh, merge-literature.sh, run-codex-lit.sh
.claude/agents/         6 Agent-Definitionen (auch von run-codex-lit.sh genutzt)
```
