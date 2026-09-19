# Dev local: API e PostgreSQL

Este ambiente usa a assinatura `9e0045c4-9f26-4ee1-9d9b-591783536fb7` e o state remoto `coderats-base/dev.tfstate` no Storage Account `stcrtfstate9e0045`. A API, o ACR, o Key Vault e os logs ficam em East US. O PostgreSQL fica em North Central US porque a assinatura não oferece Flexible Server em East US. Esse arranjo atende ao ambiente de desenvolvimento, mas deve ser revisto antes de produção por causa da latência e do tráfego entre regiões.

O módulo `api-core` cria a API Base, a API do Grader e suas dependências diretas. Cada API usa um banco lógico separado no mesmo PostgreSQL (`coderats_base` e `coderats_grader`). A senha do servidor e o token de integração entre as APIs são gerados pelo Terraform, salvos no Key Vault e permanecem também no state. O Client Secret do GitHub App é passado como variável sensível e salvo no Key Vault e no state. Os containers recebem os segredos por referências ao Key Vault e usam identidades gerenciadas separadas para ler o ACR e o Key Vault.

O Grader inicia com `SANDBOX_MODE=remote`, mas nenhum executor de sandbox é provisionado neste ambiente. Health check, catálogo, configuração e persistência ficam disponíveis; avaliações que exigem execução de código falham até que um sandbox remoto isolado seja implantado.

## Terraform local

Autentique-se com `az login` e selecione a assinatura. A identidade precisa de permissão para criar recursos e atribuir papéis; também precisa de `Storage Blob Data Contributor` no Storage Account de state. Defina `TF_VAR_github_client_id` e `TF_VAR_github_client_secret` no processo local sem registrar o secret no histórico do shell.

```bash
terraform init -backend-config=backend.hcl.example
terraform plan -out=dev.tfplan
terraform apply dev.tfplan
```

O arquivo `dev.tfplan` contém valores sensíveis e não deve ser versionado. O primeiro `apply` usa imagens de bootstrap; publique as imagens reais no ACR e atualize os Container Apps `ca-coderats-base-api-dev` e `ca-coderats-grader-dev` com `az containerapp update --image`. O Terraform ignora apenas mudanças no campo da imagem.

O callback do GitHub App neste ambiente é `https://ca-coderats-base-api-dev.wittyforest-08a02f79.eastus.azurecontainerapps.io/login/oauth2/code/github`. Enquanto não houver Web, o login retorna à página raiz da própria API.
