# Challenge 5: Hidden Gem (Easy)

**Category:** Forensics  
**Difficulty:** Easy  
**Points:** 150  
**Flag:** `blackperl{h1dd3n_4ft3r_13nd_ch4nk}`

## Description

A PNG image has hidden data appended after the IEND chunk. Use `strings` or `binwalk` to find it.

## Access

**Web Terminal:** Open the deployed URL in your browser (e.g., `https://hidden-gem.onrender.com`)

A web-based terminal will appear. Login with:
- **Username:** `ctfuser`
- **Password:** `ctfuser`

## Walkthrough

### Step 1: Login

Open the web terminal URL in your browser and login as `ctfuser`.

### Step 2: Read the Hint

```bash
cat hint.txt
```

### Step 3: Check the File

```bash
file dark_pearl.png
```

It's a valid PNG, but the file size is larger than expected.

### Step 4: Use strings Command (Quickest)

```bash
strings dark_pearl.png | grep blackperl
```

Output:
```
blackperl{h1dd3n_4ft3r_13nd_ch4nk}
```

### Alternative: Use binwalk

```bash
binwalk dark_pearl.png
```

Shows data appended after the PNG IEND chunk.

### Alternative: Use exiftool

```bash
exiftool dark_pearl.png
```

View metadata and any embedded information.

## Running Locally

```bash
docker build -t hidden-gem .
docker run -d -p 10000:10000 --name hidden-gem hidden-gem
```

Visit http://localhost:10000 in your browser.

## Deploying to Render

1. Push to GitHub
2. Create new Web Service on Render
3. Configure:
   - **Root Directory:** `challenges/hidden-gem`
   - **Runtime:** `Docker`
   - **Environment Variable:** `PORT=10000`
4. Deploy

Players access the challenge via the Render URL in their browser.
