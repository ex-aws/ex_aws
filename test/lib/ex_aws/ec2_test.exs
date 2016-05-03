defmodule Test.Dummy.EC2 do
  use ExAws.EC2.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(_client, http_method, path, data \\ []) do
    data
    |> Enum.into(%{})
    |> Map.put(:path, path)
    |> Map.put(:http_method, http_method)
  end
end

defmodule ExAws.EC2Test do
  use ExUnit.Case, async: true
  alias Test.Dummy.EC2

  @version "2015-10-01"

  test "describe_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeInstances",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instances
  end

  test "describe_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "DescribeInstances",
          "Version"    => @version,
          "NextToken"  => "token",
          "Instance.1" => "instance_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instances([next_token: "token", "Instance.1": "instance_1"])
  end 

  test "describe_instance_status no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeInstanceStatus",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instance_status    
  end

  test "describe_instance_status with options" do 
    expected = 
      %{
        params: %{
          "Action"              => "DescribeInstanceStatus",
          "Version"             => @version,
          "IncludeAllInstances" => true,
          "MaxResults"          => 10
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instance_status(include_all_instances: true, max_results: 10)    
  end  

  test "run_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"   => "RunInstances",
          "Version"  => @version,
          "ImageId"  => "image_id",
          "MaxCount" => 10,
          "MinCount" => 5
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.run_instances("image_id", 10, 5)
  end  

  test "run_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"   => "RunInstances",
          "Version"  => @version,
          "ImageId"  => "image_id",
          "MaxCount" => 10,
          "MinCount" => 5,
          "BlockDeviceMapping.1" => "some bdm",
          "KernelId" => "kernel_id",
          "Placement" => "some_placement"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.run_instances(
      "image_id", 
      10, 
      5,
      [
        "BlockDeviceMapping.1": "some bdm",
        "KernelId": "kernel_id",
        "Placement": "some_placement"
      ]
    )
  end

  test "start_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "StartInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.start_instances(["instance_1", "instance_2"])    
  end  

  test "start_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"         => "StartInstances",
          "Version"        => @version,
          "InstanceId.1"   => "instance_1",
          "InstanceId.2"   => "instance_2",
          "AdditionalInfo" => true,
          "DryRun"         => false
        },
        path: "/",
        http_method: :post
      }

    assert expected == 
      EC2.start_instances(
        ["instance_1", "instance_2"],
        [additional_info: true, dry_run: false]
      )    
  end

  test "stop_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "StopInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.stop_instances(["instance_1", "instance_2"])    
  end       

  test "stop_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "StopInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "Force"        => true,
          "DryRun"       => false
        },
        path: "/",
        http_method: :post
      }

    assert expected == 
      EC2.stop_instances(
        ["instance_1", "instance_2"],
        [force: true, dry_run: false]
      )    
  end  

  test "terminate_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "TerminateInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.terminate_instances(["instance_1", "instance_2"])    
  end  

  test "terminate_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "TerminateInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "DryRun"       => false
        },
        path: "/",
        http_method: :post
      }

    assert expected == 
      EC2.terminate_instances(
        ["instance_1", "instance_2"],
        [dry_run: false]
      )    
  end

  test "reboot_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "RebootInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reboot_instances(["instance_1", "instance_2"])    
  end     

  test "reboot_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "RebootInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "DryRun"       => false
        },
        path: "/",
        http_method: :post
      }

    assert expected == 
      EC2.reboot_instances(
        ["instance_1", "instance_2"],
        [dry_run: false]
      )    
  end   

  test "report_instance_status no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "ReportInstanceStatus",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "Status"       => "status"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.report_instance_status(["instance_1", "instance_2"], "status")    
  end     

  test "report_instance_status with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "ReportInstanceStatus",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "Status"       => "status",
          "Description"  => "description",
          "ReasonCode.1" => "code"
        },
        path: "/",
        http_method: :get
      }

    assert expected == 
      EC2.report_instance_status(
        ["instance_1", "instance_2"], 
        "status",
        [description: "description", "ReasonCode.1": "code"]
      )    
  end  

  test "monitor_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "MonitorInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.monitor_instances(["instance_1", "instance_2"])    
  end         

  test "monitor_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "MonitorInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "DryRun"       => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.monitor_instances(["instance_1", "instance_2"], [dry_run: true])    
  end  

  test "unmonitor_instances no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "UnmonitorInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.unmonitor_instances(["instance_1", "instance_2"])    
  end         

  test "unmonitor_instances with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "UnmonitorInstances",
          "Version"      => @version,
          "InstanceId.1" => "instance_1",
          "InstanceId.2" => "instance_2",
          "DryRun"       => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.unmonitor_instances(["instance_1", "instance_2"], [dry_run: true])    
  end   

  test "describe_instance_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "DescribeInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "Attribute"  => "attr"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instance_attribute("instance_1", "attr")    
  end    

  test "describe_instance_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "DescribeInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "Attribute"  => "attr",
          "DryRun"     => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instance_attribute("instance_1", "attr", [dry_run: true])    
  end    

  test "modify_instance_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "ModifyInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_instance_attribute("instance_1")    
  end    

  test "modify_instance_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "ModifyInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "Attribute"  => "attr",
          "Value"      => "value",
          "GroupId.1"  => "group"
        },
        path: "/",
        http_method: :post
      }

    assert expected == 
      EC2.modify_instance_attribute(
        "instance_1",
        [attribute: "attr", value: "value", "GroupId.1": "group"]
      )    
  end        

  test "reset_instance_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "ResetInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "Attribute"  => "attr"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_instance_attribute("instance_1", "attr")    
  end     

  test "reset_instance_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "ResetInstanceAttribute",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "Attribute"  => "attr",
          "DryRun"     => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_instance_attribute("instance_1", "attr", [dry_run: true])    
  end    

  test "get_console_output no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "GetConsoleOutput",
          "Version"    => @version,
          "InstanceId" => "instance_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.get_console_output("instance_1")    
  end  

  test "get_console_output with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "GetConsoleOutput",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "DryRun"     => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.get_console_output("instance_1", [dry_run: true])    
  end  

  test "get_password_data no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "GetPasswordData",
          "Version"    => @version,
          "InstanceId" => "instance_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.get_password_data("instance_1")    
  end    

  test "get_password_data with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "GetPasswordData",
          "Version"    => @version,
          "InstanceId" => "instance_1",
          "DryRun"     => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.get_password_data("instance_1", [dry_run: true])    
  end      
end
