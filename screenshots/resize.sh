filename=${1%.*}
target=$filename-sm.png
echo Saving to $target
convert $filename.png -resize '600x400>' $filename-sm.png
