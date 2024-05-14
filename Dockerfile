# docker manifest inspect postgis/postgis:latest -v | jq '.Descriptor.digest'
FROM postgis/postgis:latest@sha256:fdabb7985ea8963bbc0256807e8ca5e9b86b85f35d9fbe683aff57fcce09cc98

ENV HOME=/home/user

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY backup.sh /usr/local/bin/backup.sh
COPY rclone.conf /home/user/.config/rclone/rclone.conf

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      rclone \
      rsync \
      postgresql-16-pgaudit \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*

RUN chgrp -R 0 /home/user \
 && chmod -R g=u /home/user /etc/passwd

WORKDIR /home/user

ENTRYPOINT ["entrypoint.sh"]

CMD ["postgres"]
