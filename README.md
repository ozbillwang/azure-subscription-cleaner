# azure-subscription-cleaner

**Simple but powerful script** with [AZ CLI](https://github.com/Azure/azure-cli) to clean all resources from subscription, include disable subscriptions as well

At begining, I thought it would be a simple task because Azure manages resource via [Resource Group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal). But that's not that simple.

### features

- clean all resource groups - with `--no-wait`, you don't wait for the long-running operation to finish.
- clean all blueprint assignments
- clean all deleted key vault - Yes, the key are still there when soft delete is enabled, until you purge it. Otherwise, you will face the error, such as , `key with same name is exist`.
- clean resources from disabled subscription as well, fix the error `the subscription name has more than one match`

### Prerequisite

Make sure you have set the proper subscription

```
$ az account set -s <sub_id or sub_name>

$ az account show
```

### do the clean

When you are ready, just run below command

```
$ ./sub_cleaner.sh
```
