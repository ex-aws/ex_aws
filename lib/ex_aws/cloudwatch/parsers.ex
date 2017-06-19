if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Cloudwatch.Parsers do
    use ExAws.Operation.Query.Parser

    def parse({:ok, %{body: xml}=resp}, :describe_alarms) do
      parsed_body = xml
                    |> SweetXml.xpath(~x"//DescribeAlarmsResponse",
      alarms: alarm_xml_description(),
      next_token: ~x"./DescribeAlarmsResult/NextToken/text()"s,
      request_id: ~x"./ResponseMetadata/RequestId/text()"s)

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(val, _), do: val

    defp alarm_xml_description do
      [
        ~x"./DescribeAlarmsResult/MetricAlarms/member"l,
        alarm_name: ~x"./AlarmName/text()"s,
        metric_name: ~x"./MetricName/text()"s,
        alarm_description: ~x"./AlarmDescription/text()"s,
        evaluation_periods: ~x"./EvaluationPeriods/text()"i,
        actions_enabled: ~x"./ActionsEnabled/text()"s |> to_boolean(),
        namespace: ~x"./Namespace/text()"s,
        alarm_arn: ~x"./AlarmArn/text()"s,
        state_value: ~x"./StateValue/text()"s,
        threshold: ~x"./Threshold/text()"f,
        period: ~x"./Period/text()"i,
        statistic: ~x"./Statistic/text()"s,
        comparison_operator: ~x"./ComparisonOperator/text()"s,
        state_reason: ~x"./StateReason/text()"s,
        state_reason_data: ~x"./StateReasonData/text()"s,
        insufficient_data_actions: ~x"./InsufficientDataActions/member/text()"ls,
        ok_actions: ~x"./OKActions/member/text()"ls,
        alarm_actions: ~x"./AlarmActions/member/text()"ls,
        state_updated_timestamp: ~x"./StateUpdatedTimestamp/text()"s,
        alarm_configuration_updated_timestamp: ~x"./AlarmConfigurationUpdatedTimestamp/text()"s,
        dimensions: [
          ~x"./Dimensions/member"l,
          name: ~x"./Name/text()"s,
          value: ~x"./Value/text()"s]
      ]
    end

    defp to_boolean(xpath) do
      xpath |> SweetXml.transform_by(&(&1 == "true"))
    end
  end
else
  defmodule ExAws.Cloudwatch.Parsers do
    def parse(val, _), do: val
  end
end
