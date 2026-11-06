# Museum label reader (Steps 1–3)

The museum specimen label module of [*editha*](../README.md). Step-by-step instructions: [label reader guide](https://montejo-kovacevich-lab.github.io/editha/label-reader.html).

Three standalone single-file HTML apps. Open a file in your browser, drop in images or CSVs, paste an API key. All API calls go directly from the page to OpenAI or Anthropic; nothing is uploaded anywhere else. Results, prompts and settings are kept in the browser (localStorage) until you click **Start over**.

| File | Step | Input | Output |
|---|---|---|---|
| `1-transcribe-ocr-V.3.0.html` | 1. Transcribe | Folder of label images | CSV: `Specimen.image, Image.name, Segments, Model` |
| `2-data-structuring-V.3.0.html` | 2. Structure | Step 1 CSV | Darwin Core CSV plus a `Tags` column |
| `3-manual-checks-reruns-V.4.0.html` | 3. Check and rerun | Step 2 CSV, folder of crops, optional specimen photos | Corrected CSV, Parse 2/3 CSVs, comparison CSV, run info |

**GBIF-ready output.** Step 2 names its columns with Darwin Core terms, the standard GBIF uses, so the finished spreadsheet needs no renaming. Before publishing, add the fields that are not on a label (such as `occurrenceID` and `basisOfRecord`) and remove the helper columns (`Tags`, `.parse1`, `.parse2`, `.source`). See [Getting data into GBIF](../README.md#getting-data-into-gbif).

Each app has a **Simplified mode** and an **Export run info** button (counts, tokens, settings and full prompts, for a methods section).
