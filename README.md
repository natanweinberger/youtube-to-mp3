# youtube-to-mp3

`youtube-to-mp3` downloads audio tracks from YouTube videos, then tags them with user-provided artist and title metadata.

Setup is quick! Set an environment variable `YTMP3_OUTPUT_DIR`, build the Docker image, and you're ready to start downloading audio from YouTube.

# Tech stack

`youtube-to-mp3` is open source and is fully containerized!

It uses some great open source software:

- 🐳 __Docker__
- [__pytube__](https://github.com/nficano/pytube): Download YouTube video/audio tracks
- [__ffmpeg__](https://ffmpeg.org/): Convert to MP3
- [__mutagen__](https://github.com/quodlibet/mutagen): Set artist, album and title tags

## How does it work?

When you run `youtube-to-mp3`, here's what happens:

1. A Docker container starts up, the directory at `$YTMP3_OUTPUT_DIR` is mounted as a volume

2. You are prompted for the YouTube URL and the track metadata

3. `pytube` downloads the best available audio track

4. `ffmpeg` converts the file to MP3 format

5. `mutagen` tags the file with the metadata you provided

6. The audio file is moved to the output directory

7. The container is stopped and removed

# Quick start

1. Clone this repo

```bash
~ $ git clone https://github.com/natanweinberger/youtube-to-mp3 && cd youtube-to-mp3
```

2. Build the Docker image

```bash
~/youtube-to-mp3 $ make build
```

3. In your `.bashrc`/`.zshrc`:

- Set `YTMP3_OUTPUT_DIR` to the directory where you want the audio file to be output
- (Optional) Add the repo to your `PATH` to be able to run it from anywhere with the command `ytmp3`

```bash
# ~/.zshrc
export YTMP3_OUTPUT_DIR=~/Documents/Spotify
export PATH=$PATH:~/.../youtube-to-mp3
```

4. Run `ytmp3`, which will prompt you for the URL of the video and the artist and song metadata

```bash
~ $ ytmp3
URL: https://www.youtube.com/watch?v=DY-7adE4EVM
Artist: Parcels
Title: Live at Reeperbahn Festival (2018)
```

# Setting up local discovery in music apps

Most apps look for local audio files in user-specified directories. If you set `YTMP3_OUTPUT_DIR` to a directory that you want your app to auto-discover from, here's how to get your app configured to look in that directory.

## Spotify

Follow [Spotify's guide on enabling local files](https://support.spotify.com/us/article/listen-to-local-files/) in the desktop client. It also details how to sync local files to other devices.
