PROCESSING_DIR=/tmp
OUTPUT_DIR=/home

###############################
# 1. Download the audio track #
###############################

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


##############################
# 2. Convert the file format #
##############################

# Convert the downloaded MP4 to an MP3 file
function convert_to_audio() {
    target_dir=$1

    # Determine the origin and destination filepaths
    filepath_mp4=$(find "$target_dir" -type f -name *.mp4)
    filepath_mp3=$(echo "$filepath_mp4" | sed 's/.mp4/.mp3/')

    # Execute the conversion
    pv "$filepath_mp4" | ffmpeg -i pipe:0 "$filepath_mp3" -loglevel warning

    [[ -f "$filepath_mp4" ]] && rm "$filepath_mp4"
}

####################################
# 3. Set the artist and title tags #
####################################

function set_metadata() {
    filepath=$1
    artist=$2
    title=$3

    mid3v2 --artist "$artist" --song "$title" --album "$title" --genre "Live" "$filepath"
}

#################
# Main function #
#################

# Get input from user
function get_metadata_input() {
    echo -n "URL: "
    read url
    echo -n "Artist: "
    read artist
    echo -n "Title: "
    read title
}

function main() {
    url=$1
    artist=$2
    title=$3

    [[ -z "$url" ]] && get_metadata_input

    echo "Dowloading $url"
    download $url $PROCESSING_DIR

    echo "Converting to mp3"
    convert_to_audio $PROCESSING_DIR

    echo "Setting metadata tags"
    set_metadata "$(find $PROCESSING_DIR -type f -name *.mp3)" "$artist" "$title"

    echo "Moving mp3 to output destination"
    mv $PROCESSING_DIR/*.mp3 $OUTPUT_DIR

    echo "Done!"
}

main $@
