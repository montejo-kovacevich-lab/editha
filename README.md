# Editha

A no-code pipeline for transcribing museum specimen labels (and other archival text) into structured biodiversity data, using YOLO for label detection and vision-LLM API calls for transcription. Working name: **Syngraph**.

Aimed at museum staff who can't code. Nothing is uploaded anywhere except directly from your browser to OpenAI or Anthropic.

## Repository layout

| Folder | Step | What it is | Needs |
|---|---|---|---|
| [`label-finder-cropper-yolo/`](label-finder-cropper-yolo/) | 0 (optional) | Streamlit app: a YOLOv8 model finds labels in photos of whole specimens and crops each to its own PNG. Annotate ~20–80 images and retrain if it misses labels on a new collection. | Python |
| [`museum-label-reader/`](museum-label-reader/) | 1–3 | Three single-file HTML apps that run entirely in the browser. | A browser and an OpenAI or Anthropic API key |

### Pipeline

0. **Find and crop labels** (`label-finder-cropper-yolo`): only for photos of whole specimens. Skip it if you already have images of individual labels, notebook pages or ledger scans.
1. **Transcribe** (`museum-label-reader/1-transcribe-ocr-V.3.0.html`, "Museum label OCR"): label images in, diplomatic transcription CSV out.
2. **Structure** (`museum-label-reader/2-data-structuring-V.3.0.html`, "Museum label structuring"): Step 1 CSV in, Darwin Core columns out.
3. **Check and rerun** (`museum-label-reader/3-manual-checks-reruns-V.4.0.html`, "Multi-parsing and manual corrections"): manual review, re-reads from the image, agreement/flip rates, corrected CSV.

See each folder's README for details.
