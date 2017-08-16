#!/usr/bin/env bash

set -e

action="$1"
oldversion="$2"

umask 022

if ! getent passwd istio >/dev/null; then
    addgroup --system istio
    adduser --system --group --home /var/lib/istio istio
fi

if [ ! -e /etc/istio ]; then
   # Backward compat.
   ln -s /var/lib/istio /etc/istio
fi

mkdir -p /var/lib/istio/envoy
mkdir -p /var/lib/istio/config
mkdir -p /var/log/istio

chown istio.istio /var/lib/istio/envoy /var/lib/istio/config /var/log/istio
