# P6 p6-cirrus

## Table of Contents

## Badges

[![License](https:/p6m7g8/img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/p6m7g8/p6-cirrus/&style=flat)](https://mergify.io)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](<https://gitpod.io/#https://github.com/p6m7g8/p6-cirrus>)

## Summary

## Contributing

- [How to Contribute](<https://github.com/p6m7g8/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

### Functions

## alfred

### p6-cirrus/lib/alfred/browser.sh

- p6_cirrus_alfred_browser_console(pfunc)

## cloudtrail

### p6-cirrus/lib/cloudtrail/admin.sh

- p6_cirrus_cloudtrail_admin_delegate_deregister(account_id)
- p6_cirrus_cloudtrail_admin_delegate_register(account_id)
- p6_cirrus_cloudtrail_from_management_off(account_id)
- p6_cirrus_cloudtrail_from_management_on(account_id)
- p6_cirrus_cloudtrail_organization_service_disable()
- p6_cirrus_cloudtrail_organization_service_enable()

### p6-cirrus/lib/cloudtrail/trail.sh

- p6_cirrus_cloudtrail_trail_delete(prefix)
- p6_cirrus_cloudtrail_trail_logging_start(prefix)

## configservice

### p6-cirrus/lib/configservice/admin.sh

- p6_cirrus_configservice_admin_delegate_deregister(account_id)
- p6_cirrus_configservice_admin_delegate_register(account_id)
- p6_cirrus_configservice_from_management_off(account_id, region)
- p6_cirrus_configservice_from_management_on(account_id, region)
- p6_cirrus_configservice_organization_service_disable()
- p6_cirrus_configservice_organization_service_enable()

### p6-cirrus/lib/configservice/authorization.sh

- p6_cirrus_configservice_aggregation_authorization_delete(account_id, region)
- p6_cirrus_configservice_aggregation_authorization_put()

## ec2

### p6-cirrus/lib/ec2/instance.sh

- p6_cirrus_ec2_connect(tag)
- p6_cirrus_ec2_instance_allow(tag)
- p6_cirrus_ec2_instance_connect(instance_id, key)
- p6_cirrus_ec2_instance_connect(instance_id, key)
- p6_cirrus_ec2_instance_connect_ssh_public_key_send(instance_id, user, key, az)

### p6-cirrus/lib/ec2/lt.sh

- p6_cirrus_ec2_launch_template_create(lt_name, ami_id, [instance_type=t3a.nano], sg_ids, key_name)

## organizations

### p6-cirrus/lib/organizations/admin.sh

- p6_cirrus_organization_services_disable(service)
- p6_cirrus_organizations_admin_delegate_deregister(account_id, service)
- p6_cirrus_organizations_admin_delegate_register(account_id, service)

### p6-cirrus/lib/organizations/avm.sh

- aws_account_id account_id = p6_cirrus_organizations_avm_account_create(account_name, account_email)
- bool bool = p6_cirrus_organizations_avm_account_create_wait_for(cas_id)
- p6_cirrus_organizations_avm_account_create_stop(status, cas_id)
- str status = p6_cirrus_organizations_avm_account_create_status(car_id)

### p6-cirrus/lib/organizations/services.sh

- p6_cirrus_organization_services_enable(service)

## p6-cirrus

### p6-cirrus/p6-cirrus.zsh

- p6df::modules::p6cirrus::init()

## p6-cirrus/lib

### p6-cirrus/lib/autoscaling.sh

- p6_cirrus_autoscaling_asg_create(asg_name, min_size, max_size, desired_capacity, lt_id, lt_name, lt_version, subnet_type, [vpc_id=$AWS_VPC_ID])

### p6-cirrus/lib/cloudformation.sh

- p6_aws_cloudformation_stack_delete(stack_name)

### p6-cirrus/lib/cloudwatch.sh

- p6_cirrus_log_group_delete(log_group_name)
- p6_cirrus_logs_groups_prefix_delete(prefix)

### p6-cirrus/lib/eks.sh

- p6_cirrus_eks_cluster_logging_enable([cluster_name=$AWS_EKS_CLUSTER_NAME])

### p6-cirrus/lib/elb.sh

- p6_cirrus_elb_create(elb_name, [listeners=http], [subnet_type=Public], [vpc_id=$AWS_VPC_ID])

### p6-cirrus/lib/elbv2.sh

- p6_cirrus_alb_create(alb_name, [subnet_type=Public], [vpc_id=$AWS_VPC_ID_ID])
- p6_cirrus_alb_listener_create(alb_arn, target_group_arn)
- p6_cirrus_alb_target_group_create(tg_name, [vpc_id=AWS_VPC_ID_ID])

### p6-cirrus/lib/iam.sh

- p6_cirrus_iam_password_policy_default()
- p6_cirrus_iam_policy_create(policy_full_path, policy_description, policy_document)
- p6_cirrus_iam_policy_to_role(role_full_path, policy_arn)
- p6_cirrus_iam_role_saml_create(role_full_path, policy_arn, account_id, provider)
- p6_cirrus_iam_role_service_linked_create(service)
- p6_cirrus_iam_role_service_linked_delete(service)

### p6-cirrus/lib/inspector.sh

- p6_cirrus_inspector_admin_delegate_deregister(da_account_id)
- p6_cirrus_inspector_admin_delegate_register(da_account_id)
- p6_cirrus_inspector_admin_delegated_enable(da_account_id)
- p6_cirrus_inspector_from_delegated_off()
- p6_cirrus_inspector_from_management_off(account_id)
- p6_cirrus_inspector_from_management_on(account_id)
- p6_cirrus_inspector_member_associate(account_id)
- p6_cirrus_inspector_member_remove(account_id)
- p6_cirrus_inspector_organization_members_disable()
- p6_cirrus_inspector_organization_members_enable()
- p6_cirrus_inspector_organization_service_disable()
- p6_cirrus_inspector_organization_service_enable()
- p6_cirrus_inspector_resource_scanning_disable(account_ids)
- p6_cirrus_inspector_resource_scanning_enable(account_ids)
- p6_cirrus_inspector_role_service_linked_create()
- p6_cirrus_inspector_role_service_linked_delete()
- p6_cirrus_inspector_status_batch_get(account_ids)

### p6-cirrus/lib/kms.sh

- p6_cirrus_kms_key_create(key_description, key_policy)
- str key_id = p6_cirrus_kms_key_make(account_id, key_description, key_alias)

### p6-cirrus/lib/lambda.sh

- p6_cirrus_lambda_invoke(function_name, ...)

### p6-cirrus/lib/s3api.sh

- false  = p6_cirrus_s3api_bucket_delete_with_versioned_objects(bucket, bucket)

### p6-cirrus/lib/secret.sh

- p6_cirrus_secretsmanager_secret_create(name, value)

### p6-cirrus/lib/securityhub.sh

- p6_cirrus_securityhub_admin_delegate_deregister(account_id)
- p6_cirrus_securityhub_admin_delegate_register(account_id)
- p6_cirrus_securityhub_admin_disable(account_id)
- p6_cirrus_securityhub_admin_enable(account_id)
- p6_cirrus_securityhub_aggregator_delete()
- p6_cirrus_securityhub_disable()
- p6_cirrus_securityhub_from_delegated_off()
- p6_cirrus_securityhub_from_management_off(account_id)
- p6_cirrus_securityhub_from_management_on(account_id)
- p6_cirrus_securityhub_members_remove()
- p6_cirrus_securityhub_organization_config_update()
- p6_cirrus_securityhub_organization_service_disable()
- p6_cirrus_securityhub_organization_service_enable()

## Hierarchy

```text
.
├── LICENSE
├── README.md
├── lib
│   ├── alfred
│   │   └── browser.sh
│   ├── autoscaling.sh
│   ├── cloudformation.sh
│   ├── cloudtrail
│   │   ├── admin.sh
│   │   └── trail.sh
│   ├── cloudwatch.sh
│   ├── configservice
│   │   ├── admin.sh
│   │   └── authorization.sh
│   ├── ec2
│   │   ├── instance.sh
│   │   └── lt.sh
│   ├── eks.sh
│   ├── elb.sh
│   ├── elbv2.sh
│   ├── iam.sh
│   ├── inspector.sh
│   ├── kms.sh
│   ├── lambda.sh
│   ├── organizations
│   │   ├── admin.sh
│   │   ├── avm.sh
│   │   └── services.sh
│   ├── s3api.sh
│   ├── secret.sh
│   └── securityhub.sh
└── p6-cirrus.zsh

7 directories, 26 files
```

## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
