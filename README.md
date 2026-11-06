# *editha*

A no-code pipeline for turning images of text into structured data, using YOLO for finding text regions and vision-LLM API calls for transcription and structuring.

*editha* works on any text: labels, ledgers, notebooks, forms, signs. It will have modules specialised for **museum specimen labels** and **biodiversity archives**, plus one more **open-ended** module for any other kind of text.

It is aimed at people who can't code. Nothing is uploaded anywhere except directly from your browser to OpenAI or Anthropic.

## Guides

Plain-language guides to what *editha* does and how to run each part are in [`docs/`](docs/index.html): an overview, a [label finder guide](docs/label-finder.html) and a [label reader guide](docs/label-reader.html). They are static web pages, so you can open `docs/index.html` in a browser or publish the `docs` folder with GitHub Pages.

## Repository layout

| Folder | Step | What it is | Needs |
|---|---|---|---|
| [`label-finder-cropper-yolo/`](label-finder-cropper-yolo/) | 0 (optional) | Streamlit app: a YOLOv8 model finds labels (or any object) in an image and crops each to its own PNG. If the pretrained model misses things on a new collection, train a free model with a small number of annotated images. | Python 3.10+ (one-click installer for macOS and Windows) |
| [`museum-label-reader/`](museum-label-reader/) | 1–3 | The museum label module: three single-file HTML apps that run entirely in the browser. | A browser and an OpenAI or Anthropic API key |

Modules for biodiversity archives and a more open-ended module are planned.

### Pipeline (museum label module)

0. **Find and crop labels** (`label-finder-cropper-yolo`): only for photos of whole specimens. Skip it if you already have images of individual labels, notebook pages or ledger scans.
1. **Transcribe** (`museum-label-reader/1-transcribe-ocr-V.3.0.html`, "Museum label OCR"): label images in, diplomatic transcription CSV out.
2. **Structure** (`museum-label-reader/2-data-structuring-V.3.0.html`, "Museum label structuring"): Step 1 CSV in, Darwin Core columns out.
3. **Check and rerun** (`museum-label-reader/3-manual-checks-reruns-V.4.0.html`, "Multi-parsing and manual corrections"): manual review, re-reads from the image, agreement/flip rates, corrected CSV.

See each folder's README for details.
