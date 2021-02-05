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
