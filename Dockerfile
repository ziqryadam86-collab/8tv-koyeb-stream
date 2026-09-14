FROM ubuntu:22.04

# Elak soalan interaktif semasa pemasangan
ENV DEBIAN_FRONTEND=noninteractive

# Pasang FFmpeg, Nginx, dan Curl
RUN apt-get update && apt-get install -y \
    ffmpeg \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Buat folder penstriman
RUN mkdir -p /var/www/html/8tv-live-tv && chmod -R 755 /var/www/html

# Salin skrip pelancar
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Dedahkan port HTTP Nginx
EXPOSE 8000

CMD ["/start.sh"]

