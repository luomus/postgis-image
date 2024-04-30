# docker manifest inspect postgis/postgis:latest -v | jq '.Descriptor.digest'
FROM postgis/postgis:latest@sha256:e006d19de59fb489e380d4b3ca1eff8f3c905785906641a131cad9cb27e981ca

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      rsync \
      postgresql-16-pgaudit \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*
