Rename `terraform.tfvars.example` on `terraform.tfvars`
to use VM with bastion

```bash
az network bastion ssh \
  --name <prefix>-bastion \
  --resource-group <resource-group-name> \
  --target-resource-id $(az vm show -g <resource-group-name> -n <prefix>-backend --query id -o tsv) \
  --auth-type ssh-key \
  --username <admin_username> \
  --ssh-key <path-to-private-key>
```