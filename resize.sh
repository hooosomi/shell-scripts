#!/bin/zsh

# コマンドライン引数でファイル名とスケールファクターを受け取る
filename=$1
scale_factor=$2

# 引数が正しく渡されているかを確認
if [ -z "$filename" ] || [ -z "$scale_factor" ]; then
    echo "Usage: $0 <filename> <scale_factor>"
    exit 1
fi

# 画像をアスペクト比を維持してリサイズ
sips -Z $(sips -g pixelHeight -g pixelWidth $filename | \
awk -v scale=$scale_factor '/pixelWidth/ {w=$2}/pixelHeight/ {h=$2} \
END {if (w > h) print w*scale; else print h*scale}') $filename