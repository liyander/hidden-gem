FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ttyd \
    python3 \
    binutils \
    binwalk \
    libimage-exiftool-perl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ctfuser && \
    echo "ctfuser:ctfuser" | chpasswd

WORKDIR /home/ctfuser

COPY generate.py .

RUN python3 generate.py && \
    chown ctfuser:ctfuser dark_pearl.png && \
    rm generate.py

RUN echo '#!/bin/bash' > /home/ctfuser/hint.txt && \
    echo 'Welcome to the Hidden Gem challenge!' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'The dark_pearl.png file contains hidden data.' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Try these commands:' >> /home/ctfuser/hint.txt && \
    echo '  file dark_pearl.png                - Check file type' >> /home/ctfuser/hint.txt && \
    echo '  strings dark_pearl.png | grep blackperl  - Quick search' >> /home/ctfuser/hint.txt && \
    echo '  binwalk dark_pearl.png             - Scan for hidden data' >> /home/ctfuser/hint.txt && \
    echo '  exiftool dark_pearl.png            - View metadata' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'If binwalk finds something:' >> /home/ctfuser/hint.txt && \
    echo '  binwalk -e dark_pearl.png          - Extract embedded files' >> /home/ctfuser/hint.txt && \
    chmod 444 /home/ctfuser/hint.txt && \
    chown ctfuser:ctfuser /home/ctfuser/hint.txt

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'export HISTSIZE=0' >> /entrypoint.sh && \
    echo 'export HISTFILESIZE=0' >> /entrypoint.sh && \
    echo 'unset HISTFILE' >> /entrypoint.sh && \
    echo 'exec ttyd -p 10000 -W login -f ctfuser' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
