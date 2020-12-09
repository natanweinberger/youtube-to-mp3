TARGET_DIR=/tmp
VOLUME_DIR=/home

function get_itag() {
    source=$1
    echo $source | sed -E 's/.+itag="([[:digit:]]+)".+/\1/g'
}

function download() {
    url=$1
    target_dir=$2

    sources=$(pytube $url --list)
    filtered_sources=$(echo "$sources" | grep audio | grep mp4)
    itag=$(get_itag "$filtered_sources")

    pytube $url --itag $itag --target $target_dir
}

function convert_to_audio() {
    target_dir=$1
    filepath_mp4=$(find "$target_dir" -type f -name *.mp4)
    filepath_mp3=$(echo "$filepath_mp4" | sed 's/.mp4/.mp3/')
    ffmpeg -i "$filepath_mp4" "$filepath_mp3" -loglevel warning -stats

    [[ -f "$filepath_mp4" ]] && rm "$filepath_mp4"
}

function set_metadata() {
    filepath=$1
    artist=$2
    title=$3

    mid3v2 --artist "$artist" --song "$title" --album "$title" --genre "Live" "$filepath"
}

function main() {
    url=$1
    artist=$2
    title=$3

    download $url $TARGET_DIR
    convert_to_audio "$TARGET_DIR"
    set_metadata "$(find "$TARGET_DIR" -type f -name *.mp3)" "$artist" "$title"
    mv $TARGET_DIR/*.mp3 $VOLUME_DIR
}

main "$1" "$2" "$3"
