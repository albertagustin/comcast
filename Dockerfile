FROM michaelpereira75/supercronic
LABEL com.github.albertagustin.maintainer="albertagustin@gmail.com"

# install pkgs, create dirs
RUN apk add --update --no-cache \
    python3 \
    && apk del --purge \
    && rm -rf /var/cache/apk \
    && mkdir -p /scripts 

# copy configs, scripts
COPY ./scripts /scripts

# install script reqs, generate configs
RUN pip3.6 install --no-cache-dir -r /scripts/requirements.txt

# copy crontab
COPY ./configs/crontab /etc/crontab
CMD [ "/etc/crontab" ]