defmodule ExAws.Cloudformation.ParserTest do
  use ExUnit.Case, async: true
  alias ExAws.Cloudformation.Parsers

  def to_success(doc) do
    {:ok, %{body: doc}}
  end

  def to_error(doc) do
    {:error, {:http_error, 403, %{body: doc}}}
  end

  test "parsing a describe_stack_resource response" do
    rsp = """
    <DescribeStackResourceResponse xmlns="http://cloudformation.amazonaws.com/doc/2010-05-15/">
      <DescribeStackResourceResult>
        <StackResourceDetail>
          <StackId>arn:aws:cloudformation:us-east-1:123456789:stack/MyStack/aaf549a0-a413-11df-adb3-5081b3858e83</StackId>
          <StackName>MyStack</StackName>
          <LogicalResourceId>MyDBInstance</LogicalResourceId>
          <PhysicalResourceId>MyStack_DB1</PhysicalResourceId>
          <ResourceType>AWS::RDS::DBInstance</ResourceType>
          <LastUpdatedTimestamp>2011-07-07T22:27:28Z</LastUpdatedTimestamp>
          <ResourceStatus>CREATE_COMPLETE</ResourceStatus>
          <Metadata>{&quot;CustomKey&quot;:&quot;CustomValue&quot;}\n</Metadata>
        </StackResourceDetail>
      </DescribeStackResourceResult>
      <ResponseMetadata>
        <RequestId>b9b4b068-3a41-11e5-94eb-example</RequestId>
      </ResponseMetadata>
    </DescribeStackResourceResponse>
    """
    |> to_success

     {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :describe_stack_resource, config())
     assert parsed_doc[:request_id] == "b9b4b068-3a41-11e5-94eb-example"
     %{resource: resource} = parsed_doc

     assert resource[:resource_status] == :create_complete
     assert resource[:resource_type] == "AWS::RDS::DBInstance"
     assert resource[:logical_resource_id] == "MyDBInstance"
     assert resource[:physical_resource_id] == "MyStack_DB1"
     assert resource[:metadata] == %{"CustomKey" => "CustomValue"}
  end

  test "parsing a list_stacks response" do
    rsp = """
    <ListStacksResponse xmlns="http://cloudformation.amazonaws.com/doc/2010-05-15/">
      <ListStacksResult>
        <NextToken>NextPageToken</NextToken>
        <StackSummaries>
          <member>
            <StackId>arn:aws:cloudformation:us-east-1:1234567:stack/TestCreate1/aaaaa</StackId>
            <StackStatus>CREATE_IN_PROGRESS</StackStatus>
            <StackName>vpc1</StackName>
            <CreationTime>2011-05-23T15:47:44Z</CreationTime>
            <TemplateDescription>Creates one EC2 instance and a load balancer.</TemplateDescription>
            <ResourceTypes>
              <member>AWS::EC2::Instance</member>
              <member>AWS::ElasticLoadBalancing::LoadBalancer</member>
            </ResourceTypes>
          </member>
          <member>
            <StackId>arn:aws:cloudformation:us-east-1:1234567:stack/TestDelete2/bbbbb</StackId>
            <StackStatus>DELETE_COMPLETE</StackStatus>
            <DeletionTime>2011-03-10T16:20:51Z</DeletionTime>
            <StackName>WP1</StackName>
            <CreationTime>2011-03-05T19:57:58Z</CreationTime>
          </member>
        </StackSummaries>
      </ListStacksResult>
      <ResponseMetadata>
        <RequestId>b9b4b068-3a41-11e5-94eb-example</RequestId>
      </ResponseMetadata>
    </ListStacksResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_stacks, config())
    assert parsed_doc[:request_id] == "b9b4b068-3a41-11e5-94eb-example"
    assert parsed_doc[:next_token] == "NextPageToken"
    assert parsed_doc[:stacks] |> length == 2

    first_stack = parsed_doc[:stacks] |> hd
    assert first_stack[:status] == :create_in_progress
    assert first_stack[:name] == "vpc1"
    assert first_stack[:creation_time] == "2011-05-23T15:47:44Z"
    assert first_stack[:template_description] == "Creates one EC2 instance and a load balancer."
    assert first_stack[:resource_types] == ["AWS::EC2::Instance", "AWS::ElasticLoadBalancing::LoadBalancer"]
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

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_stack_resources, config())
    assert parsed_doc[:request_id] == "2d06e36c-ac1d-11e0-a958-example"
    assert parsed_doc[:resources] |> length == 2

    first_resource = parsed_doc[:resources] |> hd
    assert first_resource[:resource_status] == :create_complete
    assert first_resource[:resource_type] == "AWS::RDS::DBSecurityGroup"
    assert first_resource[:logical_resource_id] == "DBSecurityGroup"
    assert first_resource[:physical_resource_id] == "gmarcteststack-dbsecuritygroup-1s5m0ez5lkk6w"
  end

  test "it should handle parsing an error" do
    rsp = """
    <?xml version=\"1.0\"?>
    <ErrorResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
      <Error>
        <Type>Sender</Type>
        <Code>InvalidClientTokenId</Code>
        <Message>The security token included in the request is invalid.</Message>
        <Detail/>
      </Error>
      <RequestId>f7ac5905-2fb6-5529-a86d-09628dae67f4</RequestId>
    </ErrorResponse>
    """
    |> to_error

    {:error, {:http_error, 403, err}} = Parsers.parse(rsp, :set_endpoint_attributes)

    assert err[:request_id] == "f7ac5905-2fb6-5529-a86d-09628dae67f4"
    assert err[:type] == "Sender"
    assert err[:code] == "InvalidClientTokenId"
    assert err[:message] == "The security token included in the request is invalid."
  end

  defp config(), do: ExAws.Config.new(:cloudformation, [])

end
