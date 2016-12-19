defmodule ExAws.Cloudformation.ParserTest do
  use ExUnit.Case, async: true
  alias ExAws.Cloudformation.Parsers

  def to_success(doc) do
    {:ok, %{body: doc}}
  end

  test "parsing a list_stack_resources response" do
    rsp = """
    <ListStackResourcesResponse xmlns="http://cloudformation.amazonaws.com/doc/2010-05-15/">
      <ListStackResourcesResult>
        <StackResourceSummaries>
          <member>
            <ResourceStatus>CREATE_COMPLETE</ResourceStatus>
            <LogicalResourceId>DBSecurityGroup</LogicalResourceId>
            <LastUpdatedTimestamp>2011-06-21T20:15:58Z</LastUpdatedTimestamp>
            <PhysicalResourceId>gmarcteststack-dbsecuritygroup-1s5m0ez5lkk6w</PhysicalResourceId>
            <ResourceType>AWS::RDS::DBSecurityGroup</ResourceType>
          </member>
          <member>
            <ResourceStatus>CREATE_COMPLETE</ResourceStatus>
            <LogicalResourceId>CPUAlarmHigh</LogicalResourceId>
            <LastUpdatedTimestamp>2011-06-21T20:29:23Z</LastUpdatedTimestamp>
            <PhysicalResourceId>MyStack-CPUAlarmHigh-POBWQPDJA81F</PhysicalResourceId>
            <ResourceType>AWS::CloudWatch::Alarm</ResourceType>
          </member>
        </StackResourceSummaries>
      </ListStackResourcesResult>
      <ResponseMetadata>
        <RequestId>2d06e36c-ac1d-11e0-a958-example</RequestId>
      </ResponseMetadata>
    </ListStackResourcesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_stack_resources)
    assert parsed_doc[:request_id] == "2d06e36c-ac1d-11e0-a958-example"
    assert parsed_doc[:resources] |> length == 2

    first_resource = parsed_doc[:resources] |> hd
    assert first_resource[:resource_status] == :create_complete
    assert first_resource[:resource_type] == "AWS::RDS::DBSecurityGroup"
    assert first_resource[:logical_resource_id] == "DBSecurityGroup"
    assert first_resource[:physical_resource_id] == "gmarcteststack-dbsecuritygroup-1s5m0ez5lkk6w"
  end

end
