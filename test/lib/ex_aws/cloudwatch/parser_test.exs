defmodule ExAws.Cloudwatch.ParserTest do
  use ExUnit.Case, async: true
  import Support.ParserHelpers

  alias ExAws.Cloudwatch.Parsers

  test "#parsing a describe_alarms response" do
    rsp = """
      <DescribeAlarmsResponse xmlns="http://monitoring.amazonaws.com/doc/2010-08-01/">
        <DescribeAlarmsResult>
          <NextToken>next-token</NextToken>
          <MetricAlarms>
            <member>
              <MetricName>metric-name</MetricName>
              <AlarmConfigurationUpdatedTimestamp>2017-01-01T01:01:01.000Z</AlarmConfigurationUpdatedTimestamp>
              <StateValue>OK</StateValue>
              <Threshold>2.0</Threshold>
              <StateReason>a-state-reason</StateReason>
              <InsufficientDataActions>
                <member>a</member>
              </InsufficientDataActions>
              <AlarmDescription>alarm-description</AlarmDescription>
              <AlarmActions>
                <member>c</member>
              </AlarmActions>
              <StateUpdatedTimestamp>2017-01-01T00:00:00.000Z</StateUpdatedTimestamp>
              <Period>20</Period>
              <Statistic>Sum</Statistic>
              <ComparisonOperator>LessThanThreshold</ComparisonOperator>
              <AlarmName>alarm-name</AlarmName>
              <EvaluationPeriods>1</EvaluationPeriods>
              <StateReasonData>some-state-reason-data</StateReasonData>
              <ActionsEnabled>true</ActionsEnabled>
              <Namespace>a-namespace</Namespace>
              <OKActions>
                <member>b</member>
              </OKActions>
              <AlarmArn>alarm-arn</AlarmArn>
              <Dimensions>
                <member>
                  <Name>dimension-name</Name>
                  <Value>dimension-value</Value>
                </member>
              </Dimensions>
            </member>
          </MetricAlarms>
        </DescribeAlarmsResult>
        <ResponseMetadata>
          <RequestId>3f1478c7-33a9-11df-9540-99d0768312d3</RequestId>
        </ResponseMetadata>
      </DescribeAlarmsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :describe_alarms)

    assert Enum.count(parsed_doc[:alarms]) == 1
    assert parsed_doc[:next_token] == "next-token"
    assert parsed_doc[:request_id] == "3f1478c7-33a9-11df-9540-99d0768312d3"

    alarm = List.first(parsed_doc[:alarms])

    assert alarm[:metric_name] == "metric-name"
    assert alarm[:alarm_name] == "alarm-name"
    assert alarm[:alarm_description] == "alarm-description"
    assert alarm[:evaluation_periods] == 1
    assert alarm[:actions_enabled] == true
    assert alarm[:namespace] == "a-namespace"
    assert alarm[:alarm_arn] == "alarm-arn"
    assert alarm[:state_value] == "OK"
    assert alarm[:threshold] == 2.0
    assert alarm[:period] == 20
    assert alarm[:statistic] == "Sum"
    assert alarm[:comparison_operator] == "LessThanThreshold"
    assert alarm[:state_reason] == "a-state-reason"
    assert alarm[:state_reason_data] == "some-state-reason-data"
    assert alarm[:insufficient_data_actions] == ["a"]
    assert alarm[:ok_actions] == ["b"]
    assert alarm[:alarm_actions] == ["c"]
    assert alarm[:state_updated_timestamp] == "2017-01-01T00:00:00.000Z"
    assert alarm[:alarm_configuration_updated_timestamp] == "2017-01-01T01:01:01.000Z"

    assert alarm[:dimensions] == [%{name: "dimension-name", value: "dimension-value"}]
  end
end
