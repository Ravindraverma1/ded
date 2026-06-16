#!/bin/bash
# Run from repo root: bash scripts/create_qa_env.sh

set -e

echo "=== Step 1: Copy env/dev to env/qa ==="
cp -r env/dev env/qa

echo "=== Step 2: Rename dev.tfvars to qa.tfvars ==="
find env/qa -name "dev.tfvars" | while read f; do
  mv "$f" "${f/dev.tfvars/qa.tfvars}"
done

echo "=== Step 3: Replace all dev references with qa ==="

# All .tf and .tfvars files in env/qa
find env/qa -type f \( -name "*.tf" -o -name "*.tfvars" \) | while read f; do

  # Resource group name
  sed -i 's/DED_Project"/DED_Project_QA"/g' "$f"

  # Resource names — ded-dev → ded-qa
  sed -i 's/ded-dev-weu/ded-qa-weu/g' "$f"

  # State keys — ded-dev. → ded-qa.
  sed -i 's/ded-dev\./ded-qa\./g' "$f"

  # Tags env value
  sed -i 's/env\s*=\s*"dev"/env       = "qa"/g' "$f"

  # VNet CIDR
  sed -i 's/10\.60\./10.61./g' "$f"

  # Storage account names (must be unique)
  sed -i 's/stfuncdeddevweu01/stfuncqaweu01ded/g' "$f"
  sed -i 's/stddeddevweu01ded/stqaweu01ded/g' "$f"
  sed -i 's/acrdeddevweu01ded/acrqaweu01ded/g' "$f"

  # DNS prefix in AKS
  sed -i 's/aks-ded-dev/aks-ded-qa/g' "$f"

  # computer_name for Windows VM
  sed -i 's/dev-ded-win/qa-ded-win/g' "$f"

done

echo "=== Step 4: Right-size QA resources ==="

# AKS — downsize api pool
sed -i 's/vm_size_api\s*=\s*"Standard_D4s_v5"/vm_size_api         = "Standard_D2s_v5"/g' \
  env/qa/aks/qa.tfvars

# SQL — smaller SKU and size
sed -i 's/sql_sku\s*=\s*"GP_Gen5_8"/sql_sku         = "GP_Gen5_2"/g' \
  env/qa/sql/qa.tfvars
sed -i 's/sql_max_size_gb\s*=\s*500/sql_max_size_gb = 100/g' \
  env/qa/sql/qa.tfvars

# OpenAI — half capacity
sed -i 's/gpt4o_capacity\s*=\s*10/gpt4o_capacity     = 5/g' \
  env/qa/ai_stack/qa.tfvars
sed -i 's/embedding_capacity\s*=\s*20/embedding_capacity = 10/g' \
  env/qa/ai_stack/qa.tfvars

# SQL — disable public access for QA
sed -i '/sql_allowed_ips/,/^}/d' env/qa/sql/qa.tfvars
sed -i 's/public_network_access_enabled\s*=\s*true/public_network_access_enabled = false/g' \
  env/qa/sql/qa.tfvars

echo "=== Step 5: Verify changes ==="
echo ""
echo "--- Backend keys ---"
grep -r "key\s*=" env/qa/*/backend.tf

echo ""
echo "--- Resource group names ---"
grep -r "resource_group_name\s*=" env/qa/*/qa.tfvars | grep -v "#"

echo ""
echo "--- VNet CIDR ---"
grep -r "vnet_cidr" env/qa/*/qa.tfvars

echo ""
echo "--- Resource names sample ---"
grep -r "ded-qa" env/qa/network/qa.tfvars | head -5

echo ""
echo "=== Done! env/qa is ready ==="
echo ""
echo "Next steps:"
echo "  1. Review env/qa files manually to confirm"
echo "  2. az group create --name DED_Project_QA --location westeurope"
echo "  3. Run deployments in order"