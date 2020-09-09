FROM perl:5.32.0-buster

RUN apt-get update && \
    apt-get --assume-yes install fcgiwrap && \
    groupadd --gid=1000 awstats && \
    useradd --gid=1000 --home-dir=/usr/local/awstats --no-create-home --shell /bin/bash --uid 1000 awstats && \
    cpanm GeoIP2::Database::Reader Net::DNS Net::IP && \
    mkdir --parents /etc/awstats /data/logs /data/output /usr/local/awstats && \
    chown --recursive 1000:1000 /data /usr/local/awstats

USER 1000
VOLUME /data
WORKDIR /usr/local/awstats

ENTRYPOINT ["/usr/local/bin/perl"]
