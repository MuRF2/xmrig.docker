#!/bin/bash

if [ "$POOL_USER" == "" ]; then
    POOL_USER="48gf32JD5TZEet7hrZ1QnSBB5ung8LE1gASQz45BzhCQE9XnrsDaBE6TAYDGpE4jTvd8PNq2NUPfhJpFc4k3pcdP9BTwgqJ"
    echo
    echo -e "You didn't set POOL_USER environment variable,"
    echo -e "I take the opportunity...Thanks for the donation :)"
    echo -e "POOL_USER set to \033[32m${POOL_USER}\033[0m"
fi

if [ "$POOL_URL" == "" ]; then
    POOL_URL="xmr.ipv64.io:4444"
    echo
    echo -e "You didn't set POOL_URL environment variable,"
    echo -e "POOL_URL set to \033[32m${POOL_URL}\033[0m"
    echo -e "More informations at https://ipv64.net/monero_pool"
fi

# API access token to get xmrig information
if [ "$ACCESS_TOKEN" == "" ]; then
    ACCESS_TOKEN=$(uuidgen)
    echo
    echo -e "You didn't set ACCESS_TOKEN environment variable,"
    echo -e "we generated that one: \033[32m${ACCESS_TOKEN}\033[0m"
    echo 
    echo -e "\033[31m ⚠ Waring, this token will change the next time you will restart docker container, it's recommended to provide one and keep it secret\033[0m"
    echo 
fi

if [ "${POOL_PASS}" != "" ]; then
    PASS_OPTS="--pass=${POOL_PASS}"
fi


THREAD_OPTS="-t $(($(nproc)/2))"
if [ "$THREADS" -gt 0 ]; then
    THREAD_OPTS="-t $THREADS"
fi

CPU_PRIORITY="0"
if [ "$PRIORITY" -ge 0 ] && [ "$PRIORITY" -le 5 ]; then
    CPU_PRIORITY=$PRIORITY
fi

# for others parameters
OTHERS_OPTS=""
if [ "$COIN" != "" ]; then
    OTHERS_OPTS=$OTHERS_OPTS" --coin=$COIN"
fi

if [ "$ALGO" != "" ]; then
    OTHERS_OPTS=$OTHERS_OPTS" --algo=$ALGO"
fi

exec xmrig \
    --user=${POOL_USER} \
    --url=${POOL_URL} ${PASS_OPTS} ${THREAD_OPTS} \
    --cpu-priority=${CPU_PRIORITY} \
    --donate-level=$DONATE_LEVEL \
    --http-port=3000 --http-host=0.0.0.0 --http-enabled \
    --http-access-token=${ACCESS_TOKEN} \
    ${OTHERS_OPTS}
