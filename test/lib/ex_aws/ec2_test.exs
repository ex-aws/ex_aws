# defmodule Test.Dummy.EC2 do
#   use ExAws.EC2.Client
#
#   def config_root, do: Application.get_all_env(:ex_aws)
#
#   def request(_client, http_method, path, data \\ []) do
#     data
#     |> Enum.into(%{})
#     |> Map.put(:path, path)
#     |> Map.put(:http_method, http_method)
#   end
# end

defmodule ExAws.EC2Test do
  use ExUnit.Case, async: true
  alias ExAws.EC2

  @version "2015-10-01"

  ######################
  ### Instance Tests ###
  ######################

  test "describe_instances no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeInstances",
          "Version"    => @version,
          "NextToken"  => "token",
          "InstanceId.1" => "instance_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_instances([next_token: "token", instance_id: ["instance_1"]])
  end

  test "describe_instance_status no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
        block_device_mapping: ["some bdm"],
        kernel_id: "kernel_id",
        placement: "some_placement"
      ]
    )
  end

  test "start_instances no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
        [description: "description", reason_code: ["code"]]
      )
  end

  test "monitor_instances no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
        [attribute: "attr", value: "value", group_id: ["group"]]
      )
  end

  test "reset_instance_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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

    assert expected == EC2.create_image "instance", "name", [description: "description", block_device_mapping: ["bdm"]]
  end

  test "copy_image no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"    => "DescribeImages",
          "Version"   => @version,
          "DryRun"    => true,
          "ImageId.1" => "image_1"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_images([dry_run: true, image_id: ["image_1"]])
  end

  test "describe_image_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"    => "DescribeKeyPairs",
          "Version"   => @version,
          "DryRun"    => true,
          "KeyName.1" => "some_key"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_key_pairs [dry_run: true, key_name: ["some_key"]]
  end

  test "create_key_pair no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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

    assert expected == EC2.describe_security_groups [dry_run: true, group_id: ["group1"], group_name: ["name"]]
  end

  test "create_security_group no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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

    assert expected == EC2.describe_vpcs [dry_run: true, vpc_id: ["id1", "id2"]]
  end

  test "create_vpc no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeSubnets",
          "Version"    => @version,
          "DryRun"     => true,
          "SubnetId.1" => "subnet"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_subnets [dry_run: true, subnet_id: ["subnet"]]
  end

  test "create_subnet no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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

  test "describe_tags with filters" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeTags",
          "Version"    => @version,
          "Filter.1.Name" => "key",
          "Filter.1.Value.1" => "a-key",
          "Filter.1.Value.2" => "b-key",
          "Filter.2.Name" => "resource-id",
          "Filter.2.Value" => "id",
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_tags filters: [key: ["a-key", "b-key"], resource_id: "id"]

    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeTags",
          "Version"    => @version,
          "Filter.1.Name" => "resource-type",
          "Filter.1.Value.1" => "customer-gateway",
          "Filter.2.Name" => "resource-type",
          "Filter.2.Value.1" => "customer-gateway",
          "Filter.2.Value.2" => "instance",
        },
        path: "/",
        http_method: :get
      }
      assert expected == EC2.describe_tags filters: [resource_type: [:customer_gateway], resource_type: [:customer_gateway, :instance]]
  end

  test "create_tags no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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
      %ExAws.Operation.RestQuery{service: :ec2,
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

  ##################################
  ### Elastic Block Stores Tests ###
  ##################################

  test "describe_volumes no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"  => "DescribeVolumes",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volumes
  end

  test "describe_volumes with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeVolumes",
          "Version"    => @version,
          "DryRun"     => true,
          "MaxResults" => 10,
          "VolumeId.1" => "volume"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volumes [dry_run: true, max_results: 10, volume_id: ["volume"]]
  end

  test "create_volume no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"           => "CreateVolume",
          "Version"          => @version,
          "AvailabilityZone" => "az",
          "Size"             => 400
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_volume "az", 400
  end

  test "create_volume with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"           => "CreateVolume",
          "Version"          => @version,
          "AvailabilityZone" => "az",
          "Size"             => 400,
          "DryRun"           => true,
          "Encrypted"        => false,
          "SnapshotId"       => "snap"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_volume(
      "az",
      400,
      [
        dry_run:     true,
        encrypted:   false,
        snapshot_id: "snap"
      ]
    )
  end

  test "delete_volume no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DeleteVolume",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_volume "volume"
  end

  test "delete_volume with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DeleteVolume",
          "Version"  => @version,
          "VolumeId" => "volume",
          "DryRun"   => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_volume "volume", [dry_run: true]
  end

  test "attach_volume no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "AttachVolume",
          "Version"    => @version,
          "InstanceId" => "instance",
          "VolumeId"   => "volume",
          "Device"     => "device"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.attach_volume "instance", "volume", "device"
  end

  test "attach_volume with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "AttachVolume",
          "Version"    => @version,
          "InstanceId" => "instance",
          "VolumeId"   => "volume",
          "Device"     => "device",
          "DryRun"     => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.attach_volume "instance", "volume", "device", [dry_run: true]
  end

  test "detach_volume no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DetachVolume",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.detach_volume "volume"
  end

  test "detach_volume with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DetachVolume",
          "Version"  => @version,
          "VolumeId" => "volume",
          "DryRun"   => true,
          "Device"   => "device",
          "Force"    => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.detach_volume "volume", [dry_run: true, device: "device", "force": true]
  end

  test "describe_volume_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DescribeVolumeAttribute",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volume_attribute "volume"
  end

  test "describe_volume_attribute with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"    => "DescribeVolumeAttribute",
          "Version"   => @version,
          "VolumeId"  => "volume",
          "DryRun"    => true,
          "Attribute" => "attr"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volume_attribute "volume", [dry_run: true, attribute: "attr"]
  end

  test "modify_volume_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "ModifyVolumeAttribute",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_volume_attribute "volume"
  end

  test "modify_volume_attribute with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"       => "ModifyVolumeAttribute",
          "Version"      => @version,
          "VolumeId"     => "volume",
          "AutoEnableIo" => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_volume_attribute "volume", [auto_enable_io: true]
  end

  test "enable_volume_io no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "EnableVolumeIO",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.enable_volume_io "volume"
  end

  test "enable_volume_io with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "EnableVolumeIO",
          "Version"  => @version,
          "VolumeId" => "volume",
          "DryRun"   => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.enable_volume_io "volume", [dry_run: true]
  end

  test "describe_volume_status no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"  => "DescribeVolumeStatus",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volume_status
  end

  test "describe_volume_status with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeVolumeStatus",
          "Version"    => @version,
          "VolumeId.1" => "abc",
          "VolumeId.2" => "def"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_volume_status [volume_id: ["abc", "def"]]
  end

  test "describe_snapshots no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"  => "DescribeSnapshots",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_snapshots
  end

  test "describe_snapshots with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeSnapshots",
          "Version"    => @version,
          "DryRun"     => true,
          "MaxResults" => 10,
          "Owner.1"    => "owner"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_snapshots [dry_run: true, max_results: 10, owner: ["owner"]]
  end

  test "create_snapshot no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "CreateSnapshot",
          "Version"  => @version,
          "VolumeId" => "volume"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_snapshot "volume"
  end

  test "create_snapshot with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"      => "CreateSnapshot",
          "Version"     => @version,
          "VolumeId"    => "volume",
          "Description" => "desc",
          "DryRun"      => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.create_snapshot "volume", [dry_run: true, description: "desc"]
  end

  test "copy_snapshot no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"           => "CopySnapshot",
          "Version"          => @version,
          "SourceSnapshotId" => "ssid",
          "SourceRegion"     => "region"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.copy_snapshot "ssid", "region"
  end

  test "copy_snapshot with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"            => "CopySnapshot",
          "Version"           => @version,
          "SourceSnapshotId"  => "ssid",
          "SourceRegion"      => "region",
          "DestinationRegion" => "dest",
          "Encrypted"         => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.copy_snapshot "ssid", "region", [destination_region: "dest", encrypted: true]
  end

  test "delete_snapshot no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DeleteSnapshot",
          "Version"    => @version,
          "SnapshotId" => "snap"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_snapshot "snap"
  end

  test "delete_snapshot with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DeleteSnapshot",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "DryRun"     => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.delete_snapshot "snap", [dry_run: true]
  end

  test "describe_snapshot_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeSnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "Attribute"  => "attr"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_snapshot_attribute "snap", "attr"
  end

  test "describe_snapshot_attribute with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeSnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "Attribute"  => "attr",
          "DryRun"     => true
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_snapshot_attribute "snap", "attr", [dry_run: true]
  end

  test "modify_snapshot_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "ModifySnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_snapshot_attribute "snap"
  end

  test "modify_snapshot_attribute with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "ModifySnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "Attribute"  => "attr",
          "Value"      => "value"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.modify_snapshot_attribute "snap", [attribute: "attr", value: "value"]
  end

  test "reset_snapshot_attribute no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "ResetSnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "Attribute"  => "attr"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_snapshot_attribute "snap", "attr"
  end

  test "reset_snapshot_attribute with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "ResetSnapshotAttribute",
          "Version"    => @version,
          "SnapshotId" => "snap",
          "Attribute"  => "attr",
          "DryRun"     => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.reset_snapshot_attribute "snap", "attr", [dry_run: true]
  end

  ################################
  ### Account Attributes Tests ###
  ################################

  test "describe_account_attributes no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"  => "DescribeAccountAttributes",
          "Version" => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_account_attributes
  end

  test "describe_account_attributes with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"          => "DescribeAccountAttributes",
          "Version"         => @version,
          "DryRun"          => true,
          "AttributeName.1" => "name"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_account_attributes [dry_run: true, attribute_name: ["name"]]
  end

  ##########################
  ### Bundle Tasks Tests ###
  ##########################

  test "bundle_instance no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"                           => "BundleInstance",
          "Version"                          => @version,
          "InstanceId"                       => "instance",
          "Storage.S3.AWSAccessKeyId"        => "key_id",
          "Storage.S3.Bucket"                => "bucket",
          "Storage.S3.Prefix"                => "prefix",
          "Storage.S3.UploadPolicy"          => "policy",
          "Storage.S3.UploadPolicySignature" => "signature"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.bundle_instance "instance", {"key_id", "bucket", "prefix", "policy", "signature"}
  end

  test "bundle_instance with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"                           => "BundleInstance",
          "Version"                          => @version,
          "InstanceId"                       => "instance",
          "Storage.S3.AWSAccessKeyId"        => "key_id",
          "Storage.S3.Bucket"                => "bucket",
          "Storage.S3.Prefix"                => "prefix",
          "Storage.S3.UploadPolicy"          => "policy",
          "Storage.S3.UploadPolicySignature" => "signature",
          "DryRun"                           => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.bundle_instance "instance", {"key_id", "bucket", "prefix", "policy", "signature"}, [dry_run: true]
  end

  test "cancel_bundle_task no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "CancelBundleTask",
          "Version"  => @version,
          "BundleId" => "bundle"
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.cancel_bundle_task "bundle"
  end

  test "cancel_bundle_task with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "CancelBundleTask",
          "Version"  => @version,
          "BundleId" => "bundle",
          "DryRun"   => true
        },
        path: "/",
        http_method: :post
      }

    assert expected == EC2.cancel_bundle_task "bundle", [dry_run: true]
  end

  test "describe_bundle_tasks no options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"   => "DescribeBundleTasks",
          "Version"  => @version
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_bundle_tasks
  end

  test "describe_bundle_tasks with options" do
    expected =
      %ExAws.Operation.RestQuery{service: :ec2,
        params: %{
          "Action"     => "DescribeBundleTasks",
          "Version"    => @version,
          "DryRun"     => true,
          "BundleId.1" => "id1",
          "BundleId.2" => "id2"
        },
        path: "/",
        http_method: :get
      }

    assert expected == EC2.describe_bundle_tasks [dry_run: true, bundle_id: ["id1", "id2"]]
  end
end
