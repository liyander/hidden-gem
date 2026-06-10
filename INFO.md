# Hidden Gem

## Challenge Info

| Field | Details |
|-------|---------|
| **Name** | Hidden Gem |
| **Category** | Forensics |
| **Difficulty** | Easy |
| **Points** | 150 |
| **Flag Format** | `blackperl{...}` |
| **Access** | Web browser (ttyd terminal) |
| **Technologies** | PNG format, appended data, ttyd |

## Description

A PNG image has hidden data appended after the IEND chunk. Use `strings` or `binwalk` to find it.

## Objective

Extract hidden data from a PNG file that has text appended after the image data.

## What You Will Learn

- That files can have data appended after their normal end
- How to use `strings` to extract text from binary files
- How to use `binwalk` to scan for embedded files
- Basic file forensics

## Skills Required

- Basic command line
- `strings` command or `binwalk`

## Hints

1. The file is a valid PNG but larger than expected.
2. Use `strings dark_pearl.png | grep blackperl` to extract readable text.
3. Use `binwalk dark_pearl.png` to scan for hidden data.
4. Use `exiftool dark_pearl.png` to view metadata.

## Tools Included in Terminal

- `strings` - Extract readable strings from files
- `binwalk` - Scan and extract embedded files
- `exiftool` - View file metadata
- `unzip` - Extract ZIP archives
- `file` - Identify file types

## Access Method

This challenge uses **ttyd** (web-based terminal) so players can access it through a browser:

1. Open the challenge URL in a web browser
2. A terminal interface appears
3. Login with credentials: `ctfuser` / `ctfuser`
4. Solve the challenge using included tools

## Setup

### Local (Docker)
```bash
docker build -t hidden-gem .
docker run -d -p 10000:10000 --name hidden-gem hidden-gem
```

Visit http://localhost:10000

### Render Deployment
1. Push to GitHub
2. Create Web Service on Render
3. Set Root Directory: `challenges/hidden-gem`
4. Set Runtime: `Docker`
5. Add env var: `PORT=10000`
6. Deploy

Players access via the Render URL in their browser.

## Files Provided

- Web-based terminal access
- Credentials: `ctfuser` / `ctfuser`
- `dark_pearl.png` in home directory
- Hint file at `/home/ctfuser/hint.txt`
