#!/usr/bin/env bash

set -ex

# Notes:
# functions to wipe all resources on one subscription.
# Be careful to run this script.

# show account to make sure you work on proper account
# if there are multiple accounts with same name (disabled and enabled), you need clean them one by one

az account show
read -r -p "Are You Sure? [Yes/No] " input
 
case $input in
    [yY][eE][sS])
 echo "Yes"
 ;;
    [nN][oO])
 echo "No"
 exist 1
       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac


id=$(az account show |jq -r '.id')

# clean blueprint assignments
assignments=$(az blueprint assignment list --subscription ${id} |jq -r '.[].name')
for assignment in ${assignments}
do
  az blueprint assignment delete --name ${assignment} --subscription ${id} --yes
done

# Get all resource groups 
groups=$(az group list --subscription ${id} |jq -r '.[].name')

# clean resource groups
for group in ${groups}
do
  az group delete --name ${group} --subscription ${id} --yes --no-wait
done

# clean deleted vaults
vaults=$(az keyvault list-deleted --subscription ${id} |jq -r '.[].name')
for vault in ${vaults}
do
  az keyvault purge --name ${vault} --subscription ${id}
done

echo "run this script several times to make sure all resources are cleaned"
