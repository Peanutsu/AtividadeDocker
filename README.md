# AtividadeDocker
codigos criados para disciplina de análise de desempenho durante o curso de engenharia da computação
# DesempenhoEmDocker
# 1. Subir os containers
docker-compose up --build -d

# 2. Verificar se estão rodando
docker-compose ps

# 3. Testar o load balancer
./client.sh

# 4. Parar os containers
docker-compose down