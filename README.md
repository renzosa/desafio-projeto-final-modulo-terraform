# Projeto Terraform para Configuração de Aplicação Web na AWS Simulado: “E-commerce de Produtos Digitais”

## Descrição do Cenário:Imagine que você está revisando a arquitetura de um site de e-commerce que vende produtos digitais, como e-books e cursos online. O sistema é configurado para escalar automaticamente em períodos de alta demanda, como em campanhas de marketing e datas de promoção.

## Detalhes da Arquitetura:Este e-commerce foi configurado na AWS com uma arquitetura simplificada para uma startup, incluindo:
1. Front-end:
    * Amazon S3 para armazenar os arquivos estáticos do site.
    * Amazon CloudFront para entrega de conteúdo e CDN.
2. Back-end:
    * Amazon EC2 para hospedar a API que lida com pedidos e login de usuários.
    * Auto Scaling configurado para ajustar a quantidade de instâncias com base na demanda.
3. Banco de Dados:
    * Amazon RDS (MySQL) configurado em uma VPC, em uma única AZ
    * Backups automáticos do banco de dados são feitos diariamente.
4. Armazenamento de Produtos:
    * Amazon S3 para armazenar os arquivos digitais (e-books, cursos).
5. Segurança:
    * AWS IAM gerenciando as permissões para que apenas administradores possam acessar o back-end.
    * Amazon Cognito para autenticação de usuários do front-end.
6. Monitoramento:
    * Amazon CloudWatch monitora o desempenho das instâncias EC2 e envia alarmes para o time técnico.
7. Gerenciamento de Custos:
    * AWS Budgets configurado para alertar se os custos mensais ultrapassarem um limite definido.

Utilize o Well- architected para melhorar a resiliencia da aplicação.Apos o resultado, crie a arquitetura no draw.io e todos os componentes deverao ser entregue via terraform. Nao se esqueca de incluir a arquitetura que voce desenhou e um readme explicando os componentes criados no terraform.

## Arquivos Principais

- **cloud_front.tf**: Configuração da distribuição CloudFront.
- **load_balance.tf**: Configuração do balanceador de carga (Load Balancer).
- **locals.tf**: Definição de variáveis locais e políticas.
- **main.tf**: Arquivo principal que define os recursos e configurações do Terraform.
- **output.tf**: Define as saídas do Terraform.
- **s3_bucket.tf**: Configuração do bucket S3 e suas políticas.
- **security_groups.tf**: Configuração dos grupos de segurança (Security Groups).
- **terraform.tfvars**: Contém os valores das variáveis usadas no projeto.
- **variable.tf**: Declaração das variáveis usadas no projeto.
- **vpc.tf**: Configuração da VPC, subnets, internet gateway, nat gateway e route table.

## Variáveis

As variáveis são declaradas no arquivo `variable.tf`. Aqui está um exemplo de como declarar uma variável:

```terraform
variable "VPC-CIDR" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
```

## Como Usar

1. Clone o repositório:

```bash
git clone
```

2. Inicialize o Terraform:

```bash
terraform init
```

3. Executar o comando abaixo para gerar um arquivo de configuração. Verifique a saída: Após a execução bem-sucedida, você verá as saídas definidas no arquivo `<NOME_DO_AQUIVO>`.

```bash
terraform plan -out= <NOME_DO_AQUIVO>   
```

4. Aplique a configuração:

> lembrando que tem que ter as configuraçoes de user da aws configuradas no seu computador

```bash
terraform apply
```

Você pode passar variáveis diretamente na linha de comando ou usar um arquivo `terraform.tfvars` para definir os valores das variáveis.

**Limpeza**
Para destruir os recursos criados pelo Terraform, execute:

```bash
terraform destroy
```
## Diagrama
![Diagrama em branco](https://github.com/user-attachments/assets/ca8c8269-a439-4503-ad25-9bfd5d10e75e)

