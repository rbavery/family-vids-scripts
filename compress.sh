#!/bin/bash

# Parse command-line arguments
if [[ $# -ne 2 && $# -ne 3 ]]; then
    echo "Usage: $0 <input_dir> <output_dir> [--dry-run]"
    exit 1
fi

input_dir="$1"
output_dir="$2"
dry_run=false

# Check if --dry-run flag is set
if [[ $# -eq 3 && $3 == "--dry-run" ]]; then
    dry_run=true
fi

# Loop through all .dv files in the input directory
for file in "$input_dir"/*.dv; do
    # Extract the filename without extension
    filename=$(basename "$file" .dv)
    # Set the output file path
    output_file="$output_dir/$filename.mp4"
    # Build the FFmpeg command
    command="ffmpeg -i \"$file\" -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 128k \"$output_file\""
    # Check if dry-run flag is set
    if [[ $dry_run == true ]]; then
        echo "$command"
    else
        # Run the FFmpeg command on the input file
        eval "$command"
    fi
done
