# AWStats

Simple docker image for AWStats without any bloat, built on the official perl image with the addition of fcgiwrap. AWStats runs as user `awstats` with `uid` and `gid` `1000`.

## Usage

```sh
docker run --detach --entrypoint=/usr/sbin/fcgiwrap \
  --name=awstats-fcgiwrap \
  --network=host \
  --rm \
  --volume=/path/to/etc/awstats/:/etc/awstats/ \
  --volume=/path/to/data/:/data/ \
  --volume=/path/to/usr/local/awstats/:/usr/local/awstats/ \
  ghudiczius/awstats:<VERSION> -s tcp:0.0.0.0:9000 -p /usr/local/awstats/wwwroot/cgi-bin/awstats.pl
```

```sh
docker run --entrypoint=/usr/local/bin/perl \
  --name=awstats-update \
  --network=host \
  --rm \
  --volume=/path/to/etc/awstats/:/etc/awstats/ \
  --volume=/path/to/data/:/data/ \
  --volume=/path/to/usr/local/awstats/:/usr/local/awstats/ \
  ghudiczius/awstats:<VERSION> wwwroot/cgi-bin/awstats.pl -config=total update
```
