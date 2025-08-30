#!/usr/bin/env bash

# Inicia o daemon em MODO USERSPACE (a correção final!)
/render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# Aguarda 5 segundos para garantir que o daemon iniciou
sleep 5

# Inicia o Tailscale usando a nossa variável de ambiente manual
# O \ no final das linhas é apenas para formatação
/render/tailscale up \
    --authkey="${TAILSCALE_AUTHKEY}" \
    --advertise-routes="${PRIVATE_NETWORK_CIDR}" \
    --accept-dns=false \
    --reset

# Comando para manter o script e o container rodando indefinidamente
wait
