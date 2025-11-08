FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# Metadata labels
LABEL org.opencontainers.image.title="AdsPower Selkies"
LABEL org.opencontainers.image.description="AdsPower in browser via Selkies WebRTC"

# Install dependencies
RUN apt-get update && \
    apt-get install -y fonts-noto-cjk libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xkb1 libxkbcommon-x11-0 \
    shared-mime-info desktop-file-utils libxcb1 libxcb-icccm4 libxcb-image0 \
    libxcb-keysyms1 libxcb-randr0 libxcb-render0 libxcb-render-util0 libxcb-shape0 \
    libxcb-shm0 libxcb-sync1 libxcb-util1 libxcb-xfixes0 libxcb-xkb1 libxcb-xinerama0 \
    libxcb-xkb1 libxcb-glx0 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 \
    libdbus-1-3 libfontconfig1 libgbm1 libgcc1 libgdk-pixbuf2.0-0 libglib2.0-0 \
    libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 \
    libxcomposite1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
    libxss1 libxtst6 libatomic1 libxcomposite1 libxrender1 libxrandr2 libxkbcommon-x11-0 \
    libfontconfig1 libdbus-1-3 libnss3 libx11-xcb1 python3-tk stalonetray

# Install AdsPower
COPY /root/adspower.deb /root/adspower.deb
RUN dpkg -i /root/adspower.deb || (apt-get update && apt-get install -f -y && dpkg -i /root/adspower.deb) && \
    rm -f /root/adspower.deb

# Clean up
RUN apt-get purge -y --autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Configure openbox dock mode
RUN sed -i '/<dock>/,/<\/dock>/s/<noStrut>no<\/noStrut>/<noStrut>yes<\/noStrut>/' /etc/xdg/openbox/rc.xml

# Set environment
ENV TITLE="AdsPower-Selkies"
ENV TZ="Asia/Shanghai"
ENV LC_ALL="zh_CN.UTF-8"