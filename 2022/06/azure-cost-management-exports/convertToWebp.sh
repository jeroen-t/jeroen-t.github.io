#!/bin/bash
for i in *.png; do
    [ -f "$i" ] || break
    filename=$(basename $i .png)
    cwebp $i -o "$filename.webp"
done