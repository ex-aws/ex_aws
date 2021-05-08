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
