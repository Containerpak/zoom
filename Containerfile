FROM ghcr.io/containerpak/mesa64:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/zoom"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libasound2t64 libxcb-xinerama0 libxcb-xinput0 libxtst6 && \
    cpak-clean-junk
