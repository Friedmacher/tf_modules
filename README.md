# Terraform - Modules Development
Reusable Terraform modules

## Build SAP BTP Subaccounts
The name and the subdomain of the subaccount are derived from the project name and the development stage.

### Subaccount Name
1. SA is added as prefix
2. The project name
3. " - " is added as seperator
4. The development stage

*Example:* SA MoRIS - PRD

### Subdomain
All spaces are replaced by "-", and the whole subdomain is converted to lower case.

1. "at-" is added as prefix
2. The project name
3. "-" is added as seperator
4. The development stage

*Example:* at-moris-sbx