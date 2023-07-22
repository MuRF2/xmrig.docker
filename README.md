# xmrig.docker - Monero miner in docker for x86/ARM hosts

```bash
docker pull ghcr.io/murf2/xmrig.docker:latest
```

## Launch it

Make sure that the container is running in privileged mode if you encounter the **`msr kernel module is not available`** error message. The following startup examples are already set to run in privileged mode. This does not work in a VM.

```bash
# launch docker container
docker run --privileged --name miner --rm -it \
    -e POOL_URL=<your pool url> \
    -e POOL_USER=<your public monero address> \
    -e PRIORITY=1 \
    -e THREADS=1 \
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
    privileged: true
    environment:
      - POOL_USER=<your public monero address>
      - POOL_URL=<your pool url>
      - PRIORITY=1
      - THREADS=1
```


## Build it yourself

```bash
git clone https://github.com/MuRF2/xmrig.docker && cd xmrig.docker
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

