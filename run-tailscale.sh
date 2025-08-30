#!/usr/bin/env bash

# /render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
# PID=$!

# ADVERTISE_ROUTES=${RENDER_PRIVATE_NETWORK_CIDR}
# echo "DEBUG: O valor de RENDER_PRIVATE_NETWORK_CIDR é: ${RENDER_PRIVATE_NETWORK_CIDR}"
# until /render/tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname="${RENDER_SERVICE_NAME}" --advertise-routes="$ADVERTISE_ROUTES"; do
#   sleep 0.1
# done
# export ALL_PROXY=socks5://localhost:1055/
# tailscale_ip=$(/render/tailscale ip)
# echo "Tailscale is up at IP ${tailscale_ip}"

# wait ${PID}

#!/usr/bin/env bash

# Laço para aguardar até que a variável de ambiente do Render esteja disponível
while [ -z "${RENDER_PRIVATE_NETWORK_CIDR}" ]; do
  echo "Aguardando a variável RENDER_PRIVATE_NETWORK_CIDR ser definida pelo Render..."
  sleep 2
done

echo "Variável RENDER_PRIVATE_NETWORK_CIDR encontrada: ${RENDER_PRIVATE_NETWORK_CIDR}"

/render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
PID=$!

ADVERTISE_ROUTES="${RENDER_PRIVATE_NETWORK_CIDR}"

until /render/tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname="${RENDER_SERVICE_NAME}" --advertise-routes="${ADVERTISE_ROUTES}"; do
    sleep 0.1
done

export ALL_PROXY=socks5://localhost:1055/
tailscale ip -4 >/render/tailscale_ip
echo "Tailscale is up at IP $(tailscale ip)"

wait ${PID}
