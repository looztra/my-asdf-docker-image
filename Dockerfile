FROM debian:stable-slim

ARG ASDF_VERSION=v0.16.5

WORKDIR /
SHELL ["/bin/bash","-exc"]
# Install the global dependencies
RUN <<EOT
set -x
sed -i "s|Components: main|Components: main contrib|" /etc/apt/sources.list.d/debian.sources
apt-get update
apt-get install -y --no-install-recommends ca-certificates curl git bats
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EOT

RUN <<EOT
curl -Ls --proto "=https" https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/asdf-${ASDF_VERSION}-linux-amd64.tar.gz --output /asdf.tar.gz
tar xf asdf.tar.gz
mv asdf /usr/local/bin
chmod +x /usr/local/bin/asdf
rm asdf.tar.gz
EOT
