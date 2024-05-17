# docker manifest inspect postgis/postgis:latest -v | jq '.Descriptor.digest'
FROM postgis/postgis:latest@sha256:fdabb7985ea8963bbc0256807e8ca5e9b86b85f35d9fbe683aff57fcce09cc98

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      rsync \
      postgresql-16-pgaudit \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*
 