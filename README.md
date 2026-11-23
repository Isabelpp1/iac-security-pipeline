# Análisis de seguridad IaC en el pipeline

Proyecto de demostración: Terraform (`infra/`), Ansible (`ansible/`) y Dockerfile (`docker/`)
escaneados con Checkov y ansible-lint en GitHub Actions. Nada se despliega; solo se analiza el código.

- Workflow: `.github/workflows/iac-security.yml`
- Política propia: `politicas/etiquetas_obligatorias.yaml` (CKV2_ORG_1)
- Informe: `docs/informe.pdf`
