# infra-eks


validação

Garanta ter instalado:

kubectl

awscliV2

um user iam com as seguintes permissoes 

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "eks:DescribeCluster",
                "eks:ListClusters",
                "eks:AccessKubernetesApi",
                "ssm:GetParameter",
                "eks:ListUpdates",
                "eks:ListFargateProfiles",
                "ecr:DescribeRepositories",
                "ecr:CreateRepository"
            ],
            "Resource": "*"
        }
    ]
}

para o deploy via gitlabaction deve configurar as seguintes variaveis:

AWS_ACCESS_KEY_ID = <access_key_do_user_iam>
AWS_SECRET_ACCESS_KEY_ID = <secret_key_do_user_iam>
AWS_ACCOUNT_ID = <numero_da_conta_aws>
AWS_REGION = <regio_onde_foi_provisionados_os_recursos>
EKS_CLUSTER_NAME = <nome_do_cluster>


para acessar o cluster deve usar os seguinte comandos:

aws eks update-kubeconfig --name <cluster_name> --region <região do cluster>

apos executar o update kubeconfig você conseguira usar os camando via terminal 

para listar todos os pods em todos namespace

kubectl get pods -A

para ver a configuração do pod

kubectl describe pod <nome do pod> -n <namespace_do_pode>

para ver os logs do pod

kubectl logs pod <nome_do_pod> -n <namespace_do_pod>