#!/bin/bash

# Set the directory to start the search from
DIR="./"

# Find files with ":" in their name
find "$DIR" -type f -name '*:*' | while read -r file; do
    # Get the new filename by removing the colon
    newfile=$(echo "$file" | tr -d ':')
    
    # Rename the file
    mv "$file" "$newfile"
    
    # Search and replace the old filename with the new filename in all files
    # This assumes that the filenames are unique enough that replacing them won't affect other content
    find "$DIR" -type f -exec sed -i "s|$(basename "$file")|$(basename "$newfile")|g" {} +
done

