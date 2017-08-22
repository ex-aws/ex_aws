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
