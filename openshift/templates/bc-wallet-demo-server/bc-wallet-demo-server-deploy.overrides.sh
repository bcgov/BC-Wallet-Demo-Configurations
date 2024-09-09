#! /bin/bash
_includeFile=$(type -p overrides.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

# ================================================================================================================
# Special deployment parameters needed for injecting a user supplied settings into the deployment configuration
# ----------------------------------------------------------------------------------------------------------------

if createOperation; then
  # Ask the user to supply the sensitive parameters ...
  readParameter "TENANT_ID - Please provide the traction tennant ID" TENANT_ID "" "false"
  readParameter "API_KEY - Please provide the traction API key" API_KEY "" "false"
  readParameter "TRACTION_URL - Please provide the traction url" TRACTION_URL "" "false"
  readParameter "TRACTION_DID - Please provide the traction tenant did" TRACTION_DID "" "false"
  readParameter "WEBHOOK_SECRET - Please provide the traction webhook secret" WEBHOOK_SECRET "" "false"
else
  # Secrets are removed from the configurations during update operations ...
  printStatusMsg "Update operation detected ...\nSkipping the prompts for WALLET_SEED secret... \n"
  writeParameter "TENANT_ID" "prompt_skipped" "false"
  writeParameter "API_KEY" "prompt_skipped" "false"
  writeParameter "TRACTION_URL" "prompt_skipped" "false"
  writeParameter "TRACTION_DID" "prompt_skipped" "false"
  writeParameter "WEBHOOK_SECRET" "prompt_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}