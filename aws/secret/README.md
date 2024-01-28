<!-- BEGIN_TF_DOCS -->
# AWS Secret with LOGIC

Terraform module for easily creating a secret in AWS Secrets Manager.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_secretsmanager_secret.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_iam_policy_document.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain name of the project of this secret (e.g. my-app.my-company.local) | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment where this secret is being used (e.g. production) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the project using this secret (e.g. my-app) | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of key-value objects to merge and store in a single AWS secret | `list(map(any))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the created secret |
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | The ARN for the IAM policy granting read-only access to the secret |

---

<p align="center"><a href="https://withlogic.co">Built with LOGIC</a></p>
<!-- END_TF_DOCS -->