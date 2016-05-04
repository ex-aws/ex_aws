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

  test "register_image with options" do 
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

  #########################
  ### Resource ID Tests ###
  #########################

  test "describe_id_format no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeIdFormat",
          "Version" => @version,
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_id_format
  end             

  test "describe_id_format with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeIdFormat",
          "Version" => @version,
          "Resource" => "some_resource"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_id_format [resource: "some_resource"]
  end               

  test "modify_id_format no options" do 
    expected = 
      %{
        params: %{
          "Action"     => "ModifyIdFormat",
          "Version"    => @version,
          "Resource"   => "resource",
          "UseLongIds" => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_id_format "resource", true
  end              

  #############################
  ### Security Groups Tests ###
  #############################

  test "describe_security_groups no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeSecurityGroups",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_security_groups
  end                

  test "describe_security_groups with options" do 
    expected = 
      %{
        params: %{
          "Action"      => "DescribeSecurityGroups",
          "Version"     => @version,
          "DryRun"      => true,
          "GroupId.1"   => "group1",
          "GroupName.1" => "name"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_security_groups [dry_run: true, "GroupId.1": "group1", "GroupName.1": "name"]
  end                  

  test "create_security_group no options" do 
    expected = 
      %{
        params: %{
          "Action"           => "CreateSecurityGroup",
          "Version"          => @version,
          "GroupName"        => "groupname",
          "GroupDescription" => "desc"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_security_group "groupname", "desc"
  end                  

  test "create_security_group with options" do 
    expected = 
      %{
        params: %{
          "Action"           => "CreateSecurityGroup",
          "Version"          => @version,
          "GroupName"        => "groupname",
          "GroupDescription" => "desc",
          "DryRun"           => true,
          "VpcId"            => "vpc_id"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_security_group "groupname", "desc", [dry_run: true, vpc_id: "vpc_id"]
  end                    

  test "authorize_security_group_ingress no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "AuthorizeSecurityGroupIngress",
          "Version" => @version,
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.authorize_security_group_ingress
  end                    

  test "authorize_security_group_ingress with options" do 
    expected = 
      %{
        params: %{
          "Action"   => "AuthorizeSecurityGroupIngress",
          "Version"  => @version,
          "CidrIp"   => "cidr",
          "DryRun"   => true,
          "FromPort" => 10,
          "ToPort"   => 20
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.authorize_security_group_ingress(
      [
        cidr_ip: "cidr",
        dry_run: true,
        from_port: 10,
        to_port: 20
      ]
    )
  end                      

  test "authorize_security_group_egress no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "AuthorizeSecurityGroupEgress",
          "Version" => @version,
          "GroupId" => "groupid"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.authorize_security_group_egress "groupid"
  end             

  test "authorize_security_group_egress with options" do 
    expected = 
      %{
        params: %{
          "Action"   => "AuthorizeSecurityGroupEgress",
          "Version"  => @version,
          "GroupId"  => "groupid",
          "CidrIp"   => "cidr",
          "DryRun"   => true,
          "FromPort" => 10,
          "ToPort"   => 20
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.authorize_security_group_egress("groupid",
      [
        cidr_ip: "cidr",
        dry_run: true,
        from_port: 10,
        to_port: 20
      ]
    )
  end               

  test "revoke_security_group_ingress no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "RevokeSecurityGroupIngress",
          "Version" => @version
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.revoke_security_group_ingress
  end               

  test "revoke_security_group_ingress with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "RevokeSecurityGroupIngress",
          "Version" => @version,
          "CidrIp"   => "cidr",
          "DryRun"   => true,
          "FromPort" => 10,
          "ToPort"   => 20          
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.revoke_security_group_ingress(
      [
        cidr_ip: "cidr",
        dry_run: true,
        from_port: 10,
        to_port: 20
      ]
    )
  end                 

  test "revoke_security_group_egress no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "RevokeSecurityGroupEgress",
          "Version" => @version,
          "GroupId" => "group"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.revoke_security_group_egress "group"
  end  

  test "revoke_security_group_egress with options" do 
    expected = 
      %{
        params: %{
          "Action"   => "RevokeSecurityGroupEgress",
          "Version"  => @version,
          "GroupId"  => "group",
          "CidrIp"   => "cidr",
          "DryRun"   => true,
          "FromPort" => 10,
          "ToPort"   => 20                    
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.revoke_security_group_egress(
      "group",
      [
        cidr_ip: "cidr",
        dry_run: true,
        from_port: 10,
        to_port: 20
      ]
    )
  end   

  ##################
  ### VPCs Tests ###
  ##################

  test "describe_vpcs no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeVpcs",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_vpcs
  end     

  test "describe_vpcs with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeVpcs",
          "Version" => @version,
          "DryRun"  => true,
          "VpcId.1" => "id1",
          "VpcId.2" => "id2"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_vpcs [dry_run: true, "VpcId.1": "id1", "VpcId.2": "id2"]
  end       

  test "create_vpc no options" do 
    expected = 
      %{
        params: %{
          "Action"    => "CreateVpc",
          "Version"   => @version,
          "CidrBlock" => "cidr"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_vpc "cidr"
  end       

  test "create_vpc wit options" do 
    expected = 
      %{
        params: %{
          "Action"          => "CreateVpc",
          "Version"         => @version,
          "CidrBlock"       => "cidr",
          "DryRun"          => true,
          "InstanceTenancy" => "tenancy"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_vpc "cidr", [dry_run: true, instance_tenancy: "tenancy"]
  end     

  test "delete_vpc no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeleteVpc",
          "Version" => @version,
          "VpcId"   => "vpc"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_vpc "vpc"
  end      

  test "delete_vpc with options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DeleteVpc",
          "Version" => @version,
          "VpcId"   => "vpc",
          "DryRun"  => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_vpc "vpc", [dry_run: true]
  end    

  test "describe_vpc_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeVpcAttribute",
          "Version"   => @version,
          "VpcId"     => "vpc",
          "Attribute" => "attr"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_vpc_attribute "vpc", "attr"
  end         

  test "describe_vpc_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "DescribeVpcAttribute",
          "Version"   => @version,
          "VpcId"     => "vpc",
          "Attribute" => "attr",
          "DryRun"    => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_vpc_attribute "vpc", "attr", [dry_run: true]
  end         

  test "modify_vpc_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "ModifyVpcAttribute",
          "Version" => @version,
          "VpcId"   => "vpc"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_vpc_attribute "vpc"
  end       

  test "modify_vpc_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"             => "ModifyVpcAttribute",
          "Version"            => @version,
          "VpcId"              => "vpc",
          "EnableDnsHostnames" => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_vpc_attribute "vpc", [enable_dns_hostnames: true]
  end    

  #####################
  ### Subnets Tests ###
  #####################

  test "describe_subnets no options" do 
    expected = 
      %{
        params: %{
          "Action"  => "DescribeSubnets",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_subnets
  end    

  test "describe_subnets with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "DescribeSubnets",
          "Version"    => @version,
          "DryRun"     => true,
          "SubnetId.1" => "subnet"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_subnets [dry_run: true, "SubnetId.1": "subnet"]
  end     

  test "create_subnet no options" do 
    expected = 
      %{
        params: %{
          "Action"    => "CreateSubnet",
          "Version"   => @version,
          "VpcId"     => "vpc",
          "CidrBlock" => "cidr"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_subnet "vpc", "cidr"
  end    

  test "create_subnet with options" do 
    expected = 
      %{
        params: %{
          "Action"    => "CreateSubnet",
          "Version"   => @version,
          "VpcId"     => "vpc",
          "CidrBlock" => "cidr",
          "DryRun"    => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_subnet "vpc", "cidr", [dry_run: true]
  end      

  test "delete_subnet no options" do 
    expected = 
      %{
        params: %{
          "Action"   => "DeleteSubnet",
          "Version"  => @version,
          "SubnetId" => "subnet"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_subnet "subnet"
  end    

  test "delete_subnet with options" do 
    expected = 
      %{
        params: %{
          "Action"   => "DeleteSubnet",
          "Version"  => @version,
          "SubnetId" => "subnet",
          "DryRun"   => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_subnet "subnet", [dry_run: true]
  end      

  test "modify_subnet_attribute no options" do 
    expected = 
      %{
        params: %{
          "Action"   => "ModifySubnetAttribute",
          "Version"  => @version,
          "SubnetId" => "subnet"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_subnet_attribute "subnet"
  end      

  test "modify_subnet_attribute with options" do 
    expected = 
      %{
        params: %{
          "Action"              => "ModifySubnetAttribute",
          "Version"             => @version,
          "SubnetId"            => "subnet",
          "MapPublicIpOnLaunch" => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_subnet_attribute "subnet", [map_public_ip_on_launch: true]
  end    

  ##################
  ### Tags Tests ###
  ##################

  test "describe_tags no options" do 
    expected = 
      %{
        params: %{
          "Action"   => "DescribeTags",
          "Version"  => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_tags
  end       

  test "describe_tags with options" do 
    expected = 
      %{
        params: %{
          "Action"     => "DescribeTags",
          "Version"    => @version,
          "MaxResults" => 10,
          "NextToken"  => "abc"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_tags [max_results: 10, next_token: "abc"]
  end     

  test "create_tags no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "CreateTags",
          "Version"      => @version,
          "ResourceId.1" => "abc",
          "Tag.1.Key"    => "key1",
          "Tag.1.Value"  => "value1",
          "Tag.2.Key"    => "key2",
          "Tag.2.Value"  => "value2"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_tags ["abc"], [{"key1", "value1"}, {"key2", "value2"}]
  end       

  test "create_tags with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "CreateTags",
          "Version"      => @version,
          "ResourceId.1" => "abc",
          "Tag.1.Key"    => "key1",
          "Tag.1.Value"  => "value1",
          "Tag.2.Key"    => "key2",
          "Tag.2.Value"  => "value2",
          "DryRun"       => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_tags ["abc"], [{"key1", "value1"}, {"key2", "value2"}], [dry_run: true]
  end  

  test "delete_tags no options" do 
    expected = 
      %{
        params: %{
          "Action"       => "DeleteTags",
          "Version"      => @version,
          "ResourceId.1" => "abc",
          "ResourceId.2" => "def"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_tags ["abc", "def"]
  end      

  test "delete_tags with options" do 
    expected = 
      %{
        params: %{
          "Action"       => "DeleteTags",
          "Version"      => @version,
          "ResourceId.1" => "abc",
          "ResourceId.2" => "def",
          "DryRun"       => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_tags ["abc", "def"], [dry_run: true]
  end        
end
