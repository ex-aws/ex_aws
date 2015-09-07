defmodule ExAws.Iam.Core do
  @actions [
    "AddClientIDToOpenIDConnectProvider",
    "AddRoleToInstanceProfile",
    "AddUserToGroup",
    "AttachGroupPolicy",
    "AttachRolePolicy",
    "AttachUserPolicy",
    "ChangePassword",
    "CreateAccessKey",
    "CreateAccountAlias",
    "CreateGroup",
    "CreateInstanceProfile",
    "CreateLoginProfile",
    "CreateOpenIDConnectProvider",
    "CreatePolicy",
    "CreatePolicyVersion",
    "CreateRole",
    "CreateSAMLProvider",
    "CreateUser",
    "CreateVirtualMFADevice",
    "DeactivateMFADevice",
    "DeleteAccessKey",
    "DeleteAccountAlias",
    "DeleteAccountPasswordPolicy",
    "DeleteGroup",
    "DeleteGroupPolicy",
    "DeleteInstanceProfile",
    "DeleteLoginProfile",
    "DeleteOpenIDConnectProvider",
    "DeletePolicy",
    "DeletePolicyVersion",
    "DeleteRole",
    "DeleteRolePolicy",
    "DeleteSAMLProvider",
    "DeleteSSHPublicKey",
    "DeleteServerCertificate",
    "DeleteSigningCertificate",
    "DeleteUser",
    "DeleteUserPolicy",
    "DeleteVirtualMFADevice",
    "DetachGroupPolicy",
    "DetachRolePolicy",
    "DetachUserPolicy",
    "EnableMFADevice",
    "GenerateCredentialReport",
    "GetAccessKeyLastUsed",
    "GetAccountAuthorizationDetails",
    "GetAccountPasswordPolicy",
    "GetAccountSummary",
    "GetCredentialReport",
    "GetGroup",
    "GetGroupPolicy",
    "GetInstanceProfile",
    "GetLoginProfile",
    "GetOpenIDConnectProvider",
    "GetPolicy",
    "GetPolicyVersion",
    "GetRole",
    "GetRolePolicy",
    "GetSAMLProvider",
    "GetSSHPublicKey",
    "GetServerCertificate",
    "GetUser",
    "GetUserPolicy",
    "ListAccessKeys",
    "ListAccountAliases",
    "ListAttachedGroupPolicies",
    "ListAttachedRolePolicies",
    "ListAttachedUserPolicies",
    "ListEntitiesForPolicy",
    "ListGroupPolicies",
    "ListGroups",
    "ListGroupsForUser",
    "ListInstanceProfiles",
    "ListInstanceProfilesForRole",
    "ListMFADevices",
    "ListOpenIDConnectProviders",
    "ListPolicies",
    "ListPolicyVersions",
    "ListRolePolicies",
    "ListRoles",
    "ListSAMLProviders",
    "ListSSHPublicKeys",
    "ListServerCertificates",
    "ListSigningCertificates",
    "ListUserPolicies",
    "ListUsers",
    "ListVirtualMFADevices",
    "PutGroupPolicy",
    "PutRolePolicy",
    "PutUserPolicy",
    "RemoveClientIDFromOpenIDConnectProvider",
    "RemoveRoleFromInstanceProfile",
    "RemoveUserFromGroup",
    "ResyncMFADevice",
    "SetDefaultPolicyVersion",
    "UpdateAccessKey",
    "UpdateAccountPasswordPolicy",
    "UpdateAssumeRolePolicy",
    "UpdateGroup",
    "UpdateLoginProfile",
    "UpdateOpenIDConnectProviderThumbprint",
    "UpdateSAMLProvider",
    "UpdateSSHPublicKey",
    "UpdateServerCertificate",
    "UpdateSigningCertificate",
    "UpdateUser",
    "UploadSSHPublicKey",
    "UploadServerCertificate",
    "UploadSigningCertificate"]

  @moduledoc """
  ## AWS Identity and Access Management

  AWS Identity and Access Management

  AWS Identity and Access Management (IAM) is a web service that you can use
  to manage users and user permissions under your AWS account. This guide
  provides descriptions of IAM actions that you can call programmatically.
  For general information about IAM, see [AWS Identity and Access Management
  (IAM)](http://aws.amazon.com/iam/). For the user guide for IAM, see [Using
  IAM](http://docs.aws.amazon.com/IAM/latest/UserGuide/).

  Note:AWS provides SDKs that consist of libraries and sample code for
  various programming languages and platforms (Java, Ruby, .NET, iOS,
  Android, etc.). The SDKs provide a convenient way to create programmatic
  access to IAM and AWS. For example, the SDKs take care of tasks such as
  cryptographically signing requests (see below), managing errors, and
  retrying requests automatically. For information about the AWS SDKs,
  including how to download and install them, see the [Tools for Amazon Web
  Services](http://aws.amazon.com/tools/) page. We recommend that you use the
  AWS SDKs to make programmatic API calls to IAM. However, you can also use
  the IAM Query API to make direct calls to the IAM web service. To learn
  more about the IAM Query API, see [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM* guide. IAM supports GET and POST requests for all
  actions. That is, the API does not require you to use GET for some actions
  and POST for others. However, GET requests are subject to the limitation
  size of a URL. Therefore, for operations that require larger sizes, use a
  POST request.

  **Signing Requests**

  Requests must be signed using an access key ID and a secret access key. We
  strongly recommend that you do not use your AWS account access key ID and
  secret access key for everyday work with IAM. You can use the access key ID
  and secret access key for an IAM user or you can use the AWS Security Token
  Service to generate temporary security credentials and use those to sign
  requests.

  To sign requests, we recommend that you use [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  If you have an existing application that uses Signature Version 2, you do
  not have to update it to use Signature Version 4. However, some operations
  now require Signature Version 4. The documentation for operations that
  require version 4 indicate this requirement.

  **Additional Resources**

  For more information, see the following:

  - [AWS Security
  Credentials](http://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html).
  This topic provides general information about the types of credentials used
  for accessing AWS.

  - [IAM Best
  Practices](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPractices.html).
  This topic presents a list of suggestions for using the IAM service to help
  secure your AWS resources.

  - [AWS Security Token
  Service](http://docs.aws.amazon.com/STS/latest/UsingSTS/). This guide
  describes how to create and use temporary security credentials.

  - [Signing AWS API
  Requests](http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html).
  This set of topics walk you through the process of signing a request using
  an access key ID and secret access key.
  """

  @type access_key :: [
    access_key_id: access_key_id_type,
    create_date: date_type,
    secret_access_key: access_key_secret_type,
    status: status_type,
    user_name: user_name_type,
  ]

  @type access_key_last_used :: [
    last_used_date: date_type,
    region: string_type,
    service_name: string_type,
  ]

  @type access_key_metadata :: [
    access_key_id: access_key_id_type,
    create_date: date_type,
    status: status_type,
    user_name: user_name_type,
  ]

  @type add_client_id_to_open_id_connect_provider_request :: [
    client_id: client_id_type,
    open_id_connect_provider_arn: arn_type,
  ]

  @type add_role_to_instance_profile_request :: [
    instance_profile_name: instance_profile_name_type,
    role_name: role_name_type,
  ]

  @type add_user_to_group_request :: [
    group_name: group_name_type,
    user_name: existing_user_name_type,
  ]

  @type attach_group_policy_request :: [
    group_name: group_name_type,
    policy_arn: arn_type,
  ]

  @type attach_role_policy_request :: [
    policy_arn: arn_type,
    role_name: role_name_type,
  ]

  @type attach_user_policy_request :: [
    policy_arn: arn_type,
    user_name: user_name_type,
  ]

  @type attached_policy :: [
    policy_arn: arn_type,
    policy_name: policy_name_type,
  ]

  @type bootstrap_datum :: binary

  @type change_password_request :: [
    new_password: password_type,
    old_password: password_type,
  ]

  @type create_access_key_request :: [
    user_name: existing_user_name_type,
  ]

  @type create_access_key_response :: [
    access_key: access_key,
  ]

  @type create_account_alias_request :: [
    account_alias: account_alias_type,
  ]

  @type create_group_request :: [
    group_name: group_name_type,
    path: path_type,
  ]

  @type create_group_response :: [
    group: group,
  ]

  @type create_instance_profile_request :: [
    instance_profile_name: instance_profile_name_type,
    path: path_type,
  ]

  @type create_instance_profile_response :: [
    instance_profile: instance_profile,
  ]

  @type create_login_profile_request :: [
    password: password_type,
    password_reset_required: boolean_type,
    user_name: user_name_type,
  ]

  @type create_login_profile_response :: [
    login_profile: login_profile,
  ]

  @type create_open_id_connect_provider_request :: [
    client_id_list: client_id_list_type,
    thumbprint_list: thumbprint_list_type,
    url: open_id_connect_provider_url_type,
  ]

  @type create_open_id_connect_provider_response :: [
    open_id_connect_provider_arn: arn_type,
  ]

  @type create_policy_request :: [
    description: policy_description_type,
    path: policy_path_type,
    policy_document: policy_document_type,
    policy_name: policy_name_type,
  ]

  @type create_policy_response :: [
    policy: policy,
  ]

  @type create_policy_version_request :: [
    policy_arn: arn_type,
    policy_document: policy_document_type,
    set_as_default: boolean_type,
  ]

  @type create_policy_version_response :: [
    policy_version: policy_version,
  ]

  @type create_role_request :: [
    assume_role_policy_document: policy_document_type,
    path: path_type,
    role_name: role_name_type,
  ]

  @type create_role_response :: [
    role: role,
  ]

  @type create_saml_provider_request :: [
    name: saml_provider_name_type,
    saml_metadata_document: saml_metadata_document_type,
  ]

  @type create_saml_provider_response :: [
    saml_provider_arn: arn_type,
  ]

  @type create_user_request :: [
    path: path_type,
    user_name: user_name_type,
  ]

  @type create_user_response :: [
    user: user,
  ]

  @type create_virtual_mfa_device_request :: [
    path: path_type,
    virtual_mfa_device_name: virtual_mfa_device_name,
  ]

  @type create_virtual_mfa_device_response :: [
    virtual_mfa_device: virtual_mfa_device,
  ]

  @type credential_report_expired_exception :: [
    message: credential_report_expired_exception_message,
  ]

  @type credential_report_not_present_exception :: [
    message: credential_report_not_present_exception_message,
  ]

  @type credential_report_not_ready_exception :: [
    message: credential_report_not_ready_exception_message,
  ]

  @type deactivate_mfa_device_request :: [
    serial_number: serial_number_type,
    user_name: existing_user_name_type,
  ]

  @type delete_access_key_request :: [
    access_key_id: access_key_id_type,
    user_name: existing_user_name_type,
  ]

  @type delete_account_alias_request :: [
    account_alias: account_alias_type,
  ]

  @type delete_conflict_exception :: [
    message: delete_conflict_message,
  ]

  @type delete_group_policy_request :: [
    group_name: group_name_type,
    policy_name: policy_name_type,
  ]

  @type delete_group_request :: [
    group_name: group_name_type,
  ]

  @type delete_instance_profile_request :: [
    instance_profile_name: instance_profile_name_type,
  ]

  @type delete_login_profile_request :: [
    user_name: user_name_type,
  ]

  @type delete_open_id_connect_provider_request :: [
    open_id_connect_provider_arn: arn_type,
  ]

  @type delete_policy_request :: [
    policy_arn: arn_type,
  ]

  @type delete_policy_version_request :: [
    policy_arn: arn_type,
    version_id: policy_version_id_type,
  ]

  @type delete_role_policy_request :: [
    policy_name: policy_name_type,
    role_name: role_name_type,
  ]

  @type delete_role_request :: [
    role_name: role_name_type,
  ]

  @type delete_saml_provider_request :: [
    saml_provider_arn: arn_type,
  ]

  @type delete_ssh_public_key_request :: [
    ssh_public_key_id: public_key_id_type,
    user_name: user_name_type,
  ]

  @type delete_server_certificate_request :: [
    server_certificate_name: server_certificate_name_type,
  ]

  @type delete_signing_certificate_request :: [
    certificate_id: certificate_id_type,
    user_name: existing_user_name_type,
  ]

  @type delete_user_policy_request :: [
    policy_name: policy_name_type,
    user_name: existing_user_name_type,
  ]

  @type delete_user_request :: [
    user_name: existing_user_name_type,
  ]

  @type delete_virtual_mfa_device_request :: [
    serial_number: serial_number_type,
  ]

  @type detach_group_policy_request :: [
    group_name: group_name_type,
    policy_arn: arn_type,
  ]

  @type detach_role_policy_request :: [
    policy_arn: arn_type,
    role_name: role_name_type,
  ]

  @type detach_user_policy_request :: [
    policy_arn: arn_type,
    user_name: user_name_type,
  ]

  @type duplicate_certificate_exception :: [
    message: duplicate_certificate_message,
  ]

  @type duplicate_ssh_public_key_exception :: [
    message: duplicate_ssh_public_key_message,
  ]

  @type enable_mfa_device_request :: [
    authentication_code1: authentication_code_type,
    authentication_code2: authentication_code_type,
    serial_number: serial_number_type,
    user_name: existing_user_name_type,
  ]

  @type entity_already_exists_exception :: [
    message: entity_already_exists_message,
  ]

  @type entity_temporarily_unmodifiable_exception :: [
    message: entity_temporarily_unmodifiable_message,
  ]

  @type entity_type :: binary

  @type generate_credential_report_response :: [
    description: report_state_description_type,
    state: report_state_type,
  ]

  @type get_access_key_last_used_request :: [
    access_key_id: access_key_id_type,
  ]

  @type get_access_key_last_used_response :: [
    access_key_last_used: access_key_last_used,
    user_name: existing_user_name_type,
  ]

  @type get_account_authorization_details_request :: [
    filter: entity_list_type,
    marker: marker_type,
    max_items: max_items_type,
  ]

  @type get_account_authorization_details_response :: [
    group_detail_list: group_detail_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
    policies: managed_policy_detail_list_type,
    role_detail_list: role_detail_list_type,
    user_detail_list: user_detail_list_type,
  ]

  @type get_account_password_policy_response :: [
    password_policy: password_policy,
  ]

  @type get_account_summary_response :: [
    summary_map: summary_map_type,
  ]

  @type get_credential_report_response :: [
    content: report_content_type,
    generated_time: date_type,
    report_format: report_format_type,
  ]

  @type get_group_policy_request :: [
    group_name: group_name_type,
    policy_name: policy_name_type,
  ]

  @type get_group_policy_response :: [
    group_name: group_name_type,
    policy_document: policy_document_type,
    policy_name: policy_name_type,
  ]

  @type get_group_request :: [
    group_name: group_name_type,
    marker: marker_type,
    max_items: max_items_type,
  ]

  @type get_group_response :: [
    group: group,
    is_truncated: boolean_type,
    marker: marker_type,
    users: user_list_type,
  ]

  @type get_instance_profile_request :: [
    instance_profile_name: instance_profile_name_type,
  ]

  @type get_instance_profile_response :: [
    instance_profile: instance_profile,
  ]

  @type get_login_profile_request :: [
    user_name: user_name_type,
  ]

  @type get_login_profile_response :: [
    login_profile: login_profile,
  ]

  @type get_open_id_connect_provider_request :: [
    open_id_connect_provider_arn: arn_type,
  ]

  @type get_open_id_connect_provider_response :: [
    client_id_list: client_id_list_type,
    create_date: date_type,
    thumbprint_list: thumbprint_list_type,
    url: open_id_connect_provider_url_type,
  ]

  @type get_policy_request :: [
    policy_arn: arn_type,
  ]

  @type get_policy_response :: [
    policy: policy,
  ]

  @type get_policy_version_request :: [
    policy_arn: arn_type,
    version_id: policy_version_id_type,
  ]

  @type get_policy_version_response :: [
    policy_version: policy_version,
  ]

  @type get_role_policy_request :: [
    policy_name: policy_name_type,
    role_name: role_name_type,
  ]

  @type get_role_policy_response :: [
    policy_document: policy_document_type,
    policy_name: policy_name_type,
    role_name: role_name_type,
  ]

  @type get_role_request :: [
    role_name: role_name_type,
  ]

  @type get_role_response :: [
    role: role,
  ]

  @type get_saml_provider_request :: [
    saml_provider_arn: arn_type,
  ]

  @type get_saml_provider_response :: [
    create_date: date_type,
    saml_metadata_document: saml_metadata_document_type,
    valid_until: date_type,
  ]

  @type get_ssh_public_key_request :: [
    encoding: encoding_type,
    ssh_public_key_id: public_key_id_type,
    user_name: user_name_type,
  ]

  @type get_ssh_public_key_response :: [
    ssh_public_key: ssh_public_key,
  ]

  @type get_server_certificate_request :: [
    server_certificate_name: server_certificate_name_type,
  ]

  @type get_server_certificate_response :: [
    server_certificate: server_certificate,
  ]

  @type get_user_policy_request :: [
    policy_name: policy_name_type,
    user_name: existing_user_name_type,
  ]

  @type get_user_policy_response :: [
    policy_document: policy_document_type,
    policy_name: policy_name_type,
    user_name: existing_user_name_type,
  ]

  @type get_user_request :: [
    user_name: existing_user_name_type,
  ]

  @type get_user_response :: [
    user: user,
  ]

  @type group :: [
    arn: arn_type,
    create_date: date_type,
    group_id: id_type,
    group_name: group_name_type,
    path: path_type,
  ]

  @type group_detail :: [
    arn: arn_type,
    attached_managed_policies: attached_policies_list_type,
    create_date: date_type,
    group_id: id_type,
    group_name: group_name_type,
    group_policy_list: policy_detail_list_type,
    path: path_type,
  ]

  @type instance_profile :: [
    arn: arn_type,
    create_date: date_type,
    instance_profile_id: id_type,
    instance_profile_name: instance_profile_name_type,
    path: path_type,
    roles: role_list_type,
  ]

  @type invalid_authentication_code_exception :: [
    message: invalid_authentication_code_message,
  ]

  @type invalid_certificate_exception :: [
    message: invalid_certificate_message,
  ]

  @type invalid_input_exception :: [
    message: invalid_input_message,
  ]

  @type invalid_public_key_exception :: [
    message: invalid_public_key_message,
  ]

  @type invalid_user_type_exception :: [
    message: invalid_user_type_message,
  ]

  @type key_pair_mismatch_exception :: [
    message: key_pair_mismatch_message,
  ]

  @type limit_exceeded_exception :: [
    message: limit_exceeded_message,
  ]

  @type list_access_keys_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: existing_user_name_type,
  ]

  @type list_access_keys_response :: [
    access_key_metadata: access_key_metadata_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_account_aliases_request :: [
    marker: marker_type,
    max_items: max_items_type,
  ]

  @type list_account_aliases_response :: [
    account_aliases: account_alias_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_attached_group_policies_request :: [
    group_name: group_name_type,
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: policy_path_type,
  ]

  @type list_attached_group_policies_response :: [
    attached_policies: attached_policies_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_attached_role_policies_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: policy_path_type,
    role_name: role_name_type,
  ]

  @type list_attached_role_policies_response :: [
    attached_policies: attached_policies_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_attached_user_policies_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: policy_path_type,
    user_name: user_name_type,
  ]

  @type list_attached_user_policies_response :: [
    attached_policies: attached_policies_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_entities_for_policy_request :: [
    entity_filter: entity_type,
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_type,
    policy_arn: arn_type,
  ]

  @type list_entities_for_policy_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    policy_groups: policy_group_list_type,
    policy_roles: policy_role_list_type,
    policy_users: policy_user_list_type,
  ]

  @type list_group_policies_request :: [
    group_name: group_name_type,
    marker: marker_type,
    max_items: max_items_type,
  ]

  @type list_group_policies_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    policy_names: policy_name_list_type,
  ]

  @type list_groups_for_user_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: existing_user_name_type,
  ]

  @type list_groups_for_user_response :: [
    groups: group_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_groups_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_prefix_type,
  ]

  @type list_groups_response :: [
    groups: group_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_instance_profiles_for_role_request :: [
    marker: marker_type,
    max_items: max_items_type,
    role_name: role_name_type,
  ]

  @type list_instance_profiles_for_role_response :: [
    instance_profiles: instance_profile_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_instance_profiles_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_prefix_type,
  ]

  @type list_instance_profiles_response :: [
    instance_profiles: instance_profile_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_mfa_devices_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: existing_user_name_type,
  ]

  @type list_mfa_devices_response :: [
    is_truncated: boolean_type,
    mfa_devices: mfa_device_list_type,
    marker: marker_type,
  ]

  @type list_open_id_connect_providers_request :: [
  ]

  @type list_open_id_connect_providers_response :: [
    open_id_connect_provider_list: open_id_connect_provider_list_type,
  ]

  @type list_policies_request :: [
    marker: marker_type,
    max_items: max_items_type,
    only_attached: boolean_type,
    path_prefix: policy_path_type,
    scope: policy_scope_type,
  ]

  @type list_policies_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    policies: policy_list_type,
  ]

  @type list_policy_versions_request :: [
    marker: marker_type,
    max_items: max_items_type,
    policy_arn: arn_type,
  ]

  @type list_policy_versions_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    versions: policy_document_version_list_type,
  ]

  @type list_role_policies_request :: [
    marker: marker_type,
    max_items: max_items_type,
    role_name: role_name_type,
  ]

  @type list_role_policies_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    policy_names: policy_name_list_type,
  ]

  @type list_roles_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_prefix_type,
  ]

  @type list_roles_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    roles: role_list_type,
  ]

  @type list_saml_providers_request :: [
  ]

  @type list_saml_providers_response :: [
    saml_provider_list: saml_provider_list_type,
  ]

  @type list_ssh_public_keys_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: user_name_type,
  ]

  @type list_ssh_public_keys_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    ssh_public_keys: ssh_public_key_list_type,
  ]

  @type list_server_certificates_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_prefix_type,
  ]

  @type list_server_certificates_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    server_certificate_metadata_list: server_certificate_metadata_list_type,
  ]

  @type list_signing_certificates_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: existing_user_name_type,
  ]

  @type list_signing_certificates_response :: [
    certificates: certificate_list_type,
    is_truncated: boolean_type,
    marker: marker_type,
  ]

  @type list_user_policies_request :: [
    marker: marker_type,
    max_items: max_items_type,
    user_name: existing_user_name_type,
  ]

  @type list_user_policies_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    policy_names: policy_name_list_type,
  ]

  @type list_users_request :: [
    marker: marker_type,
    max_items: max_items_type,
    path_prefix: path_prefix_type,
  ]

  @type list_users_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    users: user_list_type,
  ]

  @type list_virtual_mfa_devices_request :: [
    assignment_status: assignment_status_type,
    marker: marker_type,
    max_items: max_items_type,
  ]

  @type list_virtual_mfa_devices_response :: [
    is_truncated: boolean_type,
    marker: marker_type,
    virtual_mfa_devices: virtual_mfa_device_list_type,
  ]

  @type login_profile :: [
    create_date: date_type,
    password_reset_required: boolean_type,
    user_name: user_name_type,
  ]

  @type mfa_device :: [
    enable_date: date_type,
    serial_number: serial_number_type,
    user_name: user_name_type,
  ]

  @type malformed_certificate_exception :: [
    message: malformed_certificate_message,
  ]

  @type malformed_policy_document_exception :: [
    message: malformed_policy_document_message,
  ]

  @type managed_policy_detail :: [
    arn: arn_type,
    attachment_count: attachment_count_type,
    create_date: date_type,
    default_version_id: policy_version_id_type,
    description: policy_description_type,
    is_attachable: boolean_type,
    path: policy_path_type,
    policy_id: id_type,
    policy_name: policy_name_type,
    policy_version_list: policy_document_version_list_type,
    update_date: date_type,
  ]

  @type managed_policy_detail_list_type :: [managed_policy_detail]

  @type no_such_entity_exception :: [
    message: no_such_entity_message,
  ]

  @type open_id_connect_provider_list_entry :: [
    arn: arn_type,
  ]

  @type open_id_connect_provider_list_type :: [open_id_connect_provider_list_entry]

  @type open_id_connect_provider_url_type :: binary

  @type password_policy :: [
    allow_users_to_change_password: boolean_type,
    expire_passwords: boolean_type,
    hard_expiry: boolean_object_type,
    max_password_age: max_password_age_type,
    minimum_password_length: minimum_password_length_type,
    password_reuse_prevention: password_reuse_prevention_type,
    require_lowercase_characters: boolean_type,
    require_numbers: boolean_type,
    require_symbols: boolean_type,
    require_uppercase_characters: boolean_type,
  ]

  @type password_policy_violation_exception :: [
    message: password_policy_violation_message,
  ]

  @type policy :: [
    arn: arn_type,
    attachment_count: attachment_count_type,
    create_date: date_type,
    default_version_id: policy_version_id_type,
    description: policy_description_type,
    is_attachable: boolean_type,
    path: policy_path_type,
    policy_id: id_type,
    policy_name: policy_name_type,
    update_date: date_type,
  ]

  @type policy_detail :: [
    policy_document: policy_document_type,
    policy_name: policy_name_type,
  ]

  @type policy_group :: [
    group_name: group_name_type,
  ]

  @type policy_group_list_type :: [policy_group]

  @type policy_role :: [
    role_name: role_name_type,
  ]

  @type policy_role_list_type :: [policy_role]

  @type policy_user :: [
    user_name: user_name_type,
  ]

  @type policy_user_list_type :: [policy_user]

  @type policy_version :: [
    create_date: date_type,
    document: policy_document_type,
    is_default_version: boolean_type,
    version_id: policy_version_id_type,
  ]

  @type put_group_policy_request :: [
    group_name: group_name_type,
    policy_document: policy_document_type,
    policy_name: policy_name_type,
  ]

  @type put_role_policy_request :: [
    policy_document: policy_document_type,
    policy_name: policy_name_type,
    role_name: role_name_type,
  ]

  @type put_user_policy_request :: [
    policy_document: policy_document_type,
    policy_name: policy_name_type,
    user_name: existing_user_name_type,
  ]

  @type remove_client_id_from_open_id_connect_provider_request :: [
    client_id: client_id_type,
    open_id_connect_provider_arn: arn_type,
  ]

  @type remove_role_from_instance_profile_request :: [
    instance_profile_name: instance_profile_name_type,
    role_name: role_name_type,
  ]

  @type remove_user_from_group_request :: [
    group_name: group_name_type,
    user_name: existing_user_name_type,
  ]

  @type report_content_type :: binary

  @type report_format_type :: binary

  @type report_state_description_type :: binary

  @type report_state_type :: binary

  @type resync_mfa_device_request :: [
    authentication_code1: authentication_code_type,
    authentication_code2: authentication_code_type,
    serial_number: serial_number_type,
    user_name: existing_user_name_type,
  ]

  @type role :: [
    arn: arn_type,
    assume_role_policy_document: policy_document_type,
    create_date: date_type,
    path: path_type,
    role_id: id_type,
    role_name: role_name_type,
  ]

  @type role_detail :: [
    arn: arn_type,
    assume_role_policy_document: policy_document_type,
    attached_managed_policies: attached_policies_list_type,
    create_date: date_type,
    instance_profile_list: instance_profile_list_type,
    path: path_type,
    role_id: id_type,
    role_name: role_name_type,
    role_policy_list: policy_detail_list_type,
  ]

  @type saml_metadata_document_type :: binary

  @type saml_provider_list_entry :: [
    arn: arn_type,
    create_date: date_type,
    valid_until: date_type,
  ]

  @type saml_provider_list_type :: [saml_provider_list_entry]

  @type saml_provider_name_type :: binary

  @type ssh_public_key :: [
    fingerprint: public_key_fingerprint_type,
    ssh_public_key_body: public_key_material_type,
    ssh_public_key_id: public_key_id_type,
    status: status_type,
    upload_date: date_type,
    user_name: user_name_type,
  ]

  @type ssh_public_key_list_type :: [ssh_public_key_metadata]

  @type ssh_public_key_metadata :: [
    ssh_public_key_id: public_key_id_type,
    status: status_type,
    upload_date: date_type,
    user_name: user_name_type,
  ]

  @type server_certificate :: [
    certificate_body: certificate_body_type,
    certificate_chain: certificate_chain_type,
    server_certificate_metadata: server_certificate_metadata,
  ]

  @type server_certificate_metadata :: [
    arn: arn_type,
    expiration: date_type,
    path: path_type,
    server_certificate_id: id_type,
    server_certificate_name: server_certificate_name_type,
    upload_date: date_type,
  ]

  @type service_failure_exception :: [
    message: service_failure_exception_message,
  ]

  @type set_default_policy_version_request :: [
    policy_arn: arn_type,
    version_id: policy_version_id_type,
  ]

  @type signing_certificate :: [
    certificate_body: certificate_body_type,
    certificate_id: certificate_id_type,
    status: status_type,
    upload_date: date_type,
    user_name: user_name_type,
  ]

  @type unrecognized_public_key_encoding_exception :: [
    message: unrecognized_public_key_encoding_message,
  ]

  @type update_access_key_request :: [
    access_key_id: access_key_id_type,
    status: status_type,
    user_name: existing_user_name_type,
  ]

  @type update_account_password_policy_request :: [
    allow_users_to_change_password: boolean_type,
    hard_expiry: boolean_object_type,
    max_password_age: max_password_age_type,
    minimum_password_length: minimum_password_length_type,
    password_reuse_prevention: password_reuse_prevention_type,
    require_lowercase_characters: boolean_type,
    require_numbers: boolean_type,
    require_symbols: boolean_type,
    require_uppercase_characters: boolean_type,
  ]

  @type update_assume_role_policy_request :: [
    policy_document: policy_document_type,
    role_name: role_name_type,
  ]

  @type update_group_request :: [
    group_name: group_name_type,
    new_group_name: group_name_type,
    new_path: path_type,
  ]

  @type update_login_profile_request :: [
    password: password_type,
    password_reset_required: boolean_object_type,
    user_name: user_name_type,
  ]

  @type update_open_id_connect_provider_thumbprint_request :: [
    open_id_connect_provider_arn: arn_type,
    thumbprint_list: thumbprint_list_type,
  ]

  @type update_saml_provider_request :: [
    saml_metadata_document: saml_metadata_document_type,
    saml_provider_arn: arn_type,
  ]

  @type update_saml_provider_response :: [
    saml_provider_arn: arn_type,
  ]

  @type update_ssh_public_key_request :: [
    ssh_public_key_id: public_key_id_type,
    status: status_type,
    user_name: user_name_type,
  ]

  @type update_server_certificate_request :: [
    new_path: path_type,
    new_server_certificate_name: server_certificate_name_type,
    server_certificate_name: server_certificate_name_type,
  ]

  @type update_signing_certificate_request :: [
    certificate_id: certificate_id_type,
    status: status_type,
    user_name: existing_user_name_type,
  ]

  @type update_user_request :: [
    new_path: path_type,
    new_user_name: user_name_type,
    user_name: existing_user_name_type,
  ]

  @type upload_ssh_public_key_request :: [
    ssh_public_key_body: public_key_material_type,
    user_name: user_name_type,
  ]

  @type upload_ssh_public_key_response :: [
    ssh_public_key: ssh_public_key,
  ]

  @type upload_server_certificate_request :: [
    certificate_body: certificate_body_type,
    certificate_chain: certificate_chain_type,
    path: path_type,
    private_key: private_key_type,
    server_certificate_name: server_certificate_name_type,
  ]

  @type upload_server_certificate_response :: [
    server_certificate_metadata: server_certificate_metadata,
  ]

  @type upload_signing_certificate_request :: [
    certificate_body: certificate_body_type,
    user_name: existing_user_name_type,
  ]

  @type upload_signing_certificate_response :: [
    certificate: signing_certificate,
  ]

  @type user :: [
    arn: arn_type,
    create_date: date_type,
    password_last_used: date_type,
    path: path_type,
    user_id: id_type,
    user_name: user_name_type,
  ]

  @type user_detail :: [
    arn: arn_type,
    attached_managed_policies: attached_policies_list_type,
    create_date: date_type,
    group_list: group_name_list_type,
    path: path_type,
    user_id: id_type,
    user_name: user_name_type,
    user_policy_list: policy_detail_list_type,
  ]

  @type virtual_mfa_device :: [
    base32_string_seed: bootstrap_datum,
    enable_date: date_type,
    qr_code_png: bootstrap_datum,
    serial_number: serial_number_type,
    user: user,
  ]

  @type access_key_id_type :: binary

  @type access_key_metadata_list_type :: [access_key_metadata]

  @type access_key_secret_type :: binary

  @type account_alias_list_type :: [account_alias_type]

  @type account_alias_type :: binary

  @type arn_type :: binary

  @type assignment_status_type :: binary

  @type attached_policies_list_type :: [attached_policy]

  @type attachment_count_type :: integer

  @type authentication_code_type :: binary

  @type boolean_object_type :: boolean

  @type boolean_type :: boolean

  @type certificate_body_type :: binary

  @type certificate_chain_type :: binary

  @type certificate_id_type :: binary

  @type certificate_list_type :: [signing_certificate]

  @type client_id_list_type :: [client_id_type]

  @type client_id_type :: binary

  @type credential_report_expired_exception_message :: binary

  @type credential_report_not_present_exception_message :: binary

  @type credential_report_not_ready_exception_message :: binary

  @type date_type :: integer

  @type delete_conflict_message :: binary

  @type duplicate_certificate_message :: binary

  @type duplicate_ssh_public_key_message :: binary

  @type encoding_type :: binary

  @type entity_already_exists_message :: binary

  @type entity_list_type :: [entity_type]

  @type entity_temporarily_unmodifiable_message :: binary

  @type existing_user_name_type :: binary

  @type group_detail_list_type :: [group_detail]

  @type group_list_type :: [group]

  @type group_name_list_type :: [group_name_type]

  @type group_name_type :: binary

  @type id_type :: binary

  @type instance_profile_list_type :: [instance_profile]

  @type instance_profile_name_type :: binary

  @type invalid_authentication_code_message :: binary

  @type invalid_certificate_message :: binary

  @type invalid_input_message :: binary

  @type invalid_public_key_message :: binary

  @type invalid_user_type_message :: binary

  @type key_pair_mismatch_message :: binary

  @type limit_exceeded_message :: binary

  @type malformed_certificate_message :: binary

  @type malformed_policy_document_message :: binary

  @type marker_type :: binary

  @type max_items_type :: integer

  @type max_password_age_type :: integer

  @type mfa_device_list_type :: [mfa_device]

  @type minimum_password_length_type :: integer

  @type no_such_entity_message :: binary

  @type password_policy_violation_message :: binary

  @type password_reuse_prevention_type :: integer

  @type password_type :: binary

  @type path_prefix_type :: binary

  @type path_type :: binary

  @type policy_description_type :: binary

  @type policy_detail_list_type :: [policy_detail]

  @type policy_document_type :: binary

  @type policy_document_version_list_type :: [policy_version]

  @type policy_list_type :: [policy]

  @type policy_name_list_type :: [policy_name_type]

  @type policy_name_type :: binary

  @type policy_path_type :: binary

  @type policy_scope_type :: binary

  @type policy_version_id_type :: binary

  @type private_key_type :: binary

  @type public_key_fingerprint_type :: binary

  @type public_key_id_type :: binary

  @type public_key_material_type :: binary

  @type role_detail_list_type :: [role_detail]

  @type role_list_type :: [role]

  @type role_name_type :: binary

  @type serial_number_type :: binary

  @type server_certificate_metadata_list_type :: [server_certificate_metadata]

  @type server_certificate_name_type :: binary

  @type service_failure_exception_message :: binary

  @type status_type :: binary

  @type string_type :: binary

  @type summary_key_type :: binary

  @type summary_map_type :: [{summary_key_type, summary_value_type}]

  @type summary_value_type :: integer

  @type thumbprint_list_type :: [thumbprint_type]

  @type thumbprint_type :: binary

  @type unrecognized_public_key_encoding_message :: binary

  @type user_detail_list_type :: [user_detail]

  @type user_list_type :: [user]

  @type user_name_type :: binary

  @type virtual_mfa_device_list_type :: [virtual_mfa_device]

  @type virtual_mfa_device_name :: binary




  @doc """
  AddClientIDToOpenIDConnectProvider

  Adds a new client ID (also known as audience) to the list of client IDs
  already registered for the specified IAM OpenID Connect provider.

  This action is idempotent; it does not fail or return an error if you add
  an existing client ID to the provider.
  """

  @spec add_client_id_to_open_id_connect_provider(client :: ExAws.Iam.t, input :: add_client_id_to_open_id_connect_provider_request) :: ExAws.Request.Query.response_t
  def add_client_id_to_open_id_connect_provider(client, input) do
    request(client, "/", "AddClientIDToOpenIDConnectProvider", input)
  end

  @doc """
  Same as `add_client_id_to_open_id_connect_provider/2` but raise on error.
  """
  @spec add_client_id_to_open_id_connect_provider!(client :: ExAws.Iam.t, input :: add_client_id_to_open_id_connect_provider_request) :: ExAws.Request.Query.success_t | no_return
  def add_client_id_to_open_id_connect_provider!(client, input) do
    case add_client_id_to_open_id_connect_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddRoleToInstanceProfile

  Adds the specified role to the specified instance profile. For more
  information about roles, go to [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).
  For more information about instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).
  """

  @spec add_role_to_instance_profile(client :: ExAws.Iam.t, input :: add_role_to_instance_profile_request) :: ExAws.Request.Query.response_t
  def add_role_to_instance_profile(client, input) do
    request(client, "/", "AddRoleToInstanceProfile", input)
  end

  @doc """
  Same as `add_role_to_instance_profile/2` but raise on error.
  """
  @spec add_role_to_instance_profile!(client :: ExAws.Iam.t, input :: add_role_to_instance_profile_request) :: ExAws.Request.Query.success_t | no_return
  def add_role_to_instance_profile!(client, input) do
    case add_role_to_instance_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddUserToGroup

  Adds the specified user to the specified group.
  """

  @spec add_user_to_group(client :: ExAws.Iam.t, input :: add_user_to_group_request) :: ExAws.Request.Query.response_t
  def add_user_to_group(client, input) do
    request(client, "/", "AddUserToGroup", input)
  end

  @doc """
  Same as `add_user_to_group/2` but raise on error.
  """
  @spec add_user_to_group!(client :: ExAws.Iam.t, input :: add_user_to_group_request) :: ExAws.Request.Query.success_t | no_return
  def add_user_to_group!(client, input) do
    case add_user_to_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachGroupPolicy

  Attaches the specified managed policy to the specified group.

  You use this API to attach a managed policy to a group. To embed an inline
  policy in a group, use `PutGroupPolicy`.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec attach_group_policy(client :: ExAws.Iam.t, input :: attach_group_policy_request) :: ExAws.Request.Query.response_t
  def attach_group_policy(client, input) do
    request(client, "/", "AttachGroupPolicy", input)
  end

  @doc """
  Same as `attach_group_policy/2` but raise on error.
  """
  @spec attach_group_policy!(client :: ExAws.Iam.t, input :: attach_group_policy_request) :: ExAws.Request.Query.success_t | no_return
  def attach_group_policy!(client, input) do
    case attach_group_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachRolePolicy

  Attaches the specified managed policy to the specified role.

  When you attach a managed policy to a role, the managed policy is used as
  the role's access (permissions) policy. You cannot use a managed policy as
  the role's trust policy. The role's trust policy is created at the same
  time as the role, using `CreateRole`. You can update a role's trust policy
  using `UpdateAssumeRolePolicy`.

  Use this API to attach a managed policy to a role. To embed an inline
  policy in a role, use `PutRolePolicy`. For more information about policies,
  refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec attach_role_policy(client :: ExAws.Iam.t, input :: attach_role_policy_request) :: ExAws.Request.Query.response_t
  def attach_role_policy(client, input) do
    request(client, "/", "AttachRolePolicy", input)
  end

  @doc """
  Same as `attach_role_policy/2` but raise on error.
  """
  @spec attach_role_policy!(client :: ExAws.Iam.t, input :: attach_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def attach_role_policy!(client, input) do
    case attach_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachUserPolicy

  Attaches the specified managed policy to the specified user.

  You use this API to attach a managed policy to a user. To embed an inline
  policy in a user, use `PutUserPolicy`.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec attach_user_policy(client :: ExAws.Iam.t, input :: attach_user_policy_request) :: ExAws.Request.Query.response_t
  def attach_user_policy(client, input) do
    request(client, "/", "AttachUserPolicy", input)
  end

  @doc """
  Same as `attach_user_policy/2` but raise on error.
  """
  @spec attach_user_policy!(client :: ExAws.Iam.t, input :: attach_user_policy_request) :: ExAws.Request.Query.success_t | no_return
  def attach_user_policy!(client, input) do
    case attach_user_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ChangePassword

  Changes the password of the IAM user who is calling this action. The root
  account password is not affected by this action.

  To change the password for a different user, see `UpdateLoginProfile`. For
  more information about modifying passwords, see [Managing
  Passwords](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html)
  in the *Using IAM* guide.
  """

  @spec change_password(client :: ExAws.Iam.t, input :: change_password_request) :: ExAws.Request.Query.response_t
  def change_password(client, input) do
    request(client, "/", "ChangePassword", input)
  end

  @doc """
  Same as `change_password/2` but raise on error.
  """
  @spec change_password!(client :: ExAws.Iam.t, input :: change_password_request) :: ExAws.Request.Query.success_t | no_return
  def change_password!(client, input) do
    case change_password(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateAccessKey

  Creates a new AWS secret access key and corresponding AWS access key ID for
  the specified user. The default status for new keys is `Active`.

  If you do not specify a user name, IAM determines the user name implicitly
  based on the AWS access key ID signing the request. Because this action
  works for access keys under the AWS account, you can use this action to
  manage root credentials even if the AWS account has no associated users.

  For information about limits on the number of keys you can create, see
  [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  ** To ensure the security of your AWS account, the secret access key is
  accessible only during key and user creation. You must save the key (for
  example, in a text file) if you want to be able to access it again. If a
  secret key is lost, you can delete the access keys for the associated user
  and then create new keys. **
  """

  @spec create_access_key(client :: ExAws.Iam.t, input :: create_access_key_request) :: ExAws.Request.Query.response_t
  def create_access_key(client, input) do
    request(client, "/", "CreateAccessKey", input)
  end

  @doc """
  Same as `create_access_key/2` but raise on error.
  """
  @spec create_access_key!(client :: ExAws.Iam.t, input :: create_access_key_request) :: ExAws.Request.Query.success_t | no_return
  def create_access_key!(client, input) do
    case create_access_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateAccountAlias

  Creates an alias for your AWS account. For information about using an AWS
  account alias, see [Using an Alias for Your AWS Account
  ID](http://docs.aws.amazon.com/IAM/latest/UserGuide/AccountAlias.html) in
  the *Using IAM* guide.
  """

  @spec create_account_alias(client :: ExAws.Iam.t, input :: create_account_alias_request) :: ExAws.Request.Query.response_t
  def create_account_alias(client, input) do
    request(client, "/", "CreateAccountAlias", input)
  end

  @doc """
  Same as `create_account_alias/2` but raise on error.
  """
  @spec create_account_alias!(client :: ExAws.Iam.t, input :: create_account_alias_request) :: ExAws.Request.Query.success_t | no_return
  def create_account_alias!(client, input) do
    case create_account_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateGroup

  Creates a new group.

  For information about the number of groups you can create, see [Limitations
  on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.
  """

  @spec create_group(client :: ExAws.Iam.t, input :: create_group_request) :: ExAws.Request.Query.response_t
  def create_group(client, input) do
    request(client, "/", "CreateGroup", input)
  end

  @doc """
  Same as `create_group/2` but raise on error.
  """
  @spec create_group!(client :: ExAws.Iam.t, input :: create_group_request) :: ExAws.Request.Query.success_t | no_return
  def create_group!(client, input) do
    case create_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateInstanceProfile

  Creates a new instance profile. For information about instance profiles, go
  to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).

  For information about the number of instance profiles you can create, see
  [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.
  """

  @spec create_instance_profile(client :: ExAws.Iam.t, input :: create_instance_profile_request) :: ExAws.Request.Query.response_t
  def create_instance_profile(client, input) do
    request(client, "/", "CreateInstanceProfile", input)
  end

  @doc """
  Same as `create_instance_profile/2` but raise on error.
  """
  @spec create_instance_profile!(client :: ExAws.Iam.t, input :: create_instance_profile_request) :: ExAws.Request.Query.success_t | no_return
  def create_instance_profile!(client, input) do
    case create_instance_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLoginProfile

  Creates a password for the specified user, giving the user the ability to
  access AWS services through the AWS Management Console. For more
  information about managing passwords, see [Managing
  Passwords](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html)
  in the *Using IAM* guide.
  """

  @spec create_login_profile(client :: ExAws.Iam.t, input :: create_login_profile_request) :: ExAws.Request.Query.response_t
  def create_login_profile(client, input) do
    request(client, "/", "CreateLoginProfile", input)
  end

  @doc """
  Same as `create_login_profile/2` but raise on error.
  """
  @spec create_login_profile!(client :: ExAws.Iam.t, input :: create_login_profile_request) :: ExAws.Request.Query.success_t | no_return
  def create_login_profile!(client, input) do
    case create_login_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateOpenIDConnectProvider

  Creates an IAM entity to describe an identity provider (IdP) that supports
  [OpenID Connect (OIDC)](http://openid.net/connect/).

  The OIDC provider that you create with this operation can be used as a
  principal in a role's trust policy to establish a trust relationship
  between AWS and the OIDC provider.

  When you create the IAM OIDC provider, you specify the URL of the OIDC
  identity provider (IdP) to trust, a list of client IDs (also known as
  audiences) that identify the application or applications that are allowed
  to authenticate using the OIDC provider, and a list of thumbprints of the
  server certificate(s) that the IdP uses. You get all of this information
  from the OIDC IdP that you want to use for access to AWS.

  Note:Because trust for the OIDC provider is ultimately derived from the IAM
  provider that this action creates, it is a best practice to limit access to
  the `CreateOpenIDConnectProvider` action to highly-privileged users.
  """

  @spec create_open_id_connect_provider(client :: ExAws.Iam.t, input :: create_open_id_connect_provider_request) :: ExAws.Request.Query.response_t
  def create_open_id_connect_provider(client, input) do
    request(client, "/", "CreateOpenIDConnectProvider", input)
  end

  @doc """
  Same as `create_open_id_connect_provider/2` but raise on error.
  """
  @spec create_open_id_connect_provider!(client :: ExAws.Iam.t, input :: create_open_id_connect_provider_request) :: ExAws.Request.Query.success_t | no_return
  def create_open_id_connect_provider!(client, input) do
    case create_open_id_connect_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePolicy

  Creates a new managed policy for your AWS account.

  This operation creates a policy version with a version identifier of `v1`
  and sets v1 as the policy's default version. For more information about
  policy versions, see [Versioning for Managed
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html)
  in the *Using IAM* guide.

  For more information about managed policies in general, refer to [Managed
  Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec create_policy(client :: ExAws.Iam.t, input :: create_policy_request) :: ExAws.Request.Query.response_t
  def create_policy(client, input) do
    request(client, "/", "CreatePolicy", input)
  end

  @doc """
  Same as `create_policy/2` but raise on error.
  """
  @spec create_policy!(client :: ExAws.Iam.t, input :: create_policy_request) :: ExAws.Request.Query.success_t | no_return
  def create_policy!(client, input) do
    case create_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePolicyVersion

  Creates a new version of the specified managed policy. To update a managed
  policy, you create a new policy version. A managed policy can have up to
  five versions. If the policy has five versions, you must delete an existing
  version using `DeletePolicyVersion` before you create a new version.

  Optionally, you can set the new version as the policy's default version.
  The default version is the operative version; that is, the version that is
  in effect for the IAM users, groups, and roles that the policy is attached
  to.

  For more information about managed policy versions, see [Versioning for
  Managed
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html)
  in the *Using IAM* guide.
  """

  @spec create_policy_version(client :: ExAws.Iam.t, input :: create_policy_version_request) :: ExAws.Request.Query.response_t
  def create_policy_version(client, input) do
    request(client, "/", "CreatePolicyVersion", input)
  end

  @doc """
  Same as `create_policy_version/2` but raise on error.
  """
  @spec create_policy_version!(client :: ExAws.Iam.t, input :: create_policy_version_request) :: ExAws.Request.Query.success_t | no_return
  def create_policy_version!(client, input) do
    case create_policy_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateRole

  Creates a new role for your AWS account. For more information about roles,
  go to [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).
  For information about limitations on role names and the number of roles you
  can create, go to [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  The policy in the following example grants permission to an EC2 instance to
  assume the role.
  """

  @spec create_role(client :: ExAws.Iam.t, input :: create_role_request) :: ExAws.Request.Query.response_t
  def create_role(client, input) do
    request(client, "/", "CreateRole", input)
  end

  @doc """
  Same as `create_role/2` but raise on error.
  """
  @spec create_role!(client :: ExAws.Iam.t, input :: create_role_request) :: ExAws.Request.Query.success_t | no_return
  def create_role!(client, input) do
    case create_role(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSAMLProvider

  Creates an IAM entity to describe an identity provider (IdP) that supports
  SAML 2.0.

  The SAML provider that you create with this operation can be used as a
  principal in a role's trust policy to establish a trust relationship
  between AWS and a SAML identity provider. You can create an IAM role that
  supports Web-based single sign-on (SSO) to the AWS Management Console or
  one that supports API access to AWS.

  When you create the SAML provider, you upload an a SAML metadata document
  that you get from your IdP and that includes the issuer's name, expiration
  information, and keys that can be used to validate the SAML authentication
  response (assertions) that are received from the IdP. You must generate the
  metadata document using the identity management software that is used as
  your organization's IdP.

  Note: This operation requires [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  For more information, see [Giving Console Access Using
  SAML](http://docs.aws.amazon.com/STS/latest/UsingSTS/STSMgmtConsole-SAML.html)
  and [Creating Temporary Security Credentials for SAML
  Federation](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingSAML.html)
  in the *Using Temporary Credentials* guide.
  """

  @spec create_saml_provider(client :: ExAws.Iam.t, input :: create_saml_provider_request) :: ExAws.Request.Query.response_t
  def create_saml_provider(client, input) do
    request(client, "/", "CreateSAMLProvider", input)
  end

  @doc """
  Same as `create_saml_provider/2` but raise on error.
  """
  @spec create_saml_provider!(client :: ExAws.Iam.t, input :: create_saml_provider_request) :: ExAws.Request.Query.success_t | no_return
  def create_saml_provider!(client, input) do
    case create_saml_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateUser

  Creates a new user for your AWS account.

  For information about limitations on the number of users you can create,
  see [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.
  """

  @spec create_user(client :: ExAws.Iam.t, input :: create_user_request) :: ExAws.Request.Query.response_t
  def create_user(client, input) do
    request(client, "/", "CreateUser", input)
  end

  @doc """
  Same as `create_user/2` but raise on error.
  """
  @spec create_user!(client :: ExAws.Iam.t, input :: create_user_request) :: ExAws.Request.Query.success_t | no_return
  def create_user!(client, input) do
    case create_user(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateVirtualMFADevice

  Creates a new virtual MFA device for the AWS account. After creating the
  virtual MFA, use `EnableMFADevice` to attach the MFA device to an IAM user.
  For more information about creating and working with virtual MFA devices,
  go to [Using a Virtual MFA
  Device](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html)
  in the *Using IAM* guide.

  For information about limits on the number of MFA devices you can create,
  see [Limitations on
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  **The seed information contained in the QR code and the Base32 string
  should be treated like any other secret access information, such as your
  AWS access keys or your passwords. After you provision your virtual device,
  you should ensure that the information is destroyed following secure
  procedures. **
  """

  @spec create_virtual_mfa_device(client :: ExAws.Iam.t, input :: create_virtual_mfa_device_request) :: ExAws.Request.Query.response_t
  def create_virtual_mfa_device(client, input) do
    request(client, "/", "CreateVirtualMFADevice", input)
  end

  @doc """
  Same as `create_virtual_mfa_device/2` but raise on error.
  """
  @spec create_virtual_mfa_device!(client :: ExAws.Iam.t, input :: create_virtual_mfa_device_request) :: ExAws.Request.Query.success_t | no_return
  def create_virtual_mfa_device!(client, input) do
    case create_virtual_mfa_device(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeactivateMFADevice

  Deactivates the specified MFA device and removes it from association with
  the user name for which it was originally enabled.

  For more information about creating and working with virtual MFA devices,
  go to [Using a Virtual MFA
  Device](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html)
  in the *Using IAM* guide.
  """

  @spec deactivate_mfa_device(client :: ExAws.Iam.t, input :: deactivate_mfa_device_request) :: ExAws.Request.Query.response_t
  def deactivate_mfa_device(client, input) do
    request(client, "/", "DeactivateMFADevice", input)
  end

  @doc """
  Same as `deactivate_mfa_device/2` but raise on error.
  """
  @spec deactivate_mfa_device!(client :: ExAws.Iam.t, input :: deactivate_mfa_device_request) :: ExAws.Request.Query.success_t | no_return
  def deactivate_mfa_device!(client, input) do
    case deactivate_mfa_device(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAccessKey

  Deletes the access key associated with the specified user.

  If you do not specify a user name, IAM determines the user name implicitly
  based on the AWS access key ID signing the request. Because this action
  works for access keys under the AWS account, you can use this action to
  manage root credentials even if the AWS account has no associated users.
  """

  @spec delete_access_key(client :: ExAws.Iam.t, input :: delete_access_key_request) :: ExAws.Request.Query.response_t
  def delete_access_key(client, input) do
    request(client, "/", "DeleteAccessKey", input)
  end

  @doc """
  Same as `delete_access_key/2` but raise on error.
  """
  @spec delete_access_key!(client :: ExAws.Iam.t, input :: delete_access_key_request) :: ExAws.Request.Query.success_t | no_return
  def delete_access_key!(client, input) do
    case delete_access_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAccountAlias

  Deletes the specified AWS account alias. For information about using an AWS
  account alias, see [Using an Alias for Your AWS Account
  ID](http://docs.aws.amazon.com/IAM/latest/UserGuide/AccountAlias.html) in
  the *Using IAM* guide.
  """

  @spec delete_account_alias(client :: ExAws.Iam.t, input :: delete_account_alias_request) :: ExAws.Request.Query.response_t
  def delete_account_alias(client, input) do
    request(client, "/", "DeleteAccountAlias", input)
  end

  @doc """
  Same as `delete_account_alias/2` but raise on error.
  """
  @spec delete_account_alias!(client :: ExAws.Iam.t, input :: delete_account_alias_request) :: ExAws.Request.Query.success_t | no_return
  def delete_account_alias!(client, input) do
    case delete_account_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAccountPasswordPolicy

  Deletes the password policy for the AWS account.
  """

  @spec delete_account_password_policy(client :: ExAws.Iam.t) :: ExAws.Request.Query.response_t
  def delete_account_password_policy(client) do
    request(client, "/", "DeleteAccountPasswordPolicy", [])
  end

  @doc """
  Same as `delete_account_password_policy/2` but raise on error.
  """
  @spec delete_account_password_policy!(client :: ExAws.Iam.t) :: ExAws.Request.Query.success_t | no_return
  def delete_account_password_policy!(client) do
    case delete_account_password_policy(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteGroup

  Deletes the specified group. The group must not contain any users or have
  any attached policies.
  """

  @spec delete_group(client :: ExAws.Iam.t, input :: delete_group_request) :: ExAws.Request.Query.response_t
  def delete_group(client, input) do
    request(client, "/", "DeleteGroup", input)
  end

  @doc """
  Same as `delete_group/2` but raise on error.
  """
  @spec delete_group!(client :: ExAws.Iam.t, input :: delete_group_request) :: ExAws.Request.Query.success_t | no_return
  def delete_group!(client, input) do
    case delete_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteGroupPolicy

  Deletes the specified inline policy that is embedded in the specified
  group.

  A group can also have managed policies attached to it. To detach a managed
  policy from a group, use `DetachGroupPolicy`. For more information about
  policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec delete_group_policy(client :: ExAws.Iam.t, input :: delete_group_policy_request) :: ExAws.Request.Query.response_t
  def delete_group_policy(client, input) do
    request(client, "/", "DeleteGroupPolicy", input)
  end

  @doc """
  Same as `delete_group_policy/2` but raise on error.
  """
  @spec delete_group_policy!(client :: ExAws.Iam.t, input :: delete_group_policy_request) :: ExAws.Request.Query.success_t | no_return
  def delete_group_policy!(client, input) do
    case delete_group_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteInstanceProfile

  Deletes the specified instance profile. The instance profile must not have
  an associated role.

  ** Make sure you do not have any Amazon EC2 instances running with the
  instance profile you are about to delete. Deleting a role or instance
  profile that is associated with a running instance will break any
  applications running on the instance. ** For more information about
  instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).
  """

  @spec delete_instance_profile(client :: ExAws.Iam.t, input :: delete_instance_profile_request) :: ExAws.Request.Query.response_t
  def delete_instance_profile(client, input) do
    request(client, "/", "DeleteInstanceProfile", input)
  end

  @doc """
  Same as `delete_instance_profile/2` but raise on error.
  """
  @spec delete_instance_profile!(client :: ExAws.Iam.t, input :: delete_instance_profile_request) :: ExAws.Request.Query.success_t | no_return
  def delete_instance_profile!(client, input) do
    case delete_instance_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLoginProfile

  Deletes the password for the specified user, which terminates the user's
  ability to access AWS services through the AWS Management Console.

  ** Deleting a user's password does not prevent a user from accessing IAM
  through the command line interface or the API. To prevent all user access
  you must also either make the access key inactive or delete it. For more
  information about making keys inactive or deleting them, see
  `UpdateAccessKey` and `DeleteAccessKey`. **
  """

  @spec delete_login_profile(client :: ExAws.Iam.t, input :: delete_login_profile_request) :: ExAws.Request.Query.response_t
  def delete_login_profile(client, input) do
    request(client, "/", "DeleteLoginProfile", input)
  end

  @doc """
  Same as `delete_login_profile/2` but raise on error.
  """
  @spec delete_login_profile!(client :: ExAws.Iam.t, input :: delete_login_profile_request) :: ExAws.Request.Query.success_t | no_return
  def delete_login_profile!(client, input) do
    case delete_login_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteOpenIDConnectProvider

  Deletes an IAM OpenID Connect identity provider.

  Deleting an OIDC provider does not update any roles that reference the
  provider as a principal in their trust policies. Any attempt to assume a
  role that references a provider that has been deleted will fail.

  This action is idempotent; it does not fail or return an error if you call
  the action for a provider that was already deleted.
  """

  @spec delete_open_id_connect_provider(client :: ExAws.Iam.t, input :: delete_open_id_connect_provider_request) :: ExAws.Request.Query.response_t
  def delete_open_id_connect_provider(client, input) do
    request(client, "/", "DeleteOpenIDConnectProvider", input)
  end

  @doc """
  Same as `delete_open_id_connect_provider/2` but raise on error.
  """
  @spec delete_open_id_connect_provider!(client :: ExAws.Iam.t, input :: delete_open_id_connect_provider_request) :: ExAws.Request.Query.success_t | no_return
  def delete_open_id_connect_provider!(client, input) do
    case delete_open_id_connect_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePolicy

  Deletes the specified managed policy.

  Before you can delete a managed policy, you must detach the policy from all
  users, groups, and roles that it is attached to, and you must delete all of
  the policy's versions. The following steps describe the process for
  deleting a managed policy:

  - Detach the policy from all users, groups, and roles that the policy is
  attached to, using the `DetachUserPolicy`, `DetachGroupPolicy`, or
  `DetachRolePolicy` APIs. To list all the users, groups, and roles that a
  policy is attached to, use `ListEntitiesForPolicy`.

  - Delete all versions of the policy using `DeletePolicyVersion`. To list
  the policy's versions, use `ListPolicyVersions`. You cannot use
  `DeletePolicyVersion` to delete the version that is marked as the default
  version. You delete the policy's default version in the next step of the
  process.

  - Delete the policy (this automatically deletes the policy's default
  version) using this API.

  For information about managed policies, refer to [Managed Policies and
  Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec delete_policy(client :: ExAws.Iam.t, input :: delete_policy_request) :: ExAws.Request.Query.response_t
  def delete_policy(client, input) do
    request(client, "/", "DeletePolicy", input)
  end

  @doc """
  Same as `delete_policy/2` but raise on error.
  """
  @spec delete_policy!(client :: ExAws.Iam.t, input :: delete_policy_request) :: ExAws.Request.Query.success_t | no_return
  def delete_policy!(client, input) do
    case delete_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePolicyVersion

  Deletes the specified version of the specified managed policy.

  You cannot delete the default version of a policy using this API. To delete
  the default version of a policy, use `DeletePolicy`. To find out which
  version of a policy is marked as the default version, use
  `ListPolicyVersions`.

  For information about versions for managed policies, refer to [Versioning
  for Managed
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html)
  in the *Using IAM* guide.
  """

  @spec delete_policy_version(client :: ExAws.Iam.t, input :: delete_policy_version_request) :: ExAws.Request.Query.response_t
  def delete_policy_version(client, input) do
    request(client, "/", "DeletePolicyVersion", input)
  end

  @doc """
  Same as `delete_policy_version/2` but raise on error.
  """
  @spec delete_policy_version!(client :: ExAws.Iam.t, input :: delete_policy_version_request) :: ExAws.Request.Query.success_t | no_return
  def delete_policy_version!(client, input) do
    case delete_policy_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteRole

  Deletes the specified role. The role must not have any policies attached.
  For more information about roles, go to [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).

  **Make sure you do not have any Amazon EC2 instances running with the role
  you are about to delete. Deleting a role or instance profile that is
  associated with a running instance will break any applications running on
  the instance. **
  """

  @spec delete_role(client :: ExAws.Iam.t, input :: delete_role_request) :: ExAws.Request.Query.response_t
  def delete_role(client, input) do
    request(client, "/", "DeleteRole", input)
  end

  @doc """
  Same as `delete_role/2` but raise on error.
  """
  @spec delete_role!(client :: ExAws.Iam.t, input :: delete_role_request) :: ExAws.Request.Query.success_t | no_return
  def delete_role!(client, input) do
    case delete_role(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteRolePolicy

  Deletes the specified inline policy that is embedded in the specified role.

  A role can also have managed policies attached to it. To detach a managed
  policy from a role, use `DetachRolePolicy`. For more information about
  policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec delete_role_policy(client :: ExAws.Iam.t, input :: delete_role_policy_request) :: ExAws.Request.Query.response_t
  def delete_role_policy(client, input) do
    request(client, "/", "DeleteRolePolicy", input)
  end

  @doc """
  Same as `delete_role_policy/2` but raise on error.
  """
  @spec delete_role_policy!(client :: ExAws.Iam.t, input :: delete_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def delete_role_policy!(client, input) do
    case delete_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSAMLProvider

  Deletes a SAML provider.

  Deleting the provider does not update any roles that reference the SAML
  provider as a principal in their trust policies. Any attempt to assume a
  role that references a SAML provider that has been deleted will fail.

  Note: This operation requires [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  """

  @spec delete_saml_provider(client :: ExAws.Iam.t, input :: delete_saml_provider_request) :: ExAws.Request.Query.response_t
  def delete_saml_provider(client, input) do
    request(client, "/", "DeleteSAMLProvider", input)
  end

  @doc """
  Same as `delete_saml_provider/2` but raise on error.
  """
  @spec delete_saml_provider!(client :: ExAws.Iam.t, input :: delete_saml_provider_request) :: ExAws.Request.Query.success_t | no_return
  def delete_saml_provider!(client, input) do
    case delete_saml_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSSHPublicKey

  Deletes the specified SSH public key.

  The SSH public key deleted by this action is used only for authenticating
  the associated IAM user to an AWS CodeCommit repository. For more
  information about using SSH keys to authenticate to an AWS CodeCommit
  repository, see [Set up AWS CodeCommit for SSH
  Connections](http://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html)
  in the *AWS CodeCommit User Guide*.
  """

  @spec delete_ssh_public_key(client :: ExAws.Iam.t, input :: delete_ssh_public_key_request) :: ExAws.Request.Query.response_t
  def delete_ssh_public_key(client, input) do
    request(client, "/", "DeleteSSHPublicKey", input)
  end

  @doc """
  Same as `delete_ssh_public_key/2` but raise on error.
  """
  @spec delete_ssh_public_key!(client :: ExAws.Iam.t, input :: delete_ssh_public_key_request) :: ExAws.Request.Query.success_t | no_return
  def delete_ssh_public_key!(client, input) do
    case delete_ssh_public_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteServerCertificate

  Deletes the specified server certificate.

  ** If you are using a server certificate with Elastic Load Balancing,
  deleting the certificate could have implications for your application. If
  Elastic Load Balancing doesn't detect the deletion of bound certificates,
  it may continue to use the certificates. This could cause Elastic Load
  Balancing to stop accepting traffic. We recommend that you remove the
  reference to the certificate from Elastic Load Balancing before using this
  command to delete the certificate. For more information, go to
  [DeleteLoadBalancerListeners](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/APIReference/API_DeleteLoadBalancerListeners.html)
  in the *Elastic Load Balancing API Reference*. **
  """

  @spec delete_server_certificate(client :: ExAws.Iam.t, input :: delete_server_certificate_request) :: ExAws.Request.Query.response_t
  def delete_server_certificate(client, input) do
    request(client, "/", "DeleteServerCertificate", input)
  end

  @doc """
  Same as `delete_server_certificate/2` but raise on error.
  """
  @spec delete_server_certificate!(client :: ExAws.Iam.t, input :: delete_server_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def delete_server_certificate!(client, input) do
    case delete_server_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSigningCertificate

  Deletes the specified signing certificate associated with the specified
  user.

  If you do not specify a user name, IAM determines the user name implicitly
  based on the AWS access key ID signing the request. Because this action
  works for access keys under the AWS account, you can use this action to
  manage root credentials even if the AWS account has no associated users.
  """

  @spec delete_signing_certificate(client :: ExAws.Iam.t, input :: delete_signing_certificate_request) :: ExAws.Request.Query.response_t
  def delete_signing_certificate(client, input) do
    request(client, "/", "DeleteSigningCertificate", input)
  end

  @doc """
  Same as `delete_signing_certificate/2` but raise on error.
  """
  @spec delete_signing_certificate!(client :: ExAws.Iam.t, input :: delete_signing_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def delete_signing_certificate!(client, input) do
    case delete_signing_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteUser

  Deletes the specified user. The user must not belong to any groups, have
  any keys or signing certificates, or have any attached policies.
  """

  @spec delete_user(client :: ExAws.Iam.t, input :: delete_user_request) :: ExAws.Request.Query.response_t
  def delete_user(client, input) do
    request(client, "/", "DeleteUser", input)
  end

  @doc """
  Same as `delete_user/2` but raise on error.
  """
  @spec delete_user!(client :: ExAws.Iam.t, input :: delete_user_request) :: ExAws.Request.Query.success_t | no_return
  def delete_user!(client, input) do
    case delete_user(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteUserPolicy

  Deletes the specified inline policy that is embedded in the specified user.

  A user can also have managed policies attached to it. To detach a managed
  policy from a user, use `DetachUserPolicy`. For more information about
  policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec delete_user_policy(client :: ExAws.Iam.t, input :: delete_user_policy_request) :: ExAws.Request.Query.response_t
  def delete_user_policy(client, input) do
    request(client, "/", "DeleteUserPolicy", input)
  end

  @doc """
  Same as `delete_user_policy/2` but raise on error.
  """
  @spec delete_user_policy!(client :: ExAws.Iam.t, input :: delete_user_policy_request) :: ExAws.Request.Query.success_t | no_return
  def delete_user_policy!(client, input) do
    case delete_user_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteVirtualMFADevice

  Deletes a virtual MFA device.

  Note: You must deactivate a user's virtual MFA device before you can delete
  it. For information about deactivating MFA devices, see
  `DeactivateMFADevice`.
  """

  @spec delete_virtual_mfa_device(client :: ExAws.Iam.t, input :: delete_virtual_mfa_device_request) :: ExAws.Request.Query.response_t
  def delete_virtual_mfa_device(client, input) do
    request(client, "/", "DeleteVirtualMFADevice", input)
  end

  @doc """
  Same as `delete_virtual_mfa_device/2` but raise on error.
  """
  @spec delete_virtual_mfa_device!(client :: ExAws.Iam.t, input :: delete_virtual_mfa_device_request) :: ExAws.Request.Query.success_t | no_return
  def delete_virtual_mfa_device!(client, input) do
    case delete_virtual_mfa_device(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachGroupPolicy

  Removes the specified managed policy from the specified group.

  A group can also have inline policies embedded with it. To delete an inline
  policy, use the `DeleteGroupPolicy` API. For information about policies,
  refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec detach_group_policy(client :: ExAws.Iam.t, input :: detach_group_policy_request) :: ExAws.Request.Query.response_t
  def detach_group_policy(client, input) do
    request(client, "/", "DetachGroupPolicy", input)
  end

  @doc """
  Same as `detach_group_policy/2` but raise on error.
  """
  @spec detach_group_policy!(client :: ExAws.Iam.t, input :: detach_group_policy_request) :: ExAws.Request.Query.success_t | no_return
  def detach_group_policy!(client, input) do
    case detach_group_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachRolePolicy

  Removes the specified managed policy from the specified role.

  A role can also have inline policies embedded with it. To delete an inline
  policy, use the `DeleteRolePolicy` API. For information about policies,
  refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec detach_role_policy(client :: ExAws.Iam.t, input :: detach_role_policy_request) :: ExAws.Request.Query.response_t
  def detach_role_policy(client, input) do
    request(client, "/", "DetachRolePolicy", input)
  end

  @doc """
  Same as `detach_role_policy/2` but raise on error.
  """
  @spec detach_role_policy!(client :: ExAws.Iam.t, input :: detach_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def detach_role_policy!(client, input) do
    case detach_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachUserPolicy

  Removes the specified managed policy from the specified user.

  A user can also have inline policies embedded with it. To delete an inline
  policy, use the `DeleteUserPolicy` API. For information about policies,
  refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec detach_user_policy(client :: ExAws.Iam.t, input :: detach_user_policy_request) :: ExAws.Request.Query.response_t
  def detach_user_policy(client, input) do
    request(client, "/", "DetachUserPolicy", input)
  end

  @doc """
  Same as `detach_user_policy/2` but raise on error.
  """
  @spec detach_user_policy!(client :: ExAws.Iam.t, input :: detach_user_policy_request) :: ExAws.Request.Query.success_t | no_return
  def detach_user_policy!(client, input) do
    case detach_user_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableMFADevice

  Enables the specified MFA device and associates it with the specified user
  name. When enabled, the MFA device is required for every subsequent login
  by the user name associated with the device.
  """

  @spec enable_mfa_device(client :: ExAws.Iam.t, input :: enable_mfa_device_request) :: ExAws.Request.Query.response_t
  def enable_mfa_device(client, input) do
    request(client, "/", "EnableMFADevice", input)
  end

  @doc """
  Same as `enable_mfa_device/2` but raise on error.
  """
  @spec enable_mfa_device!(client :: ExAws.Iam.t, input :: enable_mfa_device_request) :: ExAws.Request.Query.success_t | no_return
  def enable_mfa_device!(client, input) do
    case enable_mfa_device(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GenerateCredentialReport

  Generates a credential report for the AWS account. For more information
  about the credential report, see [Getting Credential
  Reports](http://docs.aws.amazon.com/IAM/latest/UserGuide/credential-reports.html)
  in the *Using IAM* guide.
  """

  @spec generate_credential_report(client :: ExAws.Iam.t) :: ExAws.Request.Query.response_t
  def generate_credential_report(client) do
    request(client, "/", "GenerateCredentialReport", [])
  end

  @doc """
  Same as `generate_credential_report/2` but raise on error.
  """
  @spec generate_credential_report!(client :: ExAws.Iam.t) :: ExAws.Request.Query.success_t | no_return
  def generate_credential_report!(client) do
    case generate_credential_report(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetAccessKeyLastUsed

  Retrieves information about when the specified access key was last used.
  The information includes the date and time of last use, along with the AWS
  service and region that were specified in the last request made with that
  key.
  """

  @spec get_access_key_last_used(client :: ExAws.Iam.t, input :: get_access_key_last_used_request) :: ExAws.Request.Query.response_t
  def get_access_key_last_used(client, input) do
    request(client, "/", "GetAccessKeyLastUsed", input)
  end

  @doc """
  Same as `get_access_key_last_used/2` but raise on error.
  """
  @spec get_access_key_last_used!(client :: ExAws.Iam.t, input :: get_access_key_last_used_request) :: ExAws.Request.Query.success_t | no_return
  def get_access_key_last_used!(client, input) do
    case get_access_key_last_used(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetAccountAuthorizationDetails

  Retrieves information about all IAM users, groups, roles, and policies in
  your account, including their relationships to one another. Use this API to
  obtain a snapshot of the configuration of IAM permissions (users, groups,
  roles, and policies) in your account.

  You can optionally filter the results using the `Filter` parameter. You can
  paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec get_account_authorization_details(client :: ExAws.Iam.t, input :: get_account_authorization_details_request) :: ExAws.Request.Query.response_t
  def get_account_authorization_details(client, input) do
    request(client, "/", "GetAccountAuthorizationDetails", input)
  end

  @doc """
  Same as `get_account_authorization_details/2` but raise on error.
  """
  @spec get_account_authorization_details!(client :: ExAws.Iam.t, input :: get_account_authorization_details_request) :: ExAws.Request.Query.success_t | no_return
  def get_account_authorization_details!(client, input) do
    case get_account_authorization_details(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetAccountPasswordPolicy

  Retrieves the password policy for the AWS account. For more information
  about using a password policy, go to [Managing an IAM Password
  Policy](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html).
  """

  @spec get_account_password_policy(client :: ExAws.Iam.t) :: ExAws.Request.Query.response_t
  def get_account_password_policy(client) do
    request(client, "/", "GetAccountPasswordPolicy", [])
  end

  @doc """
  Same as `get_account_password_policy/2` but raise on error.
  """
  @spec get_account_password_policy!(client :: ExAws.Iam.t) :: ExAws.Request.Query.success_t | no_return
  def get_account_password_policy!(client) do
    case get_account_password_policy(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetAccountSummary

  Retrieves information about IAM entity usage and IAM quotas in the AWS
  account.

  For information about limitations on IAM entities, see [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.
  """

  @spec get_account_summary(client :: ExAws.Iam.t) :: ExAws.Request.Query.response_t
  def get_account_summary(client) do
    request(client, "/", "GetAccountSummary", [])
  end

  @doc """
  Same as `get_account_summary/2` but raise on error.
  """
  @spec get_account_summary!(client :: ExAws.Iam.t) :: ExAws.Request.Query.success_t | no_return
  def get_account_summary!(client) do
    case get_account_summary(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetCredentialReport

  Retrieves a credential report for the AWS account. For more information
  about the credential report, see [Getting Credential
  Reports](http://docs.aws.amazon.com/IAM/latest/UserGuide/credential-reports.html)
  in the *Using IAM* guide.
  """

  @spec get_credential_report(client :: ExAws.Iam.t) :: ExAws.Request.Query.response_t
  def get_credential_report(client) do
    request(client, "/", "GetCredentialReport", [])
  end

  @doc """
  Same as `get_credential_report/2` but raise on error.
  """
  @spec get_credential_report!(client :: ExAws.Iam.t) :: ExAws.Request.Query.success_t | no_return
  def get_credential_report!(client) do
    case get_credential_report(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetGroup

  Returns a list of users that are in the specified group. You can paginate
  the results using the `MaxItems` and `Marker` parameters.
  """

  @spec get_group(client :: ExAws.Iam.t, input :: get_group_request) :: ExAws.Request.Query.response_t
  def get_group(client, input) do
    request(client, "/", "GetGroup", input)
  end

  @doc """
  Same as `get_group/2` but raise on error.
  """
  @spec get_group!(client :: ExAws.Iam.t, input :: get_group_request) :: ExAws.Request.Query.success_t | no_return
  def get_group!(client, input) do
    case get_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetGroupPolicy

  Retrieves the specified inline policy document that is embedded in the
  specified group.

  A group can also have managed policies attached to it. To retrieve a
  managed policy document that is attached to a group, use `GetPolicy` to
  determine the policy's default version, then use `GetPolicyVersion` to
  retrieve the policy document.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec get_group_policy(client :: ExAws.Iam.t, input :: get_group_policy_request) :: ExAws.Request.Query.response_t
  def get_group_policy(client, input) do
    request(client, "/", "GetGroupPolicy", input)
  end

  @doc """
  Same as `get_group_policy/2` but raise on error.
  """
  @spec get_group_policy!(client :: ExAws.Iam.t, input :: get_group_policy_request) :: ExAws.Request.Query.success_t | no_return
  def get_group_policy!(client, input) do
    case get_group_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetInstanceProfile

  Retrieves information about the specified instance profile, including the
  instance profile's path, GUID, ARN, and role. For more information about
  instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).
  For more information about ARNs, go to
  [ARNs](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html#Identifiers_ARNs).
  """

  @spec get_instance_profile(client :: ExAws.Iam.t, input :: get_instance_profile_request) :: ExAws.Request.Query.response_t
  def get_instance_profile(client, input) do
    request(client, "/", "GetInstanceProfile", input)
  end

  @doc """
  Same as `get_instance_profile/2` but raise on error.
  """
  @spec get_instance_profile!(client :: ExAws.Iam.t, input :: get_instance_profile_request) :: ExAws.Request.Query.success_t | no_return
  def get_instance_profile!(client, input) do
    case get_instance_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetLoginProfile

  Retrieves the user name and password-creation date for the specified user.
  If the user has not been assigned a password, the action returns a 404
  (`NoSuchEntity`) error.
  """

  @spec get_login_profile(client :: ExAws.Iam.t, input :: get_login_profile_request) :: ExAws.Request.Query.response_t
  def get_login_profile(client, input) do
    request(client, "/", "GetLoginProfile", input)
  end

  @doc """
  Same as `get_login_profile/2` but raise on error.
  """
  @spec get_login_profile!(client :: ExAws.Iam.t, input :: get_login_profile_request) :: ExAws.Request.Query.success_t | no_return
  def get_login_profile!(client, input) do
    case get_login_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetOpenIDConnectProvider

  Returns information about the specified OpenID Connect provider.
  """

  @spec get_open_id_connect_provider(client :: ExAws.Iam.t, input :: get_open_id_connect_provider_request) :: ExAws.Request.Query.response_t
  def get_open_id_connect_provider(client, input) do
    request(client, "/", "GetOpenIDConnectProvider", input)
  end

  @doc """
  Same as `get_open_id_connect_provider/2` but raise on error.
  """
  @spec get_open_id_connect_provider!(client :: ExAws.Iam.t, input :: get_open_id_connect_provider_request) :: ExAws.Request.Query.success_t | no_return
  def get_open_id_connect_provider!(client, input) do
    case get_open_id_connect_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPolicy

  Retrieves information about the specified managed policy, including the
  policy's default version and the total number of users, groups, and roles
  that the policy is attached to. For a list of the specific users, groups,
  and roles that the policy is attached to, use the `ListEntitiesForPolicy`
  API. This API returns metadata about the policy. To retrieve the policy
  document for a specific version of the policy, use `GetPolicyVersion`.

  This API retrieves information about managed policies. To retrieve
  information about an inline policy that is embedded with a user, group, or
  role, use the `GetUserPolicy`, `GetGroupPolicy`, or `GetRolePolicy` API.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec get_policy(client :: ExAws.Iam.t, input :: get_policy_request) :: ExAws.Request.Query.response_t
  def get_policy(client, input) do
    request(client, "/", "GetPolicy", input)
  end

  @doc """
  Same as `get_policy/2` but raise on error.
  """
  @spec get_policy!(client :: ExAws.Iam.t, input :: get_policy_request) :: ExAws.Request.Query.success_t | no_return
  def get_policy!(client, input) do
    case get_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPolicyVersion

  Retrieves information about the specified version of the specified managed
  policy, including the policy document.

  To list the available versions for a policy, use `ListPolicyVersions`.

  This API retrieves information about managed policies. To retrieve
  information about an inline policy that is embedded in a user, group, or
  role, use the `GetUserPolicy`, `GetGroupPolicy`, or `GetRolePolicy` API.

  For more information about the types of policies, refer to [Managed
  Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec get_policy_version(client :: ExAws.Iam.t, input :: get_policy_version_request) :: ExAws.Request.Query.response_t
  def get_policy_version(client, input) do
    request(client, "/", "GetPolicyVersion", input)
  end

  @doc """
  Same as `get_policy_version/2` but raise on error.
  """
  @spec get_policy_version!(client :: ExAws.Iam.t, input :: get_policy_version_request) :: ExAws.Request.Query.success_t | no_return
  def get_policy_version!(client, input) do
    case get_policy_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetRole

  Retrieves information about the specified role, including the role's path,
  GUID, ARN, and the policy granting permission to assume the role. For more
  information about ARNs, go to
  [ARNs](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html#Identifiers_ARNs).
  For more information about roles, go to [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).
  """

  @spec get_role(client :: ExAws.Iam.t, input :: get_role_request) :: ExAws.Request.Query.response_t
  def get_role(client, input) do
    request(client, "/", "GetRole", input)
  end

  @doc """
  Same as `get_role/2` but raise on error.
  """
  @spec get_role!(client :: ExAws.Iam.t, input :: get_role_request) :: ExAws.Request.Query.success_t | no_return
  def get_role!(client, input) do
    case get_role(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetRolePolicy

  Retrieves the specified inline policy document that is embedded with the
  specified role.

  A role can also have managed policies attached to it. To retrieve a managed
  policy document that is attached to a role, use `GetPolicy` to determine
  the policy's default version, then use `GetPolicyVersion` to retrieve the
  policy document.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  For more information about roles, go to [Using Roles to Delegate
  Permissions and Federate
  Identities](http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html).
  """

  @spec get_role_policy(client :: ExAws.Iam.t, input :: get_role_policy_request) :: ExAws.Request.Query.response_t
  def get_role_policy(client, input) do
    request(client, "/", "GetRolePolicy", input)
  end

  @doc """
  Same as `get_role_policy/2` but raise on error.
  """
  @spec get_role_policy!(client :: ExAws.Iam.t, input :: get_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def get_role_policy!(client, input) do
    case get_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSAMLProvider

  Returns the SAML provider metadocument that was uploaded when the provider
  was created or updated.

  Note:This operation requires [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  """

  @spec get_saml_provider(client :: ExAws.Iam.t, input :: get_saml_provider_request) :: ExAws.Request.Query.response_t
  def get_saml_provider(client, input) do
    request(client, "/", "GetSAMLProvider", input)
  end

  @doc """
  Same as `get_saml_provider/2` but raise on error.
  """
  @spec get_saml_provider!(client :: ExAws.Iam.t, input :: get_saml_provider_request) :: ExAws.Request.Query.success_t | no_return
  def get_saml_provider!(client, input) do
    case get_saml_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSSHPublicKey

  Retrieves the specified SSH public key, including metadata about the key.

  The SSH public key retrieved by this action is used only for authenticating
  the associated IAM user to an AWS CodeCommit repository. For more
  information about using SSH keys to authenticate to an AWS CodeCommit
  repository, see [Set up AWS CodeCommit for SSH
  Connections](http://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html)
  in the *AWS CodeCommit User Guide*.
  """

  @spec get_ssh_public_key(client :: ExAws.Iam.t, input :: get_ssh_public_key_request) :: ExAws.Request.Query.response_t
  def get_ssh_public_key(client, input) do
    request(client, "/", "GetSSHPublicKey", input)
  end

  @doc """
  Same as `get_ssh_public_key/2` but raise on error.
  """
  @spec get_ssh_public_key!(client :: ExAws.Iam.t, input :: get_ssh_public_key_request) :: ExAws.Request.Query.success_t | no_return
  def get_ssh_public_key!(client, input) do
    case get_ssh_public_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetServerCertificate

  Retrieves information about the specified server certificate.
  """

  @spec get_server_certificate(client :: ExAws.Iam.t, input :: get_server_certificate_request) :: ExAws.Request.Query.response_t
  def get_server_certificate(client, input) do
    request(client, "/", "GetServerCertificate", input)
  end

  @doc """
  Same as `get_server_certificate/2` but raise on error.
  """
  @spec get_server_certificate!(client :: ExAws.Iam.t, input :: get_server_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def get_server_certificate!(client, input) do
    case get_server_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetUser

  Retrieves information about the specified user, including the user's
  creation date, path, unique ID, and ARN.

  If you do not specify a user name, IAM determines the user name implicitly
  based on the AWS access key ID used to sign the request.
  """

  @spec get_user(client :: ExAws.Iam.t, input :: get_user_request) :: ExAws.Request.Query.response_t
  def get_user(client, input) do
    request(client, "/", "GetUser", input)
  end

  @doc """
  Same as `get_user/2` but raise on error.
  """
  @spec get_user!(client :: ExAws.Iam.t, input :: get_user_request) :: ExAws.Request.Query.success_t | no_return
  def get_user!(client, input) do
    case get_user(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetUserPolicy

  Retrieves the specified inline policy document that is embedded in the
  specified user.

  A user can also have managed policies attached to it. To retrieve a managed
  policy document that is attached to a user, use `GetPolicy` to determine
  the policy's default version, then use `GetPolicyVersion` to retrieve the
  policy document.

  For more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec get_user_policy(client :: ExAws.Iam.t, input :: get_user_policy_request) :: ExAws.Request.Query.response_t
  def get_user_policy(client, input) do
    request(client, "/", "GetUserPolicy", input)
  end

  @doc """
  Same as `get_user_policy/2` but raise on error.
  """
  @spec get_user_policy!(client :: ExAws.Iam.t, input :: get_user_policy_request) :: ExAws.Request.Query.success_t | no_return
  def get_user_policy!(client, input) do
    case get_user_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAccessKeys

  Returns information about the access key IDs associated with the specified
  user. If there are none, the action returns an empty list.

  Although each user is limited to a small number of keys, you can still
  paginate the results using the `MaxItems` and `Marker` parameters.

  If the `UserName` field is not specified, the UserName is determined
  implicitly based on the AWS access key ID used to sign the request. Because
  this action works for access keys under the AWS account, you can use this
  action to manage root credentials even if the AWS account has no associated
  users.

  Note:To ensure the security of your AWS account, the secret access key is
  accessible only during key and user creation.
  """

  @spec list_access_keys(client :: ExAws.Iam.t, input :: list_access_keys_request) :: ExAws.Request.Query.response_t
  def list_access_keys(client, input) do
    request(client, "/", "ListAccessKeys", input)
  end

  @doc """
  Same as `list_access_keys/2` but raise on error.
  """
  @spec list_access_keys!(client :: ExAws.Iam.t, input :: list_access_keys_request) :: ExAws.Request.Query.success_t | no_return
  def list_access_keys!(client, input) do
    case list_access_keys(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAccountAliases

  Lists the account aliases associated with the account. For information
  about using an AWS account alias, see [Using an Alias for Your AWS Account
  ID](http://docs.aws.amazon.com/IAM/latest/UserGuide/AccountAlias.html) in
  the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_account_aliases(client :: ExAws.Iam.t, input :: list_account_aliases_request) :: ExAws.Request.Query.response_t
  def list_account_aliases(client, input) do
    request(client, "/", "ListAccountAliases", input)
  end

  @doc """
  Same as `list_account_aliases/2` but raise on error.
  """
  @spec list_account_aliases!(client :: ExAws.Iam.t, input :: list_account_aliases_request) :: ExAws.Request.Query.success_t | no_return
  def list_account_aliases!(client, input) do
    case list_account_aliases(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAttachedGroupPolicies

  Lists all managed policies that are attached to the specified group.

  A group can also have inline policies embedded with it. To list the inline
  policies for a group, use the `ListGroupPolicies` API. For information
  about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  You can use the `PathPrefix` parameter to limit the list of policies to
  only those matching the specified path prefix. If there are no policies
  attached to the specified group (or none that match the specified path
  prefix), the action returns an empty list.
  """

  @spec list_attached_group_policies(client :: ExAws.Iam.t, input :: list_attached_group_policies_request) :: ExAws.Request.Query.response_t
  def list_attached_group_policies(client, input) do
    request(client, "/", "ListAttachedGroupPolicies", input)
  end

  @doc """
  Same as `list_attached_group_policies/2` but raise on error.
  """
  @spec list_attached_group_policies!(client :: ExAws.Iam.t, input :: list_attached_group_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_attached_group_policies!(client, input) do
    case list_attached_group_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAttachedRolePolicies

  Lists all managed policies that are attached to the specified role.

  A role can also have inline policies embedded with it. To list the inline
  policies for a role, use the `ListRolePolicies` API. For information about
  policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  You can use the `PathPrefix` parameter to limit the list of policies to
  only those matching the specified path prefix. If there are no policies
  attached to the specified role (or none that match the specified path
  prefix), the action returns an empty list.
  """

  @spec list_attached_role_policies(client :: ExAws.Iam.t, input :: list_attached_role_policies_request) :: ExAws.Request.Query.response_t
  def list_attached_role_policies(client, input) do
    request(client, "/", "ListAttachedRolePolicies", input)
  end

  @doc """
  Same as `list_attached_role_policies/2` but raise on error.
  """
  @spec list_attached_role_policies!(client :: ExAws.Iam.t, input :: list_attached_role_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_attached_role_policies!(client, input) do
    case list_attached_role_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAttachedUserPolicies

  Lists all managed policies that are attached to the specified user.

  A user can also have inline policies embedded with it. To list the inline
  policies for a user, use the `ListUserPolicies` API. For information about
  policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  You can use the `PathPrefix` parameter to limit the list of policies to
  only those matching the specified path prefix. If there are no policies
  attached to the specified group (or none that match the specified path
  prefix), the action returns an empty list.
  """

  @spec list_attached_user_policies(client :: ExAws.Iam.t, input :: list_attached_user_policies_request) :: ExAws.Request.Query.response_t
  def list_attached_user_policies(client, input) do
    request(client, "/", "ListAttachedUserPolicies", input)
  end

  @doc """
  Same as `list_attached_user_policies/2` but raise on error.
  """
  @spec list_attached_user_policies!(client :: ExAws.Iam.t, input :: list_attached_user_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_attached_user_policies!(client, input) do
    case list_attached_user_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListEntitiesForPolicy

  Lists all users, groups, and roles that the specified managed policy is
  attached to.

  You can use the optional `EntityFilter` parameter to limit the results to a
  particular type of entity (users, groups, or roles). For example, to list
  only the roles that are attached to the specified policy, set
  `EntityFilter` to `Role`.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_entities_for_policy(client :: ExAws.Iam.t, input :: list_entities_for_policy_request) :: ExAws.Request.Query.response_t
  def list_entities_for_policy(client, input) do
    request(client, "/", "ListEntitiesForPolicy", input)
  end

  @doc """
  Same as `list_entities_for_policy/2` but raise on error.
  """
  @spec list_entities_for_policy!(client :: ExAws.Iam.t, input :: list_entities_for_policy_request) :: ExAws.Request.Query.success_t | no_return
  def list_entities_for_policy!(client, input) do
    case list_entities_for_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListGroupPolicies

  Lists the names of the inline policies that are embedded in the specified
  group.

  A group can also have managed policies attached to it. To list the managed
  policies that are attached to a group, use `ListAttachedGroupPolicies`. For
  more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  If there are no inline policies embedded with the specified group, the
  action returns an empty list.
  """

  @spec list_group_policies(client :: ExAws.Iam.t, input :: list_group_policies_request) :: ExAws.Request.Query.response_t
  def list_group_policies(client, input) do
    request(client, "/", "ListGroupPolicies", input)
  end

  @doc """
  Same as `list_group_policies/2` but raise on error.
  """
  @spec list_group_policies!(client :: ExAws.Iam.t, input :: list_group_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_group_policies!(client, input) do
    case list_group_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListGroups

  Lists the groups that have the specified path prefix.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_groups(client :: ExAws.Iam.t, input :: list_groups_request) :: ExAws.Request.Query.response_t
  def list_groups(client, input) do
    request(client, "/", "ListGroups", input)
  end

  @doc """
  Same as `list_groups/2` but raise on error.
  """
  @spec list_groups!(client :: ExAws.Iam.t, input :: list_groups_request) :: ExAws.Request.Query.success_t | no_return
  def list_groups!(client, input) do
    case list_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListGroupsForUser

  Lists the groups the specified user belongs to.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_groups_for_user(client :: ExAws.Iam.t, input :: list_groups_for_user_request) :: ExAws.Request.Query.response_t
  def list_groups_for_user(client, input) do
    request(client, "/", "ListGroupsForUser", input)
  end

  @doc """
  Same as `list_groups_for_user/2` but raise on error.
  """
  @spec list_groups_for_user!(client :: ExAws.Iam.t, input :: list_groups_for_user_request) :: ExAws.Request.Query.success_t | no_return
  def list_groups_for_user!(client, input) do
    case list_groups_for_user(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListInstanceProfiles

  Lists the instance profiles that have the specified path prefix. If there
  are none, the action returns an empty list. For more information about
  instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_instance_profiles(client :: ExAws.Iam.t, input :: list_instance_profiles_request) :: ExAws.Request.Query.response_t
  def list_instance_profiles(client, input) do
    request(client, "/", "ListInstanceProfiles", input)
  end

  @doc """
  Same as `list_instance_profiles/2` but raise on error.
  """
  @spec list_instance_profiles!(client :: ExAws.Iam.t, input :: list_instance_profiles_request) :: ExAws.Request.Query.success_t | no_return
  def list_instance_profiles!(client, input) do
    case list_instance_profiles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListInstanceProfilesForRole

  Lists the instance profiles that have the specified associated role. If
  there are none, the action returns an empty list. For more information
  about instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_instance_profiles_for_role(client :: ExAws.Iam.t, input :: list_instance_profiles_for_role_request) :: ExAws.Request.Query.response_t
  def list_instance_profiles_for_role(client, input) do
    request(client, "/", "ListInstanceProfilesForRole", input)
  end

  @doc """
  Same as `list_instance_profiles_for_role/2` but raise on error.
  """
  @spec list_instance_profiles_for_role!(client :: ExAws.Iam.t, input :: list_instance_profiles_for_role_request) :: ExAws.Request.Query.success_t | no_return
  def list_instance_profiles_for_role!(client, input) do
    case list_instance_profiles_for_role(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListMFADevices

  Lists the MFA devices. If the request includes the user name, then this
  action lists all the MFA devices associated with the specified user name.
  If you do not specify a user name, IAM determines the user name implicitly
  based on the AWS access key ID signing the request.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_mfa_devices(client :: ExAws.Iam.t, input :: list_mfa_devices_request) :: ExAws.Request.Query.response_t
  def list_mfa_devices(client, input) do
    request(client, "/", "ListMFADevices", input)
  end

  @doc """
  Same as `list_mfa_devices/2` but raise on error.
  """
  @spec list_mfa_devices!(client :: ExAws.Iam.t, input :: list_mfa_devices_request) :: ExAws.Request.Query.success_t | no_return
  def list_mfa_devices!(client, input) do
    case list_mfa_devices(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListOpenIDConnectProviders

  Lists information about the OpenID Connect providers in the AWS account.
  """

  @spec list_open_id_connect_providers(client :: ExAws.Iam.t, input :: list_open_id_connect_providers_request) :: ExAws.Request.Query.response_t
  def list_open_id_connect_providers(client, input) do
    request(client, "/", "ListOpenIDConnectProviders", input)
  end

  @doc """
  Same as `list_open_id_connect_providers/2` but raise on error.
  """
  @spec list_open_id_connect_providers!(client :: ExAws.Iam.t, input :: list_open_id_connect_providers_request) :: ExAws.Request.Query.success_t | no_return
  def list_open_id_connect_providers!(client, input) do
    case list_open_id_connect_providers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListPolicies

  Lists all the managed policies that are available to your account,
  including your own customer managed policies and all AWS managed policies.

  You can filter the list of policies that is returned using the optional
  `OnlyAttached`, `Scope`, and `PathPrefix` parameters. For example, to list
  only the customer managed policies in your AWS account, set `Scope` to
  `Local`. To list only AWS managed policies, set `Scope` to `AWS`.

  You can paginate the results using the `MaxItems` and `Marker` parameters.

  For more information about managed policies, refer to [Managed Policies and
  Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec list_policies(client :: ExAws.Iam.t, input :: list_policies_request) :: ExAws.Request.Query.response_t
  def list_policies(client, input) do
    request(client, "/", "ListPolicies", input)
  end

  @doc """
  Same as `list_policies/2` but raise on error.
  """
  @spec list_policies!(client :: ExAws.Iam.t, input :: list_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_policies!(client, input) do
    case list_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListPolicyVersions

  Lists information about the versions of the specified managed policy,
  including the version that is set as the policy's default version.

  For more information about managed policies, refer to [Managed Policies and
  Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec list_policy_versions(client :: ExAws.Iam.t, input :: list_policy_versions_request) :: ExAws.Request.Query.response_t
  def list_policy_versions(client, input) do
    request(client, "/", "ListPolicyVersions", input)
  end

  @doc """
  Same as `list_policy_versions/2` but raise on error.
  """
  @spec list_policy_versions!(client :: ExAws.Iam.t, input :: list_policy_versions_request) :: ExAws.Request.Query.success_t | no_return
  def list_policy_versions!(client, input) do
    case list_policy_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListRolePolicies

  Lists the names of the inline policies that are embedded in the specified
  role.

  A role can also have managed policies attached to it. To list the managed
  policies that are attached to a role, use `ListAttachedRolePolicies`. For
  more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  If there are no inline policies embedded with the specified role, the
  action returns an empty list.
  """

  @spec list_role_policies(client :: ExAws.Iam.t, input :: list_role_policies_request) :: ExAws.Request.Query.response_t
  def list_role_policies(client, input) do
    request(client, "/", "ListRolePolicies", input)
  end

  @doc """
  Same as `list_role_policies/2` but raise on error.
  """
  @spec list_role_policies!(client :: ExAws.Iam.t, input :: list_role_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_role_policies!(client, input) do
    case list_role_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListRoles

  Lists the roles that have the specified path prefix. If there are none, the
  action returns an empty list. For more information about roles, go to
  [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_roles(client :: ExAws.Iam.t, input :: list_roles_request) :: ExAws.Request.Query.response_t
  def list_roles(client, input) do
    request(client, "/", "ListRoles", input)
  end

  @doc """
  Same as `list_roles/2` but raise on error.
  """
  @spec list_roles!(client :: ExAws.Iam.t, input :: list_roles_request) :: ExAws.Request.Query.success_t | no_return
  def list_roles!(client, input) do
    case list_roles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSAMLProviders

  Lists the SAML providers in the account.

  Note: This operation requires [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  """

  @spec list_saml_providers(client :: ExAws.Iam.t, input :: list_saml_providers_request) :: ExAws.Request.Query.response_t
  def list_saml_providers(client, input) do
    request(client, "/", "ListSAMLProviders", input)
  end

  @doc """
  Same as `list_saml_providers/2` but raise on error.
  """
  @spec list_saml_providers!(client :: ExAws.Iam.t, input :: list_saml_providers_request) :: ExAws.Request.Query.success_t | no_return
  def list_saml_providers!(client, input) do
    case list_saml_providers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSSHPublicKeys

  Returns information about the SSH public keys associated with the specified
  IAM user. If there are none, the action returns an empty list.

  The SSH public keys returned by this action are used only for
  authenticating the IAM user to an AWS CodeCommit repository. For more
  information about using SSH keys to authenticate to an AWS CodeCommit
  repository, see [Set up AWS CodeCommit for SSH
  Connections](http://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html)
  in the *AWS CodeCommit User Guide*.

  Although each user is limited to a small number of keys, you can still
  paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_ssh_public_keys(client :: ExAws.Iam.t, input :: list_ssh_public_keys_request) :: ExAws.Request.Query.response_t
  def list_ssh_public_keys(client, input) do
    request(client, "/", "ListSSHPublicKeys", input)
  end

  @doc """
  Same as `list_ssh_public_keys/2` but raise on error.
  """
  @spec list_ssh_public_keys!(client :: ExAws.Iam.t, input :: list_ssh_public_keys_request) :: ExAws.Request.Query.success_t | no_return
  def list_ssh_public_keys!(client, input) do
    case list_ssh_public_keys(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListServerCertificates

  Lists the server certificates that have the specified path prefix. If none
  exist, the action returns an empty list.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_server_certificates(client :: ExAws.Iam.t, input :: list_server_certificates_request) :: ExAws.Request.Query.response_t
  def list_server_certificates(client, input) do
    request(client, "/", "ListServerCertificates", input)
  end

  @doc """
  Same as `list_server_certificates/2` but raise on error.
  """
  @spec list_server_certificates!(client :: ExAws.Iam.t, input :: list_server_certificates_request) :: ExAws.Request.Query.success_t | no_return
  def list_server_certificates!(client, input) do
    case list_server_certificates(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSigningCertificates

  Returns information about the signing certificates associated with the
  specified user. If there are none, the action returns an empty list.

  Although each user is limited to a small number of signing certificates,
  you can still paginate the results using the `MaxItems` and `Marker`
  parameters.

  If the `UserName` field is not specified, the user name is determined
  implicitly based on the AWS access key ID used to sign the request. Because
  this action works for access keys under the AWS account, you can use this
  action to manage root credentials even if the AWS account has no associated
  users.
  """

  @spec list_signing_certificates(client :: ExAws.Iam.t, input :: list_signing_certificates_request) :: ExAws.Request.Query.response_t
  def list_signing_certificates(client, input) do
    request(client, "/", "ListSigningCertificates", input)
  end

  @doc """
  Same as `list_signing_certificates/2` but raise on error.
  """
  @spec list_signing_certificates!(client :: ExAws.Iam.t, input :: list_signing_certificates_request) :: ExAws.Request.Query.success_t | no_return
  def list_signing_certificates!(client, input) do
    case list_signing_certificates(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListUserPolicies

  Lists the names of the inline policies embedded in the specified user.

  A user can also have managed policies attached to it. To list the managed
  policies that are attached to a user, use `ListAttachedUserPolicies`. For
  more information about policies, refer to [Managed Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  If there are no inline policies embedded with the specified user, the
  action returns an empty list.
  """

  @spec list_user_policies(client :: ExAws.Iam.t, input :: list_user_policies_request) :: ExAws.Request.Query.response_t
  def list_user_policies(client, input) do
    request(client, "/", "ListUserPolicies", input)
  end

  @doc """
  Same as `list_user_policies/2` but raise on error.
  """
  @spec list_user_policies!(client :: ExAws.Iam.t, input :: list_user_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_user_policies!(client, input) do
    case list_user_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListUsers

  Lists the IAM users that have the specified path prefix. If no path prefix
  is specified, the action returns all users in the AWS account. If there are
  none, the action returns an empty list.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_users(client :: ExAws.Iam.t, input :: list_users_request) :: ExAws.Request.Query.response_t
  def list_users(client, input) do
    request(client, "/", "ListUsers", input)
  end

  @doc """
  Same as `list_users/2` but raise on error.
  """
  @spec list_users!(client :: ExAws.Iam.t, input :: list_users_request) :: ExAws.Request.Query.success_t | no_return
  def list_users!(client, input) do
    case list_users(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListVirtualMFADevices

  Lists the virtual MFA devices under the AWS account by assignment status.
  If you do not specify an assignment status, the action returns a list of
  all virtual MFA devices. Assignment status can be `Assigned`, `Unassigned`,
  or `Any`.

  You can paginate the results using the `MaxItems` and `Marker` parameters.
  """

  @spec list_virtual_mfa_devices(client :: ExAws.Iam.t, input :: list_virtual_mfa_devices_request) :: ExAws.Request.Query.response_t
  def list_virtual_mfa_devices(client, input) do
    request(client, "/", "ListVirtualMFADevices", input)
  end

  @doc """
  Same as `list_virtual_mfa_devices/2` but raise on error.
  """
  @spec list_virtual_mfa_devices!(client :: ExAws.Iam.t, input :: list_virtual_mfa_devices_request) :: ExAws.Request.Query.success_t | no_return
  def list_virtual_mfa_devices!(client, input) do
    case list_virtual_mfa_devices(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutGroupPolicy

  Adds (or updates) an inline policy document that is embedded in the
  specified group.

  A user can also have managed policies attached to it. To attach a managed
  policy to a group, use `AttachGroupPolicy`. To create a new managed policy,
  use `CreatePolicy`. For information about policies, refer to [Managed
  Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  For information about limits on the number of inline policies that you can
  embed in a group, see [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  Note:Because policy documents can be large, you should use POST rather than
  GET when calling `PutGroupPolicy`. For general information about using the
  Query API with IAM, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM* guide.
  """

  @spec put_group_policy(client :: ExAws.Iam.t, input :: put_group_policy_request) :: ExAws.Request.Query.response_t
  def put_group_policy(client, input) do
    request(client, "/", "PutGroupPolicy", input)
  end

  @doc """
  Same as `put_group_policy/2` but raise on error.
  """
  @spec put_group_policy!(client :: ExAws.Iam.t, input :: put_group_policy_request) :: ExAws.Request.Query.success_t | no_return
  def put_group_policy!(client, input) do
    case put_group_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutRolePolicy

  Adds (or updates) an inline policy document that is embedded in the
  specified role.

  When you embed an inline policy in a role, the inline policy is used as the
  role's access (permissions) policy. The role's trust policy is created at
  the same time as the role, using `CreateRole`. You can update a role's
  trust policy using `UpdateAssumeRolePolicy`. For more information about
  roles, go to [Using Roles to Delegate Permissions and Federate
  Identities](http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html).

  A role can also have a managed policy attached to it. To attach a managed
  policy to a role, use `AttachRolePolicy`. To create a new managed policy,
  use `CreatePolicy`. For information about policies, refer to [Managed
  Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  For information about limits on the number of inline policies that you can
  embed with a role, see [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  Note:Because policy documents can be large, you should use POST rather than
  GET when calling `PutRolePolicy`. For general information about using the
  Query API with IAM, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM* guide.
  """

  @spec put_role_policy(client :: ExAws.Iam.t, input :: put_role_policy_request) :: ExAws.Request.Query.response_t
  def put_role_policy(client, input) do
    request(client, "/", "PutRolePolicy", input)
  end

  @doc """
  Same as `put_role_policy/2` but raise on error.
  """
  @spec put_role_policy!(client :: ExAws.Iam.t, input :: put_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def put_role_policy!(client, input) do
    case put_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutUserPolicy

  Adds (or updates) an inline policy document that is embedded in the
  specified user.

  A user can also have a managed policy attached to it. To attach a managed
  policy to a user, use `AttachUserPolicy`. To create a new managed policy,
  use `CreatePolicy`. For information about policies, refer to [Managed
  Policies and Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.

  For information about limits on the number of inline policies that you can
  embed in a user, see [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  Note:Because policy documents can be large, you should use POST rather than
  GET when calling `PutUserPolicy`. For general information about using the
  Query API with IAM, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM* guide.
  """

  @spec put_user_policy(client :: ExAws.Iam.t, input :: put_user_policy_request) :: ExAws.Request.Query.response_t
  def put_user_policy(client, input) do
    request(client, "/", "PutUserPolicy", input)
  end

  @doc """
  Same as `put_user_policy/2` but raise on error.
  """
  @spec put_user_policy!(client :: ExAws.Iam.t, input :: put_user_policy_request) :: ExAws.Request.Query.success_t | no_return
  def put_user_policy!(client, input) do
    case put_user_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveClientIDFromOpenIDConnectProvider

  Removes the specified client ID (also known as audience) from the list of
  client IDs registered for the specified IAM OpenID Connect provider.

  This action is idempotent; it does not fail or return an error if you try
  to remove a client ID that was removed previously.
  """

  @spec remove_client_id_from_open_id_connect_provider(client :: ExAws.Iam.t, input :: remove_client_id_from_open_id_connect_provider_request) :: ExAws.Request.Query.response_t
  def remove_client_id_from_open_id_connect_provider(client, input) do
    request(client, "/", "RemoveClientIDFromOpenIDConnectProvider", input)
  end

  @doc """
  Same as `remove_client_id_from_open_id_connect_provider/2` but raise on error.
  """
  @spec remove_client_id_from_open_id_connect_provider!(client :: ExAws.Iam.t, input :: remove_client_id_from_open_id_connect_provider_request) :: ExAws.Request.Query.success_t | no_return
  def remove_client_id_from_open_id_connect_provider!(client, input) do
    case remove_client_id_from_open_id_connect_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveRoleFromInstanceProfile

  Removes the specified role from the specified instance profile.

  ** Make sure you do not have any Amazon EC2 instances running with the role
  you are about to remove from the instance profile. Removing a role from an
  instance profile that is associated with a running instance will break any
  applications running on the instance. ** For more information about roles,
  go to [Working with
  Roles](http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html).
  For more information about instance profiles, go to [About Instance
  Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/AboutInstanceProfiles.html).
  """

  @spec remove_role_from_instance_profile(client :: ExAws.Iam.t, input :: remove_role_from_instance_profile_request) :: ExAws.Request.Query.response_t
  def remove_role_from_instance_profile(client, input) do
    request(client, "/", "RemoveRoleFromInstanceProfile", input)
  end

  @doc """
  Same as `remove_role_from_instance_profile/2` but raise on error.
  """
  @spec remove_role_from_instance_profile!(client :: ExAws.Iam.t, input :: remove_role_from_instance_profile_request) :: ExAws.Request.Query.success_t | no_return
  def remove_role_from_instance_profile!(client, input) do
    case remove_role_from_instance_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveUserFromGroup

  Removes the specified user from the specified group.
  """

  @spec remove_user_from_group(client :: ExAws.Iam.t, input :: remove_user_from_group_request) :: ExAws.Request.Query.response_t
  def remove_user_from_group(client, input) do
    request(client, "/", "RemoveUserFromGroup", input)
  end

  @doc """
  Same as `remove_user_from_group/2` but raise on error.
  """
  @spec remove_user_from_group!(client :: ExAws.Iam.t, input :: remove_user_from_group_request) :: ExAws.Request.Query.success_t | no_return
  def remove_user_from_group!(client, input) do
    case remove_user_from_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResyncMFADevice

  Synchronizes the specified MFA device with AWS servers.

  For more information about creating and working with virtual MFA devices,
  go to [Using a Virtual MFA
  Device](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html)
  in the *Using IAM* guide.
  """

  @spec resync_mfa_device(client :: ExAws.Iam.t, input :: resync_mfa_device_request) :: ExAws.Request.Query.response_t
  def resync_mfa_device(client, input) do
    request(client, "/", "ResyncMFADevice", input)
  end

  @doc """
  Same as `resync_mfa_device/2` but raise on error.
  """
  @spec resync_mfa_device!(client :: ExAws.Iam.t, input :: resync_mfa_device_request) :: ExAws.Request.Query.success_t | no_return
  def resync_mfa_device!(client, input) do
    case resync_mfa_device(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetDefaultPolicyVersion

  Sets the specified version of the specified policy as the policy's default
  (operative) version.

  This action affects all users, groups, and roles that the policy is
  attached to. To list the users, groups, and roles that the policy is
  attached to, use the `ListEntitiesForPolicy` API.

  For information about managed policies, refer to [Managed Policies and
  Inline
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html)
  in the *Using IAM* guide.
  """

  @spec set_default_policy_version(client :: ExAws.Iam.t, input :: set_default_policy_version_request) :: ExAws.Request.Query.response_t
  def set_default_policy_version(client, input) do
    request(client, "/", "SetDefaultPolicyVersion", input)
  end

  @doc """
  Same as `set_default_policy_version/2` but raise on error.
  """
  @spec set_default_policy_version!(client :: ExAws.Iam.t, input :: set_default_policy_version_request) :: ExAws.Request.Query.success_t | no_return
  def set_default_policy_version!(client, input) do
    case set_default_policy_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAccessKey

  Changes the status of the specified access key from Active to Inactive, or
  vice versa. This action can be used to disable a user's key as part of a
  key rotation work flow.

  If the `UserName` field is not specified, the UserName is determined
  implicitly based on the AWS access key ID used to sign the request. Because
  this action works for access keys under the AWS account, you can use this
  action to manage root credentials even if the AWS account has no associated
  users.

  For information about rotating keys, see [Managing Keys and
  Certificates](http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingCredentials.html)
  in the *Using IAM* guide.
  """

  @spec update_access_key(client :: ExAws.Iam.t, input :: update_access_key_request) :: ExAws.Request.Query.response_t
  def update_access_key(client, input) do
    request(client, "/", "UpdateAccessKey", input)
  end

  @doc """
  Same as `update_access_key/2` but raise on error.
  """
  @spec update_access_key!(client :: ExAws.Iam.t, input :: update_access_key_request) :: ExAws.Request.Query.success_t | no_return
  def update_access_key!(client, input) do
    case update_access_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAccountPasswordPolicy

  Updates the password policy settings for the AWS account.

  Note: This action does not support partial updates. No parameters are
  required, but if you do not specify a parameter, that parameter's value
  reverts to its default value. See the **Request Parameters** section for
  each parameter's default value.

  For more information about using a password policy, see [Managing an IAM
  Password
  Policy](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html)
  in the *Using IAM* guide.
  """

  @spec update_account_password_policy(client :: ExAws.Iam.t, input :: update_account_password_policy_request) :: ExAws.Request.Query.response_t
  def update_account_password_policy(client, input) do
    request(client, "/", "UpdateAccountPasswordPolicy", input)
  end

  @doc """
  Same as `update_account_password_policy/2` but raise on error.
  """
  @spec update_account_password_policy!(client :: ExAws.Iam.t, input :: update_account_password_policy_request) :: ExAws.Request.Query.success_t | no_return
  def update_account_password_policy!(client, input) do
    case update_account_password_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAssumeRolePolicy

  Updates the policy that grants an entity permission to assume a role. For
  more information about roles, go to [Using Roles to Delegate Permissions
  and Federate
  Identities](http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html).
  """

  @spec update_assume_role_policy(client :: ExAws.Iam.t, input :: update_assume_role_policy_request) :: ExAws.Request.Query.response_t
  def update_assume_role_policy(client, input) do
    request(client, "/", "UpdateAssumeRolePolicy", input)
  end

  @doc """
  Same as `update_assume_role_policy/2` but raise on error.
  """
  @spec update_assume_role_policy!(client :: ExAws.Iam.t, input :: update_assume_role_policy_request) :: ExAws.Request.Query.success_t | no_return
  def update_assume_role_policy!(client, input) do
    case update_assume_role_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateGroup

  Updates the name and/or the path of the specified group.

  ** You should understand the implications of changing a group's path or
  name. For more information, see [Renaming Users and
  Groups](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_WorkingWithGroupsAndUsers.html)
  in the *Using IAM* guide. ** Note:To change a group name the requester must
  have appropriate permissions on both the source object and the target
  object. For example, to change Managers to MGRs, the entity making the
  request must have permission on Managers and MGRs, or must have permission
  on all (*). For more information about permissions, see [Permissions and
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html"
  target="blank).
  """

  @spec update_group(client :: ExAws.Iam.t, input :: update_group_request) :: ExAws.Request.Query.response_t
  def update_group(client, input) do
    request(client, "/", "UpdateGroup", input)
  end

  @doc """
  Same as `update_group/2` but raise on error.
  """
  @spec update_group!(client :: ExAws.Iam.t, input :: update_group_request) :: ExAws.Request.Query.success_t | no_return
  def update_group!(client, input) do
    case update_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateLoginProfile

  Changes the password for the specified user.

  Users can change their own passwords by calling `ChangePassword`. For more
  information about modifying passwords, see [Managing
  Passwords](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html)
  in the *Using IAM* guide.
  """

  @spec update_login_profile(client :: ExAws.Iam.t, input :: update_login_profile_request) :: ExAws.Request.Query.response_t
  def update_login_profile(client, input) do
    request(client, "/", "UpdateLoginProfile", input)
  end

  @doc """
  Same as `update_login_profile/2` but raise on error.
  """
  @spec update_login_profile!(client :: ExAws.Iam.t, input :: update_login_profile_request) :: ExAws.Request.Query.success_t | no_return
  def update_login_profile!(client, input) do
    case update_login_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateOpenIDConnectProviderThumbprint

  Replaces the existing list of server certificate thumbprints with a new
  list.

  The list that you pass with this action completely replaces the existing
  list of thumbprints. (The lists are not merged.)

  Typically, you need to update a thumbprint only when the identity
  provider's certificate changes, which occurs rarely. However, if the
  provider's certificate *does* change, any attempt to assume an IAM role
  that specifies the OIDC provider as a principal will fail until the
  certificate thumbprint is updated.

  Note:Because trust for the OpenID Connect provider is ultimately derived
  from the provider's certificate and is validated by the thumbprint, it is a
  best practice to limit access to the
  `UpdateOpenIDConnectProviderThumbprint` action to highly-privileged users.
  """

  @spec update_open_id_connect_provider_thumbprint(client :: ExAws.Iam.t, input :: update_open_id_connect_provider_thumbprint_request) :: ExAws.Request.Query.response_t
  def update_open_id_connect_provider_thumbprint(client, input) do
    request(client, "/", "UpdateOpenIDConnectProviderThumbprint", input)
  end

  @doc """
  Same as `update_open_id_connect_provider_thumbprint/2` but raise on error.
  """
  @spec update_open_id_connect_provider_thumbprint!(client :: ExAws.Iam.t, input :: update_open_id_connect_provider_thumbprint_request) :: ExAws.Request.Query.success_t | no_return
  def update_open_id_connect_provider_thumbprint!(client, input) do
    case update_open_id_connect_provider_thumbprint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateSAMLProvider

  Updates the metadata document for an existing SAML provider.

  Note:This operation requires [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
  """

  @spec update_saml_provider(client :: ExAws.Iam.t, input :: update_saml_provider_request) :: ExAws.Request.Query.response_t
  def update_saml_provider(client, input) do
    request(client, "/", "UpdateSAMLProvider", input)
  end

  @doc """
  Same as `update_saml_provider/2` but raise on error.
  """
  @spec update_saml_provider!(client :: ExAws.Iam.t, input :: update_saml_provider_request) :: ExAws.Request.Query.success_t | no_return
  def update_saml_provider!(client, input) do
    case update_saml_provider(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateSSHPublicKey

  Sets the status of the specified SSH public key to active or inactive. SSH
  public keys that are inactive cannot be used for authentication. This
  action can be used to disable a user's SSH public key as part of a key
  rotation work flow.

  The SSH public key affected by this action is used only for authenticating
  the associated IAM user to an AWS CodeCommit repository. For more
  information about using SSH keys to authenticate to an AWS CodeCommit
  repository, see [Set up AWS CodeCommit for SSH
  Connections](http://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html)
  in the *AWS CodeCommit User Guide*.
  """

  @spec update_ssh_public_key(client :: ExAws.Iam.t, input :: update_ssh_public_key_request) :: ExAws.Request.Query.response_t
  def update_ssh_public_key(client, input) do
    request(client, "/", "UpdateSSHPublicKey", input)
  end

  @doc """
  Same as `update_ssh_public_key/2` but raise on error.
  """
  @spec update_ssh_public_key!(client :: ExAws.Iam.t, input :: update_ssh_public_key_request) :: ExAws.Request.Query.success_t | no_return
  def update_ssh_public_key!(client, input) do
    case update_ssh_public_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateServerCertificate

  Updates the name and/or the path of the specified server certificate.

  ** You should understand the implications of changing a server
  certificate's path or name. For more information, see [Managing Server
  Certificates](http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingServerCerts.html)
  in the *Using IAM* guide. ** Note:To change a server certificate name the
  requester must have appropriate permissions on both the source object and
  the target object. For example, to change the name from ProductionCert to
  ProdCert, the entity making the request must have permission on
  ProductionCert and ProdCert, or must have permission on all (*). For more
  information about permissions, see [Permissions and
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html"
  target="blank).
  """

  @spec update_server_certificate(client :: ExAws.Iam.t, input :: update_server_certificate_request) :: ExAws.Request.Query.response_t
  def update_server_certificate(client, input) do
    request(client, "/", "UpdateServerCertificate", input)
  end

  @doc """
  Same as `update_server_certificate/2` but raise on error.
  """
  @spec update_server_certificate!(client :: ExAws.Iam.t, input :: update_server_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def update_server_certificate!(client, input) do
    case update_server_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateSigningCertificate

  Changes the status of the specified signing certificate from active to
  disabled, or vice versa. This action can be used to disable a user's
  signing certificate as part of a certificate rotation work flow.

  If the `UserName` field is not specified, the UserName is determined
  implicitly based on the AWS access key ID used to sign the request. Because
  this action works for access keys under the AWS account, you can use this
  action to manage root credentials even if the AWS account has no associated
  users.
  """

  @spec update_signing_certificate(client :: ExAws.Iam.t, input :: update_signing_certificate_request) :: ExAws.Request.Query.response_t
  def update_signing_certificate(client, input) do
    request(client, "/", "UpdateSigningCertificate", input)
  end

  @doc """
  Same as `update_signing_certificate/2` but raise on error.
  """
  @spec update_signing_certificate!(client :: ExAws.Iam.t, input :: update_signing_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def update_signing_certificate!(client, input) do
    case update_signing_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateUser

  Updates the name and/or the path of the specified user.

  ** You should understand the implications of changing a user's path or
  name. For more information, see [Renaming Users and
  Groups](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_WorkingWithGroupsAndUsers.html)
  in the *Using IAM* guide. ** Note: To change a user name the requester must
  have appropriate permissions on both the source object and the target
  object. For example, to change Bob to Robert, the entity making the request
  must have permission on Bob and Robert, or must have permission on all (*).
  For more information about permissions, see [Permissions and
  Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html"
  target="blank).
  """

  @spec update_user(client :: ExAws.Iam.t, input :: update_user_request) :: ExAws.Request.Query.response_t
  def update_user(client, input) do
    request(client, "/", "UpdateUser", input)
  end

  @doc """
  Same as `update_user/2` but raise on error.
  """
  @spec update_user!(client :: ExAws.Iam.t, input :: update_user_request) :: ExAws.Request.Query.success_t | no_return
  def update_user!(client, input) do
    case update_user(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UploadSSHPublicKey

  Uploads an SSH public key and associates it with the specified IAM user.

  The SSH public key uploaded by this action can be used only for
  authenticating the associated IAM user to an AWS CodeCommit repository. For
  more information about using SSH keys to authenticate to an AWS CodeCommit
  repository, see [Set up AWS CodeCommit for SSH
  Connections](http://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html)
  in the *AWS CodeCommit User Guide*.
  """

  @spec upload_ssh_public_key(client :: ExAws.Iam.t, input :: upload_ssh_public_key_request) :: ExAws.Request.Query.response_t
  def upload_ssh_public_key(client, input) do
    request(client, "/", "UploadSSHPublicKey", input)
  end

  @doc """
  Same as `upload_ssh_public_key/2` but raise on error.
  """
  @spec upload_ssh_public_key!(client :: ExAws.Iam.t, input :: upload_ssh_public_key_request) :: ExAws.Request.Query.success_t | no_return
  def upload_ssh_public_key!(client, input) do
    case upload_ssh_public_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UploadServerCertificate

  Uploads a server certificate entity for the AWS account. The server
  certificate entity includes a public key certificate, a private key, and an
  optional certificate chain, which should all be PEM-encoded.

  For information about the number of server certificates you can upload, see
  [Limitations on IAM
  Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/LimitationsOnEntities.html)
  in the *Using IAM* guide.

  Note:Because the body of the public key certificate, private key, and the
  certificate chain can be large, you should use POST rather than GET when
  calling `UploadServerCertificate`. For information about setting up
  signatures and authorization through the API, go to [Signing AWS API
  Requests](http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html)
  in the *AWS General Reference*. For general information about using the
  Query API with IAM, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM* guide.
  """

  @spec upload_server_certificate(client :: ExAws.Iam.t, input :: upload_server_certificate_request) :: ExAws.Request.Query.response_t
  def upload_server_certificate(client, input) do
    request(client, "/", "UploadServerCertificate", input)
  end

  @doc """
  Same as `upload_server_certificate/2` but raise on error.
  """
  @spec upload_server_certificate!(client :: ExAws.Iam.t, input :: upload_server_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def upload_server_certificate!(client, input) do
    case upload_server_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UploadSigningCertificate

  Uploads an X.509 signing certificate and associates it with the specified
  user. Some AWS services use X.509 signing certificates to validate requests
  that are signed with a corresponding private key. When you upload the
  certificate, its default status is `Active`.

  If the `UserName` field is not specified, the user name is determined
  implicitly based on the AWS access key ID used to sign the request. Because
  this action works for access keys under the AWS account, you can use this
  action to manage root credentials even if the AWS account has no associated
  users.

  Note:Because the body of a X.509 certificate can be large, you should use
  POST rather than GET when calling `UploadSigningCertificate`. For
  information about setting up signatures and authorization through the API,
  go to [Signing AWS API
  Requests](http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html)
  in the *AWS General Reference*. For general information about using the
  Query API with IAM, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html)
  in the *Using IAM*guide.
  """

  @spec upload_signing_certificate(client :: ExAws.Iam.t, input :: upload_signing_certificate_request) :: ExAws.Request.Query.response_t
  def upload_signing_certificate(client, input) do
    request(client, "/", "UploadSigningCertificate", input)
  end

  @doc """
  Same as `upload_signing_certificate/2` but raise on error.
  """
  @spec upload_signing_certificate!(client :: ExAws.Iam.t, input :: upload_signing_certificate_request) :: ExAws.Request.Query.success_t | no_return
  def upload_signing_certificate!(client, input) do
    case upload_signing_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
