#!/bin/bash

echo "=========================================="
echo "  Testando Load Balancer com NGINX"
echo "=========================================="
echo ""

URL="http://localhost:8080"
NUM_REQUESTS=10

echo "Fazendo $NUM_REQUESTS requisições para $URL"
echo ""

declare -A instance_count

for i in $(seq 1 $NUM_REQUESTS); do
    echo -n "Requisição $i: "
    response=$(curl -s $URL)
    container=$(echo $response | grep -o '"container":"[^"]*"' | cut -d'"' -f4)
    
    if [ -z "$container" ]; then
        container=$(echo $response | grep -o '"hostname":"[^"]*"' | cut -d'"' -f4)
    fi
    
    ((instance_count[$container]++))
    echo "Respondido por: $container"
    sleep 0.2
done

echo ""
echo "=========================================="
echo "  Resumo das Respostas"
echo "=========================================="
echo ""

for instance in "${!instance_count[@]}"; do
    count=${instance_count[$instance]}
    percentage=$(awk "BEGIN {printf \"%.1f\", ($count/$NUM_REQUESTS)*100}")
    echo "$instance: $count requisições ($percentage%)"
done

echo ""
echo "Total: $NUM_REQUESTS requisições"
echo "=========================================="
