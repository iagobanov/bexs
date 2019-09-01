# Simple Front + Back app.


## Installation

Para execução de todas as estrutuas desse repo você deve ter:
- Terraform
- Docker
- Docker Compose 

## Executando local

```bash
docker-compose up
```

## Para execução na AWS

```bash
cd bexs/terraform/providers/aws/env/us-east-1/ebxs && \
terraform init && \
terraform plan && \
terraform apply
```


## Atualizando versão local
Caso deseje realizar um novo build para uma nova versão a ser testada localmente utilize:

```bash
docker-compose up --build
```

## Atualizando versão na AWS
Para atualizar as configurações da infra na AWS, basta atualizar o arquivo **vars.tf** do diretório:

```
bexs/terraform/providers/aws/env/us-east-1/ebxs
```
Nele você econtrara todas as variaveis utilizadas para compor os detalhes da estrutura na AWS.


## Have fun! :)