# p6-cirrus

## Table of Contents


### p6-cirrus
- [p6-cirrus](#p6-cirrus)
  - [Badges](#badges)
  - [Distributions](#distributions)
  - [Summary](#summary)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [Changes](#changes)
    - [Usage](#usage)
  - [Author](#author)

### Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/p6m7g8/p6-cirrus)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/p6m7g8/p6-cirrus/&style=flat)](https://mergify.io)
[![codecov](https://codecov.io/gh/p6m7g8/p6-cirrus/branch/master/graph/badge.svg?token=14Yj1fZbew)](https://codecov.io/gh/p6m7g8/p6-cirrus)
[![Known Vulnerabilities](https://snyk.io/test/github/p6m7g8/p6-cirrus/badge.svg?targetFile=package.json)](https://snyk.io/test/github/p6m7g8/p6-cirrus?targetFile=package.json)
[![Gihub repo dependents](https://badgen.net/github/dependents-repo/p6m7g8/p6-cirrus)](https://github.com/p6m7g8/p6-cirrus/network/dependents?dependent_type=REPOSITORY)
[![Gihub package dependents](https://badgen.net/github/dependents-pkg/p6m7g8/p6-cirrus)](https://github.com/p6m7g8/p6-cirrus/network/dependents?dependent_type=PACKAGE)

## Summary

## Contributing

- [How to Contribute](CONTRIBUTING.md)

## Code of Conduct

- [Code of Conduct](https://github.com/p6m7g8/.github/blob/master/CODE_OF_CONDUCT.md)

## Changes

- [Change Log](CHANGELOG.md)

## Usage

### p6-cirrus:

#### p6-cirrus/init.zsh:

- p6df::modules::p6cirrus::deps()
- p6df::modules::p6cirrus::init()


### ../p6-cirrus/lib:

#### ../p6-cirrus/lib/autoscaling.sh:

- p6_cirrus_autoscaling_asg_create(asg_name, min_size, max_size, desired_capacity, lt_id, lt_name, lt_version, subnet_type, [vpc_id=$AWS_VPC_ID])

#### ../p6-cirrus/lib/eks.sh:

- p6_cirrus_eks_cluster_logging_enable([cluster_name=$AWS_EKS_CLUSTER_NAME])

#### ../p6-cirrus/lib/elb.sh:

- p6_cirrus_elb_create(elb_name, [listeners=http], [subnet_type=Public], [vpc_id=$AWS_VPC_ID])

#### ../p6-cirrus/lib/elbv2.sh:

- p6_aws_svc_alb_create(alb_name, [subnet_type=Public], [vpc_id=$AWS_VPC_ID_ID])
- p6_aws_svc_alb_listener_create(alb_arn, target_group_arn)
- p6_aws_svc_alb_target_group_create(tg_name, [vpc_id=AWS_VPC_ID_ID])

#### ../p6-cirrus/lib/iam.sh:

- p6_cirrus_iam_password_policy_default()
- p6_cirrus_iam_policy_create(policy_full_path, policy_description, policy_document)
- p6_cirrus_iam_policy_to_role(role_full_path, policy_arn)
- p6_cirrus_iam_role_saml_create(role_full_path, policy_arn, account_id, provider)

#### ../p6-cirrus/lib/kms.sh:

- p6_cirrus_kms_key_create(key_description, key_policy)
- str key_id = p6_cirrus_kms_key_make(account_id, key_description, key_alias)

#### ../p6-cirrus/lib/lambda.sh:

- p6_cirrus_lambda_invoke(function_name, ...)

#### ../p6-cirrus/lib/organizations.sh:

- aws_account_id account_id = p6_cirrus_organizations_avm_account_create(account_name, account_email)
- bool bool = p6_cirrus_organizations_avm_account_create_wait_for(cas_id)
- p6_cirrus_organizations_avm_account_create_stop(status, cas_id)
- str status = p6_cirrus_organizations_avm_account_create_status(car_id)

#### ../p6-cirrus/lib/s3api.sh:

- false  = p6_cirrus_s3api_bucket_delete_with_versioned_objects(bucket)

#### ../p6-cirrus/lib/util.sh:

- p6_cirrus_cleanup()


### alfred:

#### alfred/bastion.sh:

- p6_cirrus_alfred_bastion_private(pfunc)
- p6_cirrus_alfred_bastion_public(pfunc)

#### alfred/browser.sh:

- p6_cirrus_alfred_browser_console(pfunc)

#### alfred/nodeps.sh:

- p6_cirrus_alfred_profiles_list_q(org)
- p6_cirrus_alfred_profiles_to_alred_items_q(org, ...)

#### alfred/profile.sh:

- str json = p6_cirrus_alfred_profiles_to_alred_items(org, ...)
- words profiles = p6_cirrus_alfred_profiles_list(org)


### ec2:

#### ec2/instance.sh:

- p6_cirrus_instance_allow(instance_id)
- p6_cirrus_instance_amazon_create()
- p6_cirrus_instance_bastion_create()
- p6_cirrus_instance_create(name, ami_id, [instance_type=t3a.nano], [user_data=], [subnet_type=infra])
- p6_cirrus_instance_irc_create()
- p6_cirrus_instance_jenkins_create()
- p6_cirrus_instance_rhel8_create()
- p6_cirrus_instance_ubuntu18_create()

#### ec2/lt.sh:

- p6_cirrus_ec2_launch_template_create(lt_name, ami_id, [instance_type=t3a.nano], sg_ids, key_name)

#### ec2/sg.sh:

- p6_cirrus_sg_allow()
- str sg_id = p6_cirrus_sg_id_from_instance_id(instance_id)


### ssh:

#### ssh/connect.sh:

- p6_cirrus_ssh_connect_jump(tag)
- p6_cirrus_ssh_connect_private(tag)
- p6_cirrus_ssh_connect_public()



## Hier
```text
.
├── alfred
│   ├── bastion.sh
│   ├── browser.sh
│   ├── nodeps.sh
│   └── profile.sh
├── autoscaling.sh
├── ec2
│   ├── instance.sh
│   ├── lt.sh
│   └── sg.sh
├── eks.sh
├── elb.sh
├── elbv2.sh
├── iam.sh
├── kms.sh
├── lambda.sh
├── organizations.sh
├── s3api.sh
├── ssh
│   └── connect.sh
└── util.sh

3 directories, 18 files
```
## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
