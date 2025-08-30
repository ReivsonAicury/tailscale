#!/usr/bin/env bash

# Inicia o daemon do tailscale em segundo plano
/render/tailscaled &

# Aguarda 5 segundos para garantir que o daemon iniciou
sleep 5

# Inicia o Tailscale usando a nossa variável de ambiente manual
# O \ no final das linhas é apenas para formatação
/render/tailscale up \
    --authkey="${TAILSCALE_AUTHKEY}" \
    --advertise-routes="${PRIVATE_NETWORK_CIDR}" \
    --accept-dns=false

# Comando para manter o script e o container rodando indefinidamente
wait
