#================================================================================================
# Environment Vars - Global
#================================================================================================
variable "tenant_id" {}        # The azure tenant id.
variable "client_id" {}        # The azure tenant id.
variable "location" {}         # Azure location to deploy resources in.
variable "application_code" {} # The unique application identifier.
variable "unique_id" {}        # Name of the project (programme) which this application is part of.
variable "tags" {}             # Tags to apply to resources.



#================================================================================================
# Environment Vars
#================================================================================================
variable "environment" {}     # Environment name.
variable "subscription_id" {} # The azure subscription id.

