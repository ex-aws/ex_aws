v2.5.6 (2024-10-21)
- Fix Pinpoint Endpoints

v2.5.5 (2024-09-10)
- Endpoint updates
- Drop support for Elixir 1.12
- Add support for Elixir 1.17
- Add Req request backend
- Stop sending `content-length` header for DELETE and HEAD requests
- Fix handling of `[profile <name>]` blocks in config file
- Update test platform to Ubuntu 24.04

v2.5.4 (2024-06-04)
- Endpoint and region updates
- Add support for Elixir 1.16
- Drop support for Elixir 1.11
- Add support for `sso_session` in `.aws/config`
- Add support for EventBridge Pipes service
- Add support for Pinpoint Mobiletargeting service
- Add docs for running DynamoDB locally
- Allow iodata body in s3 requests

v2.5.3 (2024-03-20)
- Add mappings for Chime

v2.5.2 (2024-03-19)
- Endpoint updates

v2.5.1 (2024-01-11)
- Endpoint updates
- Documentation updates
- Fix request error handling when error type is a proplist
- Fixes to ensure Req and Finch clients return the same success fields as hackney
- Add basic support for Personalise service
- Add basic support for Bedrock service

v2.5.0
- [Breaking] Bump minimum elixir version to 1.11
- Replace retired HTTPotion with Req as default web client
- Endpoint updates

v2.4.4
- Endpoint updates
- Add new endpoints for Chime SDK Media Pipelines API

v2.4.3
- Switch default behaviour of credential refreshing so that it must be explicitly enabled with
`refreshable: true`. Having it as the default behaviour was causing breaking issues with ignoring 
overridesin places they shouldn't have been.
- Update endpoints

v2.4.2
- Add name, request, and response data to telemetry
- Force refresh of auth config during long-running streaming operations to avoid failed auth
- Update endpoints
- Update docs

v2.4.1
- Add support for credentials_process in AWS credentials config
- Service endpoint updates
- Switch to `Config` from `Mix.Config`

v2.4.0
- Increase minimum elixir version to 1.10
- Add `error_parser` field to operations. This may be optionally populated by services which
need to do service-specific error handling prior to falling back to the default ExAws handling.

V2.3.4
- Fix crash in authentication for regions without SSO service (#894)
- Service endpoint updates

v2.3.3
- Imporve resiliency/recovery when authentication token queries fail
- Use `default` profile for `:aws_cli` config when `AWS_PROFILE is undefined
- Include service in telemetry events
- Fix crash generating auth headers for request with empty path

v2.3.2
- Fix type for IMDSv2 header
- Make IMDSv2 optional, with fallback to v1
- Fix spec for `Config.new/2`

v2.3.1
- Support container task role credentials in token provider
- Fix issue with ECS instance meta data introduced in 2.3.0
- Fix typespec on `ExAws.Request.HttpClient.request/5`

v2.3.0
- Raise an exception on S3 operation when bucket is `nil`
- Update regions for transcribe service
- Doc and spec improvements
- Add location service
- Add support for IMDSv2
- Add support for awscli SSO credentials system

v2.2.10
- Add Athena support in `ca-central-1`
- Add support for `me` region

v2.2.9
- Add me-south-1 region
- Display `ExAws.Config` docs

v2.2.8
- Fix compiler warning on Elixir 1.13
- Fix support for explicitly passing in headers
- Add new Rekognition endpoints

v2.2.7
- `Request.Url`: Fix sanitize with spaces in request params
- Relax `jsx` requirement
- Relax `mime` requirement
- Update CI tests to include elixir 1.12

v2.2.6
- Increase minimum SweetXML version and disable DTD parsing (#781)
- Pass optional headers to REST requests (#820)
- Restrict mime version to 1.x
- Add config for sagemaker_runtime_a2i

v2.2.5
- Revert #796 to resolve #814. A more comprehensive fix for #796 is in the works.

v2.2.4
- Various documentation updates
- Improve performance of space de-duplication on auth headers (#788)
- Include the expected sequence token in error returns where it exists (#791)
- Ensure absolute path for virtual hosted stile S3 URLs (#792)
- Add QuickSight endpoints (#793)
- Tighten up `telemetry` version requirement
- Prevent `:awscli` config values from causing config from the CLI to leak into other values for
which it wasn't specified (#796)
- Update SageMaker endpoints (#804)
- Update SES endpoints (#807)
- Add eu-north-1 endpoint for logs (#811)

v2.2.3
- Add af-south-1 S3 region
- Add support for telemetry events

v2.2.2
- Add sa-east-1 region to cognito-idp service
- Support for af-south-1
- Increase minimum hackney version to 1.16 to hopefully reduce instances of people hitting bugs
in older versions
- Include profile in ETS key used for :awscli auth cache

v2.2.1
- Fix regression in 2.2.0 requiring metadata instance config parameter
- Fix calculation of authentication cache time

v2.2.0
- Add us-west-1 to list of supported ses services.
- Handle aws errors that do not have a `#` in the type
- [Breaking] Allow STS credentials to be injected by configuration
  - This change moves the `ExAws.CredentialsIni` functions into
    `ExAws.CredentialsIni.File` and turns the former into a behaviour definition.
    Any explicit uses of `ExAws.CredentialsIni.<function>` will need to be
    replaced with `ExAws.CredentialsIni.File.<function>`.

v2.1.9
- Small tweak to correctly handle error responses from DynamoDB local v1.15

v2.1.8
- Fix regression introduced in 2.1.7 which broke creation of folders (#752)
- Fixes to run cleanly under dialyzer
- Fix ExAws.Request.HttpClient.request spec to include header fields required by S3
- Fix S3 path handling on Windows
- Add Athena for eu-west-2
- Refactor auth cache refreshing (fixes issue #625)
- `mix format` pass

v2.1.7

- Various documentation updates
- Add `comprehend` endpoint
- Support firehose in region ca-central-1
- More documentation fixes
- Add github workflow actions for CI
- Add us-east-2 endpoint for SES
- Use :crypto.mac/4 rather than the deprecated :crypto.hmac/3 when available
- Support virtual-host style S3 buckets
- Fix presigned URLs with embedded query parameter strings
- Support reading profile for CLI config from AWS_PROFILE environment variable

v2.1.6

- Fixes/updates for various service endpoints
- Add support form Chime, via ex_chime_aws
- Typing fix for HTTP content-lenght header
- Fix warnings for Elixir 1.11
- Increase minimum Elixir version to 1.5
- Update and tidy docs and README

v2.1.5

- Elixir 1.11 compatibility tweak

v2.1.3

- Relax Jason version

v2.1.0

- Slew of bug fixes
- Updated endpoints and regions
- [Breaking] kinesis.tail task renamed to aws.kinesis.tail

v2.0.2

- Enhancement: Enable `ExAws.Auth.presigned_url` with custom body. Enables https://github.com/ex-aws/ex_aws_rds/pull/3
- Enhancement: Handle non AWS regions with new default structure.

v2.0.1

- Fix regression where mix config region was applies too late.

ExAws v2.0.0

- Major Project Split
- Configuration update to support all regions on all services.

ExAws v1.1.4

- Further refactoring of EC2, relaxed dependencies

ExAws v1.1.3

- Significant refactoring of EC2
- Expansion of CloudFormation functionality

- DynamoDB: Permit empty lists, add stream_query.

ExAws v1.1.2

- New Service: Cloudwatch (initial)
- New Service: ElasticTranscoder

- Various bug fixes.

Thanks to our many contributors!

ExAws v1.1.0

This update has quite a few changes, many thanks to those who contributed code
this release!

Enhancements
- New Service: Route53
- New Service: DynamoStreams
- New Service: SES (Partial)
- New Service: STS (Partial)
- SQS: Support for FIFO queues added.
- Improved error message when authentication keys are missing or invalid
- Improved error message when instance role is used locally

Breaking Changes:
- Elixir 1.4 required for `S3.upload`
- Flow support removed in favor of `Task.async_stream`
