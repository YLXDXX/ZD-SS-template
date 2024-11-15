#!/bin/bash

find . -type f -name "*.svg" -print0 | while read -d $'\0' file
do
    name=$(basename -s .svg "$file")
    
    inkscape "$file" -d 150 -o "../png/dpi_150/$name.png"
    echo "../png/dpi_150/$name.png"
    
    inkscape "$file" -d 300 -o "../png/dpi_300/$name.png"
    echo "../png/dpi_300/$name.png"
    
    inkscape "$file" -d 600 -o "../png/dpi_600/$name.png"
    echo "../png/dpi_600/$name.png"
    
done




