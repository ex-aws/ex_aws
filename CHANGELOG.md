## v1.2.0
  - Breaking Change: S3 operations with associated parsing functions will raise by
    default now if the XML dependency is not included. If you do not want this behaviour,
    override the parse function on the operation like so:
    ```
    S3.list_objects() |> Map.put(:parser, &(&1)) |> ExAws.request
    ```
  - Breaking Change: DyanmoDB will now encode `nil` as the now supported `{"NULL":"true"}`
  - Enhancements:
      - Additional functions on SES
      -

  - Bug fix: URLs with spaces and S3.

## v1.1.0

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
