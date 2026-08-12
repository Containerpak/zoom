FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:17ec33965dace13662a563e4f2ab78281e33f39778ab4fa9fef4da90a5934140 https://cdn.zoom.us/prod/7.1.5.4332/zoom_x86_64.tar.xz /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libegl1 libgl1 libxcb-xinerama0 libxcb-xinput0 libxtst6 xz-utils && \
    mkdir -p /opt/zoom && tar -xJf /tmp/source --strip-components=1 -C /opt/zoom && ln -s /opt/zoom/ZoomLauncher /usr/bin/zoom && cp /opt/zoom/Zoom.desktop /usr/share/applications/Zoom.desktop && \
    cpak-clean-junk
