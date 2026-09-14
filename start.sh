#!/bin/bash

# Configuration port Nginx ke 10000 untuk Render
sed -i 's/80/10000/g' /etc/nginx/sites-available/default

# Tambah Header CORS ke dalam Nginx
sed -i '/location \/ {/a \        add_header Access-Control-Allow-Origin *;\n        add_header Access-Control-Allow-Methods "GET, OPTIONS";\n        add_header Access-Control-Allow-Headers "*";' /etc/nginx/sites-available/default

# Jalankan Nginx
nginx

# Perulangan FFmpeg (Audio Bahasa Melayu)
while true
do
  echo "Memulakan penstriman 8TV (Audio BM)..."
  
  ffmpeg -re \
  -user_agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  -c:v decryption_key 1a05bebf706408431a390c3f9f40f410:89c5ff9f8e65c7fe966afbd2f9128e5f \
  -i "https://linearjitp-playback.astro.com.my/dash-wv/linear/509/default_ott.mpd" \
  -map 0:v:0 \
  -map 0:m:language:may \
  -vf "scale=640:360,fps=15" \
  -c:v libx264 -preset ultrafast -b:v 400k -maxrate 400k -bufsize 800k \
  -c:a aac -b:a 64k \
  -f hls \
  -hls_time 10 \
  -hls_list_size 10 \
  -hls_flags delete_segments \
  -hls_segment_filename "/var/www/html/8tv-live-tv/%d.ts" \
  /var/www/html/8tv-live-tv/index.m3u8

  echo "Stream terputus! Sambung semula dalam 5 saat..."
  sleep 5
done
