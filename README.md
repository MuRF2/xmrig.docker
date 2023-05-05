# xmrig.docker - Monero miner for x86/ARM hosts

Every month, a docker image is generated via GitHub action, which includes the most up-to-date version of xmrig.

```bash
docker pull ghcr.io/murf2/xmrig.docker:latest
```

## Launch it

```bash
export POOL_URL=<your pool url>
export POOL_USER=<your public monero address>
export POOL_PASS=<can be empty for some pool, other use that as miner id>
export DONATE_LEVEL=<xmrig project donation in percent, default is 1>

# launch docker container
docker run --name miner --rm -it \
    -e POOL_URL=$POOL_URL \
    -e POOL_USER=$POOL_USER \
    -e POOL_PASS=$POOL_PASS \
    -e DONATE_LEVEL=$DONATE_LEVEL \ 
    ghcr.io/murf2/xmrig.docker:latest
```

### docker-compose.yml
```bash
version: "3.8"
services:
  xmrig:
    container_name: xmrig
    hostname: xmrig
    image: ghcr.io/murf2/xmrig.docker:latest
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - POOL_USER=
      - POOL_URL=
      - DONATE_LEVEL=1
      - THREADS=1
      - PRIORITY=1
```


## Build it yourself

```bash
git clone https://https://github.com/MuRF2/xmrig.docker && cd xmrig.docker
docker build . -t <your_tag>  --build-arg VERSION=<xmrig-version>
```


## Complete list of supported environment variable:

- `POOL_USER`: your wallet address, default to mine
- `POOL_URL`: the pool address
- `POOL_PASS`: the pool password, or worker ID, following the pool documentation.
- `DONATE_LEVEL`: percentage of donation to Xmrig.com project (default '1' -> 1%)
- `PRIORITY`: CPU priority. 0=idle, 1=normal, 2 to 5 for higher priority (default '1')
- `THREADS`: number of thread to start (default CPU/2)
- `ACCESS_TOKEN`: Bearer access token to access to xmrig API (served on 3000 port), default is a generated token (uuid). 
- `ALGO`: mining algorithm https://xmrig.com/docs/algorithms (default is empty)
- `COIN`: that is the coin option instead of algorithm (default is empty)


## xmrig API

- The Xmrig API is set to port 3000, see documentation: https://github.com/xmrig/xmrig/blob/v3.2.0/doc/API.md
- Offical HTTP client for API: http://workers.xmrig.info/
- Do not forget to include port 3000 in your docker configuration


## Acknowledgments

I used [metal3d/docker-xmrig](https://github.com/metal3d/docker-xmrig)'s repository as a starting point

