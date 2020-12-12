# youtube-to-mp3

This package downloads YouTube audio tracks, then tags them with specified artist and title metadata.

By setting the environment variable `$LOCAL_MUSIC_DIR`, the tagged MP3s will output directly to your Spotify or Apple Music local files directory and will be auto-discovered by your music app.


# Quick start

1. Clone this repo.

```bash
$ git clone https://github.com/natanweinberger/youtube-to-mp3
```

2. In your `.bashrc`/`.zshrc`, set `LOCAL_MUSIC_DIR` to the directory where your music app looks for local files.

Optionally, you can also add the repo to your `PATH` to be able to run it from anywhere.

```bash
# ~/.zshrc
export LOCAL_MUSIC_DIR=~/Documents/Spotify
export PATH=$PATH:~/.../youtube-to-mp3
```

3. Run `ytmp3`, which will prompt you for the URL of the video and the artist and song metadata.

```bash
$ ytmp3
URL: https://www.youtube.com/watch?v=DY-7adE4EVM
Artist: Parcels
Title: Live at Reeperbahn Festival (2018)
```

# Local files in Spotify

Follow [Spotify's guide on enabling local files](https://support.spotify.com/us/article/listen-to-local-files/) in the desktop client. It also details how to sync local files to other devices.
