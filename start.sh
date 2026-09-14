#!/bin/bash

# Tukar port Nginx ke 8000 untuk Koyeb
sed -i 's/80/8000/g' /etc/nginx/sites-available/default

# Jalankan Nginx di latar belakang
nginx

# Perulangan FFmpeg (Auto-restart jika terputus)
while true
do
  echo "Memulakan penstriman 8TV..."
  
  ffmpeg -re -decryption_key 721af66b9c3e8c4166b8b4586d1fbefd \
  -i "https://ptv2026.com/myunifi.mpd?username=vip_3klp0es8&password=wg3piwEs&channel=8TV&kid=da1cb24f-55db-4ae1-b323-19c365920539" \
  -vf "scale=640:360,fps=15" \
  -c:v libx264 -preset ultrafast -b:v 400k -maxrate 400k -bufsize 800k \
  -c:a aac -b:a 64k \
  -f hls \
  -hls_time 4 \
  -hls_list_size 10 \
  -hls_flags delete_segments \
  -hls_segment_filename "/var/www/html/8tv-live-tv/%d.ts" \
  /var/www/html/8tv-live-tv/index.m3u8

  echo "Stream terputus! Sambung semula dalam 5 saat..."
  sleep 5
done

