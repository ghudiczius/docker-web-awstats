FROM perl:5.32.0-buster

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install fcgiwrap && \
    groupadd --gid=1000 awstats && \
    useradd --gid=1000 --home-dir=/usr/local/awstats --no-create-home --shell /bin/bash --uid 1000 awstats && \
    cpanm GeoIP2::Database::Reader Net::DNS Net::IP && \
    mkdir --parents /etc/awstats /data/logs /data/output /usr/local/awstats && \
    curl --location --output /tmp/awstats.tar.gz --silent https://downloads.sourceforge.net/project/awstats/AWStats/${VERSION}/awstats-${VERSION}.tar.gz && \
    tar xzf /tmp/awstats.tar.gz --directory=/usr/local/awstats --strip-components=1 && \
    find usr/local/awstats -regex '.*\.p[lm]' -exec sed --in-place 's|#!/usr/bin/perl|#!/usr/bin/env perl|' {} \; && \
    sed -i 's/<domain> /\&lt;domain\&gt; /' /usr/local/awstats/wwwroot/cgi-bin/lang/tooltips_m/awstats-tt-en.txt && \
    sed -i 's/<forward-path> /\&lt;forward-path\&gt;  /' /usr/local/awstats/wwwroot/cgi-bin/lang/tooltips_m/awstats-tt-en.txt && \
    chown --recursive 1000:1000 /data /usr/local/awstats

USER 1000
VOLUME /data
WORKDIR /usr/local/awstats

ENTRYPOINT ["/usr/local/bin/perl"]
