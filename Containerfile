FROM ubuntu:26.04 AS source

ADD --checksum=sha256:17ec33965dace13662a563e4f2ab78281e33f39778ab4fa9fef4da90a5934140 https://cdn.zoom.us/prod/7.1.5.4332/zoom_x86_64.tar.xz /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends xz-utils && \
    mkdir -p /out && \
    tar -xJf /tmp/source --strip-components=1 -C /out

FROM ghcr.io/containerpak/mesa64:main

COPY --from=source /out /opt/zoom

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libxcb-xinerama0 libxcb-xinput0 libxtst6 && \
    mkdir -p /usr/share/applications && \
    ln -s /opt/zoom/zoom /usr/bin/zoom && \
    printf '[Desktop Entry]\nName=Zoom\nExec=zoom %%U\nIcon=Zoom\nType=Application\nCategories=Network;VideoConference;\n' > /usr/share/applications/Zoom.desktop && \
    cpak-clean-junk
