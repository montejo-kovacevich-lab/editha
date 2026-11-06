# *editha*

A no-code pipeline for turning images of text into structured data, using YOLO for finding text regions and vision-LLM API calls for transcription and structuring.

*editha* works on any text: labels, ledgers, notebooks, forms, signs. It will have modules specialised for **museum specimen labels** and **biodiversity archives**, plus one more **open-ended** module for any other kind of text.

The structured output is built to be **GBIF-ready**: its columns use Darwin Core, the standard that GBIF (the Global Biodiversity Information Facility) uses for specimen records. See [Getting data into GBIF](#getting-data-into-gbif) below.

It is aimed at people who can't code. Nothing is uploaded anywhere except directly from your browser to OpenAI or Anthropic.

## Guides

**Start here: [the *editha* guides](https://montejo-kovacevich-lab.github.io/editha/)**. Plain-language instructions for what *editha* does and how to run each part: an [overview](https://montejo-kovacevich-lab.github.io/editha/), a [label finder guide](https://montejo-kovacevich-lab.github.io/editha/label-finder.html) and a [label reader guide](https://montejo-kovacevich-lab.github.io/editha/label-reader.html).

## Repository layout

| Folder | Step | What it is | Needs |
|---|---|---|---|
| [`label-finder-cropper-yolo/`](label-finder-cropper-yolo/) | 0 (optional) | Streamlit app: a YOLOv8 model finds labels (or any object) in an image and crops each to its own PNG. If the pretrained model misses things on a new collection, train a free model with a small number of annotated images. | Python 3.10+ (one-click installer for macOS and Windows) |
| [`museum-label-reader/`](museum-label-reader/) | 1–3 | The museum label module: three single-file HTML apps that run entirely in the browser. | A browser and an OpenAI or Anthropic API key |

Modules for biodiversity archives and a more open-ended module are planned.

### Pipeline (museum label module)

0. **Find and crop labels** (`label-finder-cropper-yolo`): only for photos of whole specimens. Skip it if you already have images of individual labels, notebook pages or ledger scans.
1. **Transcribe** (`museum-label-reader/1-transcribe-ocr-V.3.0.html`, "Museum label OCR"): label images in, diplomatic transcription CSV out.
2. **Structure** (`museum-label-reader/2-data-structuring-V.3.0.html`, "Museum label structuring"): Step 1 CSV in, Darwin Core (GBIF-ready) columns out.
3. **Check and rerun** (`museum-label-reader/3-manual-checks-reruns-V.4.0.html`, "Multi-parsing and manual corrections"): manual review, re-reads from the image, agreement/flip rates, corrected CSV.

See each folder's README for details.

## Getting data into GBIF

The columns editha produces are named with [Darwin Core](https://dwc.tdwg.org/) terms (for example `eventDate`, `locality`, `recordedBy`), which is the standard GBIF uses. So you do not have to rename anything to publish. Before you upload, two things are usually left for you to do:

- **Add the fields that are not on the label.** GBIF requires a few things that labels rarely carry, such as a unique identifier for each record (`occurrenceID`) and the type of record (`basisOfRecord`). Add them as new columns in a spreadsheet program, since the AI can only read what is printed on the label. Check [GBIF's current requirements](https://www.gbif.org/publishing-data) for the full list.
- **Remove the helper columns.** The files include extra columns for checking, such as `Tags`, `.parse1`, `.parse2` and `.source`. They are not Darwin Core, so leave them out of what you publish.

editha does not publish anything to GBIF for you. You upload the finished spreadsheet yourself, for example through your institution's data publisher or a GBIF publishing tool.
