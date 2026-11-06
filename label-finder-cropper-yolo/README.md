# *editha* label finder and cropper (Step 0)

Part of [*editha*](../README.md). This step is optional: you only need it if your images are photos of whole specimens and you want each label cropped to its own image. If you already have images of individual labels, notebook pages or ledger scans, skip to [`museum-label-reader`](../museum-label-reader/).

This app lets you train a model to identify labels (or any other object) in images, and then crops the labels. 

How it works: you teach what to look for by drawing boxes on a handful of images first, so it can learn to find anything that looks reasonably consistent — specimen labels, pages
of a book, signs, forms, plant tags.

---

# Installation

There are two ways to install. Pick the one that matches you:

| | Who it's for | What you need |
|---|---|---|
| **[Option A — Easy install](#option-a--easy-install-no-coding)** | Anyone. No terminal, no commands. | Just a mouse |
| **[Option B — Terminal install](#option-b--terminal-install)** | People comfortable with a command line | Git and Python |

Both options install the same app and work identically once running.

---

## Option A — Easy install (no coding)

**1. Install Python (one time only)**

Download Python **3.10 or newer** from https://www.python.org/downloads/ and run
the installer.

- On **Windows**, tick the box that says **"Add Python to PATH"** on the first
  screen of the installer. This matters.
- On **macOS**, just click through the installer.

**2. Download the app**

[**Download the app (ZIP)**](https://github.com/montejo-kovacevich-lab/editha/archive/refs/heads/main.zip)

Unzip it somewhere you'll find again, like your Desktop or Documents, and open
the `label-finder-cropper-yolo` folder.

(Or go to https://github.com/montejo-kovacevich-lab/editha, click the green
**Code** button, then **Download ZIP**.)

**3. Install it — double-click once**

Double-click:

- **macOS:** `Install editha label finder.command`
- **Windows:** `Install editha label finder.bat`

A black window opens and installs everything into a private `.venv` folder
inside the app folder (nothing is installed elsewhere on your computer). This
takes several minutes and downloads around 2 GB, so stay on a good connection.
When it says **"Installation complete"**, close the window.

You only do this once.

> **macOS security warning (expected):** the first time you double-click a
> `.command` file, macOS blocks it with a message like *"Apple could not verify
> ... is free of malware"* or *"cannot be opened because it is from an
> unidentified developer"*. The file is not signed with an Apple developer
> certificate, which is why this appears. To allow it:
>
> 1. Double-click the file once, and click **Done** (or **OK**) on the warning.
> 2. Open **System Settings** (called **System Preferences** on older Macs) →
>    **Privacy & Security**.
> 3. Scroll down to the **Security** section. You will see a message that the
>    file "was blocked". Click **Open Anyway** and enter your password.
> 4. Double-click the file again and click **Open** in the dialog.
>
> You do this once for each of the two `.command` files (install and start).
> On older macOS versions, **right-click** the file, choose **Open**, then click
> **Open** in the dialog instead.
>
> If it says "permission denied" instead, open Terminal, type `chmod +x `
> (with a trailing space), drag the file onto the Terminal window, and press Enter.
>
> **Windows:** if Windows SmartScreen says "Windows protected your PC", click
> **More info**, then **Run anyway**.

**4. Start the app — double-click any time**

Double-click:

- **macOS:** `Start editha label finder.command`
- **Windows:** `Start editha label finder.bat`

The app opens in your web browser. A black window stays open in the background —
**leave it open** while you work; closing it stops the app.

When you're finished, close the browser tab and then close the black window.

(If you start the app before installing, it installs itself first.)

**Updating:** download the ZIP again and copy your `projects` folder into the new
app folder. Your work is stored in `projects/`.

---

## Option B — Terminal install

### 1. Install Python

Python **3.10 or newer** is required. Check what you have:

```bash
python --version
```

If you need it, download Python from https://www.python.org/downloads/

### 2. Clone the repository

```bash
git clone https://github.com/montejo-kovacevich-lab/editha
cd editha/label-finder-cropper-yolo
```

### 3. Install requirements

Install the required packages:

```bash
python -m pip install -r requirements.txt
```

### 4. Download the base model

Training starts from a small pretrained model, `yolov8s.pt`, which has to sit in
the app folder. Download it once:

```bash
python -c "from ultralytics import YOLO; YOLO('yolov8s.pt')"
```

### 5. Run the app

Make sure you are inside the `editha/label-finder-cropper-yolo` directory, then:

```bash
python -m streamlit run app.py
```

The app opens in your browser. Choose a step from the sidebar.

> **Use `python -m streamlit`, not plain `streamlit`.** If you have Anaconda or
> Miniconda installed, a bare `streamlit` command often starts a *different*
> Python that has none of these packages, and the app fails with
> `ModuleNotFoundError`. Writing it this way always uses the environment you
> just activated.
>
> If your prompt shows `(base)` — with or without `(.venv)` — run
> `conda deactivate` first, then `source .venv/bin/activate`. The prompt should
> read `(.venv)` on its own.

---

# What you need before you start

- **A folder of images.** They stay where they are; the app only ever copies them.
- **Nothing else.** This step needs no API key. Reading the text in the cropped images is done by the apps in
  [`museum-label-reader`](../museum-label-reader/), which do need an OpenAI or
  Anthropic API key.

---

# Projects

The front page is where you create, choose and delete projects. Everything a
project produces is kept in its own folder under `projects/<name>/data/`, so
separate projects never overwrite each other's results.

**Create or choose a project before you start Step 1.** The name shown at the top
of every page is the project your work is being filed under.

> Project names cannot contain spaces — use underscores instead.
>
> If you begin a step without choosing a project, the app files the work under a
> folder literally called `No project selected`. Nothing is lost, but it is not
> filed under a real project: pick one on the front page and run the step again.

---

# Workflow

Work through the steps **in order**, using the sidebar. Each step needs the one
before it to have finished.

## Step 1 — Upload images

Paste the full path to the folder holding your images and choose how many to bring
in. That many are picked at random and **copied** into `data/01_train_val_subset`.
Your originals are never changed.

Around 20–50 is a reasonable start. 20% are held back automatically so the app can
check its own work. Use more if the objects you want to find are complex, or vary a
lot between images.

## Step 2 — Annotate

Draw a box around **every object** you want the app to find, directly in the app.

- **Draw** a box: click and drag on an empty part of the image.
- **Move or resize** a box: click it to select, then drag it or its corner handles.
- **Delete** a box: switch **Mode** (right of the image) from *Transform* to *Del*,
  click the box, then switch back to *Transform*.
- Click **Complete** to save that image. The status line turns green.
- For an image with nothing to find, click **Complete** without drawing, or use
  **Nothing to find here**. These are useful — they teach the app what to ignore.

Your boxes are saved to `data/annotations.json` as you go, so you can close the app
and come back later.

When every image is done, click **Build training set**. This writes the training
files to `data/02_yolo_dataset` (80% to learn from, 20% kept back for checking).

Then open **Check your boxes** and page through a few images. Every red box should
sit around an object. If not, fix the boxes above and build again.

> If you change any boxes afterwards, **click Build training set again** —
> otherwise Step 3 learns from the old boxes. The app warns you when this happens.

## Step 3 — Train the model

Choose the number of training rounds — at least 50 is recommended; more rounds
means better results but a longer wait — then click **Start training**.

This can take minutes to hours depending on your computer and how many images you
used. The trained model is saved to:

```text
runs/detect/1.1/weights/best.pt
```

A full log is written to `runs/train_log.txt`. If training fails, that file usually
says why.

## Step 4 — Predict

Runs the trained model over a folder of images so you can see what it finds, before
you cut anything out. Preview images with the boxes drawn on are written to
`data/03_prediction_preview` — open a few and check they look right.

## Step 5 — Crop

Cuts out one image per object found. You can set:

- **How many images to do** — 0 does all of them.
- **Extra space around each cut-out** — pixels kept around the edge.
- **Minimum confidence** — only objects the model is at least this sure about are
  cut out (0.90 by default; lower it if too few are coming through).

Cut-outs are saved to `data/04_cropping_result`.


---

# Where everything is saved

Everything lives under the folder for the project you have chosen:

```text
projects/<your project>/
  data/01_train_val_subset     images brought in at Step 1
  data/annotations.json        the boxes you drew at Step 2
  data/02_yolo_dataset         the training set built at Step 2
  data/03_prediction_preview   previews from Step 4
  data/04_cropping_result      cut-out images from Step 5
```

---

# Important notes

⚠️ **Please read!**

- Work through the steps **in order**, and let each one finish before starting the
  next. Training in particular can take minutes to hours; wait until it reports
  success.

- **Starting fresh.** To begin again with a different set of images, create a new
  project on the front page. The old project's results stay where they are. To
  redo a project in place instead, delete its `data/` and `runs/` folders.