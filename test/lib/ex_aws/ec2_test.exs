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

  ######################
  ### Instance Tests ###
  ######################

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

  ############################################
  ### Regions and Availability Zones Tests ###
  ############################################

  test "describe_availability_zones no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeAvailabilityZones",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_availability_zones    
  end   

  test "describe_availability_zones with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeAvailabilityZones",
          "Version" => @version,
          "DryRun"  => true,
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_availability_zones [dry_run: true]
  end     

  test "describe_regions no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeRegions",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_regions 
  end     

  test "describe_regions with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeRegions",
          "Version" => @version,
          "DryRun"  => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_regions [dry_run: true]
  end       

  #################
  ### AMI Tests ###
  #################

  test "create_image no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "CreateImage",
          "Version"    => @version,
          "InstanceId" => "instance",
          "Name"       => "name"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_image "instance", "name"
  end      

  test "create_image with options" do 
    expected = 
      %{
        params: %{
          "Action"               => "CreateImage",
          "Version"              => @version,
          "InstanceId"           => "instance",
          "Name"                 => "name",
          "Description"          => "description",
          "BlockDeviceMapping.1" => "bdm"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_image "instance", "name", [description: "description", "BlockDeviceMapping.1": "bdm"]
  end        

  test "copy_image no options" do 
    expected = 
      %{
        params: %{
          "Action"        => "CopyImage",
          "Version"       => @version,
          "Name"          => "name",
          "SourceImageId" => "source_image_id",
          "SourceRegion"  => "region"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.copy_image "name", "source_image_id", "region"
  end   

  test "copy_image with options" do 
    expected = 
      %{
        params: %{
          "Action"        => "CopyImage",
          "Version"       => @version,
          "Name"          => "name",
          "SourceImageId" => "source_image_id",
          "SourceRegion"  => "region",
          "ClientToken"   => "token",
          "Encrypted"     => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.copy_image "name", "source_image_id", "region", [client_token: "token", encrypted: true]
  end   

  test "describe_images no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeImages",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_images
  end   

  test "describe_images with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeImages",
          "Version"   => @version,
          "DryRun"    => true,
          "ImageId.1" => "image_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_images([dry_run: true, "ImageId.1": "image_1"])
  end  

  test "describe_image_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeImageAttribute",
          "Version"   => @version,
          "ImageId"   => "image",
          "Attribute" => "attr"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_image_attribute "image", "attr"
  end        

  test "describe_image_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeImageAttribute",
          "Version"   => @version,
          "ImageId"   => "image",
          "Attribute" => "attr",
          "DryRun"    => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_image_attribute "image", "attr", [dry_run: true]
  end 

  test "modify_image_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "ModifyImageAttribute",
          "Version" => @version,
          "ImageId" => "image"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_image_attribute "image"
  end       

  test "modify_image_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "ModifyImageAttribute",
          "Version"   => @version,
          "ImageId"   => "image",
          "Attribute" => "attr",
          "Value"     => "value"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_image_attribute "image", [attribute: "attr", value: "value"]
  end    

  test "reset_image_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"    => "ResetImageAttribute",
          "Version"   => @version,
          "ImageId"   => "image",
          "Attribute" => "attr"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_image_attribute "image", "attr"
  end            

  test "reset_image_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "ResetImageAttribute",
          "Version"   => @version,
          "ImageId"   => "image",
          "Attribute" => "attr",
          "DryRun"    => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_image_attribute "image", "attr", [dry_run: true]
  end       

  test "register_image no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "RegisterImage",
          "Version" => @version,
          "Name"    => "name"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.register_image "name"
  end                           

  test "register_image no options" do 
    expected = 
      %{
        params: %{
          "Action"          => "RegisterImage",
          "Version"         => @version,
          "Name"            => "name",
          "SriovNetSupport" => true,
          "Architecture"    => "archi"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.register_image "name", [sriov_net_support: true, architecture: "archi"]
  end                             

  test "deregister_image no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeregisterImage",
          "Version" => @version,
          "ImageId" => "image"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.deregister_image "image"
  end     

  test "deregister_image with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeregisterImage",
          "Version" => @version,
          "ImageId" => "image",
          "DryRun"  => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.deregister_image "image", [dry_run: true]
  end

  #######################
  ### Key Pairs Tests ###
  #######################

  test "describe_key_pairs no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeKeyPairs",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_key_pairs
  end     

  test "describe_key_pairs with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeKeyPairs",
          "Version"   => @version,
          "DryRun"    => true,
          "KeyName.1" => "some_key"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_key_pairs [dry_run: true, "KeyName.1": "some_key"]
  end     

  test "create_key_pair no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "CreateKeyPair",
          "Version" => @version,
          "KeyName" => "keyname"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_key_pair("keyname")
  end       

  test "create_key_pair with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "CreateKeyPair",
          "Version" => @version,
          "KeyName" => "keyname",
          "DryRun"  => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_key_pair("keyname", [dry_run: true])
  end         

  test "delete_key_pair no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeleteKeyPair",
          "Version" => @version,
          "KeyName" => "keyname"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_key_pair("keyname")
  end         

test "delete_key_pair with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeleteKeyPair",
          "Version" => @version,
          "KeyName" => "keyname",
          "DryRun"  => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_key_pair("keyname", [dry_run: true])
  end           

  test "import_key_pair no options" do 
    expected = 
      %{
        params: %{
          "Action"            => "ImportKeyPair",
          "Version"           => @version,
          "KeyName"           => "keyname",
          "PublicKeyMaterial" => Base.url_encode64("pkm")
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.import_key_pair("keyname", "pkm")
  end           

  test "import_key_pair with options" do 
    expected = 
      %{
        params: %{
          "Action"            => "ImportKeyPair",
          "Version"           => @version,
          "KeyName"           => "keyname",
          "PublicKeyMaterial" => Base.url_encode64("pkm"),
          "DryRun"            => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.import_key_pair("keyname", "pkm", [dry_run: true])
  end             
end
