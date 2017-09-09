defmodule ExAws.EC2Test do
  use ExUnit.Case, async: true
  doctest ExAws.EC2

  alias ExAws.EC2


  @version "2016-11-15"

  defp build_query(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.merge(%{"Version" => @version, "Action" => action_string}),
      service: :ec2,
      action: action
    }
  end

  ###################
  # Instances Tests #
  ###################
  test "describe_instances no options" do
    expected = build_query(:describe_instances, %{})
    assert expected == EC2.describe_instances
  end

  test "describe_instances with filters and instance Ids" do
    expected = build_query(:describe_instances, %{
      "Filter.1.Name" => "tag",
      "Filter.1.Value.1" => "Owner",
      "Filter.2.Name" => "instance-type",
      "Filter.2.Value.1" => "m1.small",
      "Filter.2.Value.2" => "m1.large",
      "InstanceId.1" => "i-12345",
      "InstanceId.2" => "i-56789"
      })

    assert expected == EC2.describe_instances(
      [filters: [tag: ["Owner"], "instance-type": ["m1.small", "m1.large"]],
       instance_ids: ["i-12345", "i-56789"]
      ])
  end

  test "describe_instances with dry_run" do
    expected = build_query(:describe_instances, %{
      "DryRun" => true
      })

    assert expected == EC2.describe_instances(
      [dry_run: true]
    )
  end

  test "describe_instances with next_token and max_results"do
    expected = build_query(:describe_instances, %{
      "NextToken" => "TestToken",
      "MaxResults" => 10
      })

    assert expected == EC2.describe_instances(
      [next_token: "TestToken", max_results: 10]
    )
  end

  test "describe_instance_status no options" do
    expected = build_query(:describe_instance_status, %{})
    assert expected == EC2.describe_instance_status
  end

  test "describe_instance_status with filters and max_results" do
    expected = build_query(:describe_instance_status, %{
      "Filter.1.Name" => "system-status.reachability",
      "Filter.1.Value.1" => "failed",
      "MaxResults" => 5
      })

    assert expected == EC2.describe_instance_status(
      [filters: ["system-status.reachability": ["failed"]], max_results: 5]
    )
  end

  test "describe_instance_status with instance ids" do
    expected = build_query(:describe_instance_status, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-1a2b3c"
      })

    assert expected == EC2.describe_instance_status(
      [instance_ids: ["i-123456", "i-1a2b3c"]]
    )
  end

  test "describe_instances with dry_run, next_token, and include_all_instances" do
    expected = build_query(:describe_instance_status, %{
      "DryRun" => true,
      "NextToken" => "TestToken",
      "IncludeAllInstances" => true
      })

    assert expected == EC2.describe_instance_status(
      [dry_run: true, next_token: "TestToken", include_all_instances: true]
    )
  end

  test "terminate_instances no options" do
    expected = build_query(:terminate_instances, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-987654"
      })

    assert expected == EC2.terminate_instances(["i-123456", "i-987654"])
  end

  test "terminate_instances with dry_run set" do
    expected = build_query(:terminate_instances, %{
      "InstanceId.1" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.terminate_instances(["i-123456"], [dry_run: true])
  end

  test "reboot_instances" do
    expected = build_query(:reboot_instances, %{
      "InstanceId.1" => "i-123456"
      })

    assert expected == EC2.reboot_instances(["i-123456"])
  end

  test "reboot_instances with dry_run set" do
    expected = build_query(:reboot_instances, %{
      "InstanceId.1" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.reboot_instances(["i-123456"], [dry_run: true])
  end

  test "start_instances no options" do
    expected = build_query(:start_instances, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-987654"
      })

    assert expected == EC2.start_instances(["i-123456", "i-987654"])
  end

  test "start_instances with dry_run" do
    expected = build_query(:start_instances, %{
      "InstanceId.1" => "i-123456",
      "DryRun" => false
      })

    assert expected == EC2.start_instances(["i-123456"], [dry_run: false])
  end

  test "start_instance with additional_info" do
    expected = build_query(:start_instances, %{
      "InstanceId.1" => "i-123456",
      "AdditionalInfo" => "TestAdditionalInfo"
      })

    assert expected == EC2.start_instances(["i-123456"], [additional_info: "TestAdditionalInfo"])
  end


  test "stop_instances no options" do
    expected = build_query(:stop_instances, %{
      "InstanceId.1" => "i-123456"
      })

    assert expected == EC2.stop_instances(["i-123456"])
  end

  test "stop_instances by force" do
    expected = build_query(:stop_instances, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-1234abc",
      "Force" => true
      })

    assert expected == EC2.stop_instances(["i-123456", "i-1234abc"], [force: true])
  end

  test "stop_instances with dry_run" do
    expected = build_query(:stop_instances, %{
      "InstanceId" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.stop_instances("i-123456", [dry_run: true])
  end

  test "run_instances with no options" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3
      })

    assert expected == EC2.run_instances("ami-123456", 3, 3)
  end

  test "run_instances with block_device_mappings" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "BlockDeviceMapping.1.DeviceName" => "/dev/sdc",
      "BlockDeviceMapping.1.VirtualName" => "ephemeral10",
      "BlockDeviceMapping.2.DeviceName" => "/dev/sdd",
      "BlockDeviceMapping.2.VirtualName" => "ephemeral11",
      "BlockDeviceMapping.3.DeviceName" => "/dev/sdf",
      "BlockDeviceMapping.3.Ebs.DeleteOnTermination" => true,
      "BlockDeviceMapping.3.Ebs.VolumeSize" => 100
    })

    assert expected == EC2.run_instances("ami-123456", 3, 3,
      [block_device_mappings: [
        [device_name: "/dev/sdc", virtual_name: "ephemeral10"],
        [device_name: "/dev/sdd", virtual_name: "ephemeral11"],
        [device_name: "/dev/sdf", ebs: [delete_on_termination: true, volume_size: 100]]
    ]])
  end

  test "run_instances with client_token" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "ClientToken" => "TestClientToken"
      })

    assert expected == EC2.run_instances("ami-123456", 3, 3, [client_token: "TestClientToken"])
  end

  test "run_instances with disable_api_termination" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "DisableApiTermination" => true
      })

    assert expected == EC2.run_instances("ami-123456", 3, 3, [disable_api_termination: true])
  end

  test "run_instances with dry_run" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "DryRun" => true
    })

    assert expected == EC2.run_instances("ami-123456", 3, 3, [dry_run: true])
  end

  test "run_instances with iam_instance_profile" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "IamInstanceProfile.Arn" => "TestArn",
      "IamInstanceProfile.Name" => "TestName"
    })

    assert expected == EC2.run_instances("ami-123456", 3, 3,
    [iam_instance_profile: [arn: "TestArn", name: "TestName"]])
  end

  test "run_instances with ipv6_addresses and ipv6_address_count" do
    expected = build_query(:run_instances, %{
      "ImageId" => "ami-123456",
      "MinCount" => 3,
      "MaxCount" => 3,
      "Ipv6Address.1.Ipv6Address" => "10.0.0.6",
      "Ipv6Address.2.Ipv6Address" => "10.0.0.7",
      "Ipv6AddressCount" => 2
      })

      assert expected == EC2.run_instances("ami-123456", 3, 3,
      [ipv6_addresses: [[ipv6_address: "10.0.0.6"], [ipv6_address: "10.0.0.7"]], ipv6_address_count: 2])
  end

  test "run_instances with network_interfaces" do
    expected = build_query(:run_instances, %{
      "MinCount" => 3,
      "MaxCount" => 6,
      "ImageId" => "ami-123456",
      "NetworkInterface.1.AssociatePublicIpAddress" => true,
      "NetworkInterface.1.DeleteOnTermination" => true,
      "NetworkInterface.1.Description" => "TestDescription",
      "NetworkInterface.1.DeviceIndex" => 3,
      "NetworkInterface.1.Ipv6AddressCount" => 3,
      "NetworkInterface.1.Ipv6Addresses.1.Ipv6Address" => "10.0.0.1/16",
      "NetworkInterface.1.Ipv6Addresses.2.Ipv6Address" => "10.0.0.2/16",
      "NetworkInterface.1.NetworkInterfaceId" => "TestNetworkIntefaceId",
      "NetworkInterface.1.PrivateIpAddress" => "TestPrivateIpAddress",
      "NetworkInterface.1.PrivateIpAddresses.1.PrivateIpAddress" => "10.0.1.2",
      "NetworkInterface.1.PrivateIpAddresses.1.Primary" => true,
      "NetworkInterface.1.PrivateIpAddresses.2.PrivateIpAddress" => "10.0.2.3",
      "NetworkInterface.1.PrivateIpAddresses.2.Primary" => false,
      "NetworkInterface.1.Groups.1" => "sg-123456",
      "NetworkInterface.1.Groups.2" => "sg-987654",
      "NetworkInterface.1.SubnetId" => "sub-123456",
      "NetworkInterface.2.SubnetId" => "sub-987654"
      })

    assert expected == EC2.run_instances("ami-123456", 3, 6,
    [network_interfaces: [
      [associate_public_ip_address: true,
       delete_on_termination: true,
       description: "TestDescription",
       device_index: 3,
       ipv6_address_count: 3,
       ipv6_addresses: [
         [ipv6_address: "10.0.0.1/16"],
         [ipv6_address: "10.0.0.2/16"]
       ],
       network_interface_id: "TestNetworkIntefaceId",
       private_ip_address: "TestPrivateIpAddress",
       private_ip_addresses: [
         [private_ip_address: "10.0.1.2", primary: true],
         [private_ip_address: "10.0.2.3", primary: false]
       ],
       groups: ["sg-123456", "sg-987654"],
       subnet_id: "sub-123456"
     ],
     [subnet_id: "sub-987654"]
  ]])
  end

  test "report_instance_status no options" do
    expected = build_query(:report_instance_status, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-abcdefg",
      "Status" => "ok"
    })

    assert expected == EC2.report_instance_status(["i-123456", "i-abcdefg"], "ok")
  end

  test "report_instance_status with start_time and reason_codes" do
    start_time = %DateTime{year: 2015, month: 5, day: 12, zone_abbr: "UTC",
                          hour: 12, minute: 20, second: 31, microsecond: {0, 0},
                          utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
    expected = build_query(:report_instance_status, %{
      "InstanceId.1" => "i-123456",
      "Status" => "ok",
      "StartTime" => DateTime.to_iso8601(start_time),
      "ReasonCode.1" => "instance-stuck-in-state",
      "ReasonCode.2" => "unresponsive"
    })

    assert expected == EC2.report_instance_status(["i-123456"], "ok",
      [start_time: start_time,
       reason_codes: ["instance-stuck-in-state", "unresponsive"]])
  end

  test "report_instance_status with end_time" do
    end_time = %DateTime{year: 2015, month: 5, day: 12, zone_abbr: "UTC",
                        hour: 12, minute: 20, second: 31, microsecond: {0, 0},
                        utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
    expected = build_query(:report_instance_status, %{
      "InstanceId.1" => "i-123456",
      "Status" => "ok",
      "EndTime" => DateTime.to_iso8601(end_time)
    })

    assert expected == EC2.report_instance_status(["i-123456"], "ok", [end_time: end_time])
  end

  test "report_instance_status with description" do
    expected = build_query(:report_instance_status, %{
      "InstanceId.1" => "i-123456",
      "Status" => "ok",
      "Description" => "Test Description"
      })

    assert expected == EC2.report_instance_status(["i-123456"], "ok", [description: "Test Description"])
  end

  test "report_instance_status with dry_run" do
    expected = build_query(:report_instance_status, %{
      "InstanceId.1" => "i-123456",
      "Status" => "ok",
      "DryRun" => true
      })

    assert expected == EC2.report_instance_status(["i-123456"], "ok", [dry_run: true])
  end


  test "monitor_instances no options" do
    expected = build_query(:monitor_instances, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-a1b2c3"
      })

    assert expected == EC2.monitor_instances(["i-123456", "i-a1b2c3"])
  end

  test "monitor_instances with dry_run" do
    expected = build_query(:monitor_instances, %{
      "InstanceId.1" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.monitor_instances(["i-123456"], [dry_run: true])
  end

  test "unmonitor_instances no options" do
    expected = build_query(:unmonitor_instances, %{
      "InstanceId.1" => "i-123456",
      "InstanceId.2" => "i-a1b2c3"
      })

    assert expected == EC2.unmonitor_instances(["i-123456", "i-a1b2c3"])
  end

  test "unmonitor_instances wtih dry_run option" do
    expected = build_query(:unmonitor_instances, %{
      "InstanceId.1" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.unmonitor_instances(["i-123456"], [dry_run: true])
  end

  test "describe_instance_attribute no options" do
    expected = build_query(:describe_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Attribute" => "description"
    })

    assert expected == EC2.describe_instance_attribute("i-123456", "description")
  end

  test "describe_instance_attribute with dry_run" do
    expected = build_query(:describe_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Attribute" => "description",
      "DryRun" => true
      })

    assert expected == EC2.describe_instance_attribute("i-123456", "description", [dry_run: true])
  end

  test "modify_instance_attribute with attribute" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Attribute" => "instanceType"
    })

    assert expected == EC2.modify_instance_attribute("i-123456", [attribute: "instanceType"])
  end

  test "modify_instance_attribute with block_device_mappings" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "BlockDeviceMapping.1.Ebs.DeleteOnTermination" => true,
      "BlockDeviceMapping.1.Ebs.VolumeSize" => 100,
      "BlockDeviceMapping.1.Ebs.VolumeType" => "gp2",
      "BlockDeviceMapping.1.DeviceName" => "xvdb",
      "BlockDeviceMapping.2.Ebs.DeleteOnTermination" => false,
      "BlockDeviceMapping.2.Ebs.VolumeSize" => 1000,
      "BlockDeviceMapping.2.Ebs.VolumeType" => "io1",
      "BlockDeviceMapping.2.DeviceName" => "xvdc",
      "BlockDeviceMapping.2.VirtualName" => "boop"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [block_device_mappings: [
        [device_name: "xvdb", ebs: [delete_on_termination: true, volume_size: 100, volume_type: "gp2"]],
        [device_name: "xvdc", virtual_name: "boop", ebs: [delete_on_termination: false, volume_size: 1000, volume_type: "io1"]]
      ]])
  end

  test "modify_instance_attribute with disable_api_termination" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "DisableApiTermination.Value" => true
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [disable_api_termination: [value: true]])
  end

  test "modify_instance_attribute with dry_run" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [dry_run: true])
  end

  test "modify_instance_attribute with ebs_optimized" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "EbsOptimized.Value" => true
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [ebs_optimized: [value: true]])
  end

  test "modify_instance_attribute with ena_support" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "EnaSupport.Value" => false
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [ena_support: [value: false]])
  end

  test "modify_instance_attribute with group_ids" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "GroupId.1" => "sg-123456",
      "GroupId.2" => "sg-wasd"
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [group_ids: ["sg-123456", "sg-wasd"]])
  end

  test "modify_instance_attribute with instance_initiated_shutdown_behavior" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "InstanceInitiatedShutdownBehavior.Value" => "terminate"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [instance_initiated_shutdown_behavior: [value: "terminate"]])
  end

  test "modify_instance_attribute with instance_type" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "InstanceType.Value" => "m1.small"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [instance_type: [value: "m1.small"]])
  end

  test "modify_instance_attribute with kernel" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Kernel.Value" => "test_kernel"
      })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [kernel: [value: "test_kernel"]])
  end

  test "modify_instance_attribute with ramdisk" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Ramdisk.Value" => "test_ramdisk"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [ramdisk: [value: "test_ramdisk"]])
  end

  test "modify_instance_attribute with source_dest_check" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "SourceDestCheck.Value" => true
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [source_dest_check: [value: true]])
  end

  test "modify_instance_attribute with sriov_net_support" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "SriovNetSupport.Value" => "test_sriov_net_support"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [sriov_net_support: [value: "test_sriov_net_support"]])
  end

  test "modify_instance_attribute with user_data" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "UserData.Value" => "test_user_data"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [user_data: [value: "test_user_data"]])
  end

  test "modify_instance_attribute with value" do
    expected = build_query(:modify_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Value" => "test_value"
    })

    assert expected == EC2.modify_instance_attribute("i-123456",
      [value: "test_value"])
  end


  test "reset_instance_attribute no options" do
    expected = build_query(:reset_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Attribute" => "kernel"
      })

    assert expected == EC2.reset_instance_attribute("i-123456", "kernel")
  end

  test "reset_instance_attribute with dry_run" do
    expected = build_query(:reset_instance_attribute, %{
      "InstanceId" => "i-123456",
      "Attribute" => "kernel",
      "DryRun" => true
      })

    assert expected == EC2.reset_instance_attribute("i-123456", "kernel", [dry_run: true])
  end

  test "get_console_output no options" do
    expected = build_query(:get_console_output, %{
      "InstanceId" => "i-123456"
      })

    assert expected == EC2.get_console_output("i-123456")
  end

  test "get_console_output with dry_run" do
    expected = build_query(:get_console_output, %{
      "InstanceId" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.get_console_output("i-123456", [dry_run: true])
  end

  test "get_password_data no options" do
    expected = build_query(:get_password_data, %{
      "InstanceId" => "i-123456"
      })

    assert expected == EC2.get_password_data("i-123456")
  end

  test "get_password_data with dry_run" do
    expected = build_query(:get_password_data, %{
      "InstanceId" => "i-123456",
      "DryRun" => true
      })

    assert expected == EC2.get_password_data("i-123456", [dry_run: true])
  end

  #############
  # AMI Tests #
  #############

  test "create_image no options" do
    expected = build_query(:create_image, %{
      "InstanceId" => "i-123456",
      "Name" => "TestName"
    })

    assert expected == EC2.create_image("i-123456", "TestName")
  end

  test "create_image with block_device_mappings" do
    expected = build_query(:create_image, %{
      "InstanceId" => "i-123456",
      "Name" => "TestName",
      "BlockDeviceMapping.1.Ebs.DeleteOnTermination" => true,
      "BlockDeviceMapping.1.Ebs.VolumeSize" => 100,
      "BlockDeviceMapping.1.Ebs.VolumeType" => "gp2",
      "BlockDeviceMapping.1.DeviceName" => "xvdb"
      })

    assert expected == EC2.create_image("i-123456", "TestName",
      [block_device_mappings: [
          [
            device_name: "xvdb",
            ebs: [
              delete_on_termination: true,
              volume_size: 100,
              volume_type: "gp2",
            ]
          ]
        ]
      ])
  end

  test "create_image with description" do
    expected = build_query(:create_image, %{
      "InstanceId" => "i-123456",
      "Name" => "TestName",
      "Description" => "TestDescription"
    })

    assert expected == EC2.create_image("i-123456", "TestName", [description: "TestDescription"])
  end

  test "create_image with dry_run" do
    expected = build_query(:create_image, %{
      "InstanceId" => "i-123456",
      "Name" => "TestName",
      "DryRun" => true
      })

    assert expected == EC2.create_image("i-123456", "TestName", [dry_run: true])
  end

  test "create_image with no_reboot" do
    expected = build_query(:create_image, %{
      "InstanceId" => "i-123456",
      "Name" => "TestName",
      "NoReboot" => true
      })

    assert expected == EC2.create_image("i-123456", "TestName", [no_reboot: true])
  end

  test "copy_image no options" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI"
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2")
  end

  test "copy_image with client_token" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI",
      "ClientToken" => "TestClientToken"
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2",
      [client_token: "TestClientToken"])
  end

  test "copy_image with description" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI",
      "Description" => "Test Description"
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2",
      [description: "Test Description"])
  end

  test "copy_image with dry_run" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI",
      "DryRun" => true
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2",
      [dry_run: true])
  end

  test "copy_image with encrypted" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI",
      "Encrypted" => true
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2",
      [encrypted: true])
  end

  test "copy_image with kms_key_id" do
    expected = build_query(:copy_image, %{
      "SourceRegion" => "us-west-2",
      "SourceImageId" => "ami-1a2b3c4d",
      "Name" => "Test AMI",
      "KmsKeyId" => "Test_Kms_Key_Id"
      })

    assert expected == EC2.copy_image("Test AMI", "ami-1a2b3c4d", "us-west-2",
      [kms_key_id: "Test_Kms_Key_Id"])
  end

  test "describe_images" do
    expected = build_query(:describe_images, %{})

    assert expected == EC2.describe_images
  end

  test "describe_images with image ids" do
    expected = build_query(:describe_images, %{
      "ImageId.1" => "ami-1234567",
      "ImageId.2" => "ami-test123"
      })

    assert expected == EC2.describe_images(
      [image_ids: ["ami-1234567", "ami-test123"]])
  end

  test "describe_images with owners" do
    expected = build_query(:describe_images, %{
      "Owner.1" => "test_owner",
      "Owner.2" => "aws"
      })

    assert expected == EC2.describe_images(
      owners: ["test_owner", "aws"]
    )
  end

  test "describe_images with filters" do
    expected = build_query(:describe_images, %{
      "Filter.1.Name" => "is-public",
      "Filter.1.Value.1" => true,
      "Filter.2.Name" => "architecture",
      "Filter.2.Value.1" => "x86_64",
      "Filter.3.Name" => "platform",
      "Filter.3.Value.1" => "windows",
      "Filter.3.Value.2" => "linux"
      })

    assert expected == EC2.describe_images(
      [
        filters: [
          "is-public": [true],
          "architecture": ["x86_64"],
          "platform": ["windows", "linux"]
        ]
      ]
    )
  end

  test "describe_images with executable_by_list" do
    expected = build_query(:describe_images, %{
      "ExecutableBy.1" => "dog",
      "ExecutableBy.2" => "me",
      "ExecutableBy.3" => "rhino"
      })

    assert expected == EC2.describe_images(
      [executable_by_list: ["dog", "me", "rhino"]]
    )
  end

  test "describe_images with dry_run" do
    expected = build_query(:describe_images, %{
      "DryRun" => true
      })

    assert expected == EC2.describe_images(
      [dry_run: true]
    )
  end

  test "describe_image_attributes no options" do
    expected = build_query(:describe_image_attribute, %{
      "ImageId" => "ami-1234567",
      "Attribute" => "description"
    })

    assert expected == EC2.describe_image_attribute("ami-1234567", "description")
  end

  test "describe_image_attribute with dry_run" do
    expected = build_query(:describe_image_attribute, %{
      "ImageId" => "ami-1234567",
      "Attribute" => "description",
      "DryRun" => true
    })

    assert expected == EC2.describe_image_attribute("ami-1234567", "description",
      [dry_run: true])
  end

  test "modify_image_attribute no options" do
    expected = build_query(:modify_image_attribute, %{
      "ImageId" => "ami-123456"
      })

    assert expected == EC2.modify_image_attribute("ami-123456")
  end

  test "modify_image_attributes with launch_permission" do
    expected = build_query(:modify_image_attribute, %{
      "ImageId" => "ami-123456",
      "LaunchPermission.Add.1.Group" => "a12",
      "LaunchPermission.Remove.1.UserId" => "999988887777",
      "LaunchPermission.Add.2.UserId" => "111122223333",
      "LaunchPermission.Add.2.Group" => "testGroup"
      })

    assert expected == EC2.modify_image_attribute("ami-123456", [
      launch_permission: [
        remove:
          [
            [user_id: "999988887777"]
          ],
        add:
          [
            [group: "a12"],
            [user_id: "111122223333", group: "testGroup"]
          ]
      ]
    ])
  end

  test "modify_image_attributes with description" do
    expected = build_query(:modify_image_attribute, %{
      "ImageId" => "ami-123456",
      "Description.Value" => "New Description"
      })

    assert expected == EC2.modify_image_attribute("ami-123456", [
      description: [value: "New Description"]
    ])
  end

  test "modify_image_attributes with product_codes" do
    expected = build_query(:modify_image_attribute, %{
      "ImageId" => "ami-123456",
      "ProductCode.1" => "774F4FF8",
      "ProductCode.2" => "12345ABC"
      })

    assert expected == EC2.modify_image_attribute("ami-123456",
      [
        product_codes: ["774F4FF8", "12345ABC"]
      ])
  end


  test "reset_image_attribute no options" do
    expected = build_query(:reset_image_attribute, %{
      "ImageId" => "ami-123456",
      "Attribute" => "launchPermission"
      })

    assert expected == EC2.reset_image_attribute("ami-123456", "launchPermission")
  end

  test "reset_image_attribute with dry_run" do
    expected = build_query(:reset_image_attribute, %{
      "ImageId" => "ami-123456",
      "Attribute" => "launchPermission",
      "DryRun" => true
      })

    assert expected == EC2.reset_image_attribute("ami-123456", "launchPermission", [dry_run: true])
  end

  test "register_image no options" do
    expected = build_query(:register_image, %{
      "Name" => "Test"
      })

    assert expected == EC2.register_image("Test")
  end

  test "register_image with architecture" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "Architecture" => "x86"
      })

    assert expected == EC2.register_image("Test", [architecture: "x86"])
  end

  test "register_image with billing_products" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "BillingProduct.1" => "TestProduct_1",
      "BillingProduct.2" => "TestProduct_2"
      })

    assert expected == EC2.register_image("Test", [
      billing_products: ["TestProduct_1", "TestProduct_2"]
    ])
  end

  test "register_image with block_device_mappings" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "BlockDeviceMapping.1.DeviceName" => "/dev/sda1",
      "BlockDeviceMapping.1.Ebs.SnapshotId" => "snap-1234567890abcdef0",
      "BlockDeviceMapping.2.DeviceName" => "/dev/sdb",
      "BlockDeviceMapping.2.Ebs.SnapshotId" => "snap-1234567890abcdef1",
      "BlockDeviceMapping.3.DeviceName" => "/dev/sdc",
      "BlockDeviceMapping.3.Ebs.VolumeSize" => 100
      })

    assert expected == EC2.register_image("Test", [block_device_mappings: [
      [device_name: "/dev/sda1", ebs: [snapshot_id: "snap-1234567890abcdef0"]],
      [device_name: "/dev/sdb",  ebs: [snapshot_id: "snap-1234567890abcdef1"]],
      [device_name: "/dev/sdc",  ebs: [volume_size: 100]]
    ]])
  end

  test "register_image with description" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "Description" => "TestDescription"
      })

    assert expected == EC2.register_image("Test", [description: "TestDescription"])
  end

  test "register_image with dry_run" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "DryRun" => true
    })

    assert expected == EC2.register_image("Test", [dry_run: true])
  end

  test "register image with ena_support" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "EnaSupport" => true
    })

    assert expected == EC2.register_image("Test", [ena_support: true])
  end

  test "register image with image_location" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "ImageLocation" => "/path/to/here"
    })

    assert expected == EC2.register_image("Test", [image_location: "/path/to/here"])
  end

  test "register_image with kernel_id" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "KernelId" => "TestKernelId"
    })

    assert expected == EC2.register_image("Test", [kernel_id: "TestKernelId"])
  end

  test "register_image with ramdisk_id" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "RamdiskId" => "TestRamDiskId"
    })

    assert expected == EC2.register_image("Test", [ramdisk_id: "TestRamDiskId"])
  end

  test "register_image with root_device_name" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "RootDeviceName" => "/dev/sda1"
    })

    assert expected == EC2.register_image("Test", [root_device_name: "/dev/sda1"])
  end

  test "register_image with sriov_net_support" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "SriovNetSupport" => "simple"
    })

    assert expected == EC2.register_image("Test", [sriov_net_support: "simple"])
  end

  test "register_image with virtualization_type" do
    expected = build_query(:register_image, %{
      "Name" => "Test",
      "VirtualizationType" => "paravirtual"
    })

    assert expected == EC2.register_image("Test", [virtualization_type: "paravirtual"])
  end

  test "deregister_image no options" do
    expected = build_query(:deregister_image, %{
      "ImageId" => "ami-123456"
      })

    assert expected == EC2.deregister_image("ami-123456")
  end

  test "deregister_image with dry_run option" do
    expected = build_query(:deregister_image, %{
      "ImageId" => "ami-123456",
      "DryRun" => true
      })

    assert expected == EC2.deregister_image("ami-123456", [dry_run: true])
  end

  #################
  # Volumes Tests #
  #################
  test "attach_volume no options" do
    expected = build_query(:attach_volume, %{
      "InstanceId" => "i-123456",
      "VolumeId" => "vol-123456",
      "Device" => "/dev/sdb"
      })

    assert expected == EC2.attach_volume("i-123456", "vol-123456", "/dev/sdb")
  end

  test "attach_volume with dry_run" do
    expected = build_query(:attach_volume, %{
      "InstanceId" => "i-123456",
      "VolumeId" => "vol-123456",
      "Device" => "/dev/sdb",
      "DryRun" => false
    })

    assert expected == EC2.attach_volume("i-123456", "vol-123456", "/dev/sdb", [dry_run: false])
  end

  test "detach_volume no options" do
    expected = build_query(:detach_volume, %{"VolumeId" => "vol-123456"})

    assert expected == EC2.detach_volume("vol-123456")
  end

  test "detach_volume with force" do
    expected = build_query(:detach_volume, %{
      "VolumeId" => "vol-123456",
      "Force" => false
    })

    assert expected == EC2.detach_volume("vol-123456", [force: false])
  end

  test "detach_volume with dry_run" do
    expected = build_query(:detach_volume, %{
      "VolumeId" => "vol-123456",
      "DryRun" => true
    })

    assert expected == EC2.detach_volume("vol-123456", [dry_run: true])
  end

  test "detach_volume with device" do
    expected = build_query(:detach_volume, %{
      "VolumeId" => "vol-123456",
      "Device" => "/dev/sdh"
    })

    assert expected == EC2.detach_volume("vol-123456", [device: "/dev/sdh"])
  end

  test "delete_volume with no additional params" do
    expected = build_query(:delete_volume, %{"VolumeId" => "vol-123456"})

    assert expected == EC2.delete_volume("vol-123456")
  end

  test "delete_volume with dry_run param" do
    expected = build_query(:delete_volume, %{
      "VolumeId" => "vol-123456",
      "DryRun" => true})

    assert expected == EC2.delete_volume("vol-123456", [dry_run: true])
  end

  test "create_volume test with tag specifications" do
    expected = build_query(:create_volume, %{
      "AvailabilityZone" => "us-east-1a",
      "TagSpecification.1.ResourceType" => "volume",
      "TagSpecification.1.Tag.1.Key" => "tag_key_foo",
      "TagSpecification.1.Tag.1.Value" => "tag_value_foo",
      "TagSpecification.1.Tag.2.Key" => "tag_key_bar",
      "TagSpecification.1.Tag.2.Value" => "tag_value_bar",

      "TagSpecification.2.ResourceType" => "volume",
      "TagSpecification.2.Tag.1.Key" => "tag_key_baz",
      "TagSpecification.2.Tag.1.Value" => "tag_value_baz",
      })

      assert expected == EC2.create_volume("us-east-1a",
        [tag_specifications: [
          volume:
            [tag_key_foo: "tag_value_foo",
             tag_key_bar: "tag_value_bar"],
          volume:
            [tag_key_baz: "tag_value_baz"]
          ]
        ])
  end

  test "create_volume test with iops, snapshot ID and volume type" do
    expected = build_query(:create_volume, %{
      "AvailabilityZone" => "us-east-1a",
      "SnapshotId" => "snap-123456",
      "VolumeType" => "io1",
      "Iops" => 3000
    })

    assert expected == EC2.create_volume("us-east-1a",
      [snapshot_id: "snap-123456", volume_type: "io1", iops: 3000])
  end

  test "create_volume test with kms_key_id" do
    expected = build_query(:create_volume, %{
      "AvailabilityZone" => "us-east-1a",
      "KmsKeyId" => "TestKmsKeyId"
      })

    assert expected == EC2.create_volume("us-east-1a",
      [kms_key_id: "TestKmsKeyId"])
  end

  test "create_volume test with encrypted" do
    expected = build_query(:create_volume, %{
      "AvailabilityZone" => "us-east-1a",
      "Encrypted" => true
      })

    assert expected == EC2.create_volume("us-east-1a",
      [encrypted: true])
  end

  test "modify_volume test" do
    expected = build_query(:modify_volume, %{"VolumeId" => "vol-123456"})
    assert expected == EC2.modify_volume("vol-123456")
  end

  test "modify_volume test with iops, size, and volume type" do
    expected = build_query(:modify_volume, %{
      "VolumeId" => "vol-123456",
      "Iops" => 3000,
      "Size" => 1024,
      "VolumeType" => "io1"
    })

    assert expected == EC2.modify_volume("vol-123456",
      [iops: 3000, size: 1024, volume_type: "io1"])
  end

  test "enable_volume_io no options" do
    expected = build_query(:enable_volume_i_o, %{
      "VolumeId" => "vol-123456"
    })

    assert expected == EC2.enable_volume_io("vol-123456")
  end

  test "describe_volumes no options" do
    expected = build_query(:describe_volumes, %{})

    assert expected == EC2.describe_volumes
  end

  test "describe_volumes with filters" do
    expected = build_query(:describe_volumes, %{
      "Filter.1.Name" => "tag-key",
      "Filter.1.Value.1" => "*_db_*",
      "Filter.1.Value.2" => "test"
      })

    assert expected == EC2.describe_volumes([
      filters: ["tag-key": ["*_db_*", "test"]]
    ])
  end

  test "describe_volumes with volume_ids" do
    expected = build_query(:describe_volumes, %{
      "VolumeId.1" => "vol-123456",
      "VolumeId.2" => "vol-1a2b3c",
      "VolumeId.3" => "vol-4d5e6f"
      })

    assert expected == EC2.describe_volumes([
      volume_ids: ["vol-123456", "vol-1a2b3c", "vol-4d5e6f"]
      ])
  end

  test "describe_volume_status no option" do
    expected = build_query(:describe_volume_status, %{})

    assert expected == EC2.describe_volume_status
  end

  test "describe_volume_status with filters and volume_ids" do
    expected = build_query(:describe_volume_status, %{
      "Filter.1.Name" => "availability-zone",
      "Filter.1.Value.1" => "us-east-1d",
      "Filter.2.Name" => "volume-status.details-name",
      "Filter.2.Value.1" => "io-enabled",
      "Filter.3.Name" => "volume-status.details-status",
      "Filter.3.Value.1" => "failed",
      "VolumeId.1" => "vol-1234567",
      "VolumeId.2" => "vol-9876543"
      })

    assert expected == EC2.describe_volume_status([
      filters: [
          "availability-zone": ["us-east-1d"],
          "volume-status.details-name": ["io-enabled"],
          "volume-status.details-status": ["failed"],
       ],
       volume_ids: ["vol-1234567", "vol-9876543"]
    ])
  end

  test "modify_volume_attribute" do
    expected = build_query(:modify_volume_attribute, %{
      "VolumeId" => "vol-123456"
      })

    assert expected == EC2.modify_volume_attribute("vol-123456")
  end

  test "modify_volume_attribute with dry_run and auto_enable_io params" do
    expected = build_query(:modify_volume_attribute, %{
      "VolumeId" => "vol-123456",
      "AutoEnableIO.Value" => true,
      "DryRun" => true
      })

    assert expected == EC2.modify_volume_attribute("vol-123456", [auto_enable_io: [value: true], dry_run: true])
  end

  test "describe_volume_attribute no options" do
    expected = build_query(:describe_volume_attribute, %{
      "VolumeId" => "vol-123456",
      "Attribute" => "autoEnableIO"
      })

    assert expected == EC2.describe_volume_attribute("vol-123456", "autoEnableIO")
  end

  test "describe_volume_attribute with dry_run" do
    expected = build_query(:describe_volume_attribute, %{
      "VolumeId" => "vol-123456",
      "Attribute" => "autoEnableIO",
      "DryRun"  => true
      })

    assert expected == EC2.describe_volume_attribute("vol-123456", "autoEnableIO", [dry_run: true])
  end




  ###################
  # Snapshots Tests #
  ###################
  test "describe_snapshots no options" do
    expected = build_query(:describe_snapshots, %{})

    assert expected == EC2.describe_snapshots
  end

  test "describe_snapshots with filters" do
    expected = build_query(:describe_snapshots, %{
      "Filter.1.Name" => "status",
      "Filter.1.Value.1" => "pending",
      "Filter.2.Name" => "tag-value",
      "Filter.2.Value.1" => "*_db_*",
      })

    assert expected == EC2.describe_snapshots(
    [filters: ["status": ["pending"], "tag-value": ["*_db_*"]],
    ])
  end

  test "describe_snapshots with owners" do
    expected = build_query(:describe_snapshots, %{
      "Owner.1" => "TestOwner",
      "Owner.2" => "Bees",
      "Owner.3" => "Oatmeal"
      })

    assert expected == EC2.describe_snapshots([owners: ["TestOwner", "Bees", "Oatmeal"]])
  end

  test "create_snapshot no options" do
    expected = build_query(:create_snapshot, %{
      "VolumeId" => "vol-123456"
      })

    assert expected == EC2.create_snapshot("vol-123456")
  end

  test "create_snapshot with description" do
    expected = build_query(:create_snapshot, %{
      "VolumeId"    => "vol-123456",
      "Description" => "Test Description"
      })

    assert expected == EC2.create_snapshot("vol-123456", [description: "Test Description"])
  end

  test "copy_snapshot with no options" do
    expected = build_query(:copy_snapshot, %{
      "SourceSnapshotId" => "snap-123456",
      "SourceRegion"     => "us-east-1"
      })

    assert expected == EC2.copy_snapshot("snap-123456", "us-east-1")
  end

  test "copy_snapshot with description" do
    expected = build_query(:copy_snapshot, %{
      "SourceSnapshotId" => "snap-123456",
      "SourceRegion" => "us-east-1",
      "Description" => "TestDescription"
      })

    assert expected == EC2.copy_snapshot("snap-123456", "us-east-1", [description: "TestDescription"])
  end

  test "copy_snapshot with destination_region" do
    expected = build_query(:copy_snapshot, %{
      "SourceSnapshotId" => "snap-123456",
      "SourceRegion" => "us-east-1",
      "DestinationRegion" => "us-west-1"
      })

    assert expected == EC2.copy_snapshot("snap-123456", "us-east-1", [destination_region: "us-west-1"])
  end

  test "copy_snapshot with kms_key_id" do
    expected = build_query(:copy_snapshot, %{
      "SourceSnapshotId" => "snap-123456",
      "SourceRegion" => "us-east-1",
      "KmsKeyId" => "TestKmsKeyId"
      })

    assert expected == EC2.copy_snapshot("snap-123456", "us-east-1", [kms_key_id: "TestKmsKeyId"])
  end

  test "copy_snapshot with all optional options" do
    expected = build_query(:copy_snapshot, %{
      "SourceSnapshotId"  => "snap-123456",
      "SourceRegion"      => "us-east-1",
      "KmsKeyId"          => "Test_Kms_Key_Id",
      "DestinationRegion" => "us-west-1",
      "Encrypted"         => true,
      "PresignedUrl"      => "Test_Url",
      "DryRun"            => true
      })

    assert expected == EC2.copy_snapshot("snap-123456", "us-east-1",
      [kms_key_id: "Test_Kms_Key_Id",
       destination_region: "us-west-1",
       encrypted: true,
       presigned_url: "Test_Url",
       dry_run: true])
  end

  test "delete_snapshot with no options" do
    expected = build_query(:delete_snapshot, %{
      "SnapshotId" => "snap-123456"
      })

    assert expected == EC2.delete_snapshot("snap-123456")
  end

  test "delete_snapshot with dry_run" do
    expected = build_query(:delete_snapshot, %{
      "SnapshotId" => "snap-123456",
      "DryRun" => true
      })

    assert expected == EC2.delete_snapshot("snap-123456", [dry_run: true])
  end

  test "describe_snapshot_attribute no options" do
    expected = build_query(:describe_snapshot_attribute, %{
      "SnapshotId" => "snap-123456",
      "Attribute"  => "productCodes"
      })

    assert expected == EC2.describe_snapshot_attribute("snap-123456", "productCodes")
  end

  test "describe_snapshot_attribute dry_run" do
    expected = build_query(:describe_snapshot_attribute, %{
      "SnapshotId" => "snap-123456",
      "Attribute"  => "productCodes",
      "DryRun"     => true
      })

    assert expected == EC2.describe_snapshot_attribute("snap-123456", "productCodes", [dry_run: true])
  end

  test "modify_snapshot_attribute no options" do
    expected = build_query(:modify_snapshot_attribute, %{
      "SnapshotId" => "snap-123456"
      })

    assert expected == EC2.modify_snapshot_attribute("snap-123456")
  end

  test "modify_snapshot_attribute with create_volume_permission" do
    expected = build_query(:modify_snapshot_attribute, %{
      "SnapshotId" => "snap-123456",
      "CreateVolumePermission.Add.1.Group" => "a11",
      "CreateVolumePermission.Remove.1.UserId" => "111122223333"
      })

    assert expected == EC2.modify_snapshot_attribute("snap-123456", [
      create_volume_permission: [
        add: [
          [group: "a11"]
        ],
        remove: [
          [user_id: "111122223333"]
        ]
      ]
    ])
  end

  test "reset_snapshot_attribute no options" do
    expected = build_query(:reset_snapshot_attribute, %{
      "SnapshotId" => "snap-123456",
      "Attribute"  => "description"
    })

    assert expected == EC2.reset_snapshot_attribute("snap-123456", "description")
  end

  ###########################
  # Bundle Tasks Operations #
  ###########################
  test "bundle_instance with no options" do
    expected = build_query(:bundle_instance, %{
      "InstanceId"                => "i-123456",
      "Storage.S3.AWSAccessKeyId" => "TestAwsAccessKeyId",
      "Storage.S3.Bucket"         => "TestBucket",
      "Storage.S3.Prefix"         => "TestPrefix",
      "Storage.S3.UploadPolicy"   => "TestUploadPolicy",
      "Storage.S3.UploadPolicySignature" => "TestUploadPolicySignature"
      })

    assert expected == EC2.bundle_instance("i-123456", "TestAwsAccessKeyId", "TestBucket", "TestPrefix", "TestUploadPolicy", "TestUploadPolicySignature")
  end

  test "cancel_bundle_task with no options" do
    expected = build_query(:cancel_bundle_task, %{
      "BundleId" => "test_bundle_id"
      })
    assert expected == EC2.cancel_bundle_task("test_bundle_id")
  end

  test "cancel_bundle_task with dry_run options" do
    expected = build_query(:cancel_bundle_task, %{
      "BundleId" => "test_bundle_id",
      "DryRun"   => true
      })
    assert expected == EC2.cancel_bundle_task("test_bundle_id", [dry_run: true])
  end

  test "describe_bundle_tasks with no options" do
    expected = build_query(:describe_bundle_tasks, %{})

    assert expected == EC2.describe_bundle_tasks
  end

  test "describe_bundle_tasks with bundle_ids" do
    expected = build_query(:describe_bundle_tasks, %{
      "BundleId.1" => "bun-c1a540a8",
      "BundleId.2" => "bun-1a2b3c4d",
      "BundleId.3" => "bun-12345678"
      })

    assert expected == EC2.describe_bundle_tasks([bundle_ids: ["bun-c1a540a8", "bun-1a2b3c4d", "bun-12345678"]])
  end

  test "describe_bundle_tasks with filters" do
    expected = build_query(:describe_bundle_tasks, %{
      "Filter.1.Name" => "s3-bucket",
      "Filter.1.Value.1" => "myawsbucket",
      "Filter.2.Name" => "state",
      "Filter.2.Value.1" => "completed",
      "Filter.2.Value.2" => "failed"
      })

    assert expected == EC2.describe_bundle_tasks([filters: [
      "s3-bucket": ["myawsbucket"],
      "state": ["completed", "failed"]
    ]])
  end


  ##############
  # Tags Tests #
  ##############
  test "describe_tags" do
    expected = build_query(:describe_tags, %{})

    assert expected == EC2.describe_tags
  end

  test "describe_tags with filters" do
    expected = build_query(:describe_tags, %{
      "Filter.1.Name" => "resource-type",
      "Filter.1.Value.1" => "instance",
      "Filter.1.Value.2" => "snapshot"
      })

    assert expected == EC2.describe_tags(
    [filters: [
      "resource-type": ["instance", "snapshot"]
      ]])
  end

  test "create_tags no options" do
    expected = build_query(:create_tags, %{
      "ResourceId.1" => "ami-1a2b3c4d",
      "ResourceId.2" => "i-1234567890abcdefg",
      "Tag.1.Key" => "webserver",
      "Tag.1.Value" => "",
      "Tag.2.Key" => "stack",
      "Tag.2.Value" => "Production"
      })

    assert expected == EC2.create_tags(
      ["ami-1a2b3c4d", "i-1234567890abcdefg"],
      ["webserver": "", "stack": "Production"])
  end

  test "delete_tags with no options" do
    expected = build_query(:delete_tags, %{
      "ResourceId.1" => "ami-1a2b3c4ed"
      })

    assert expected == EC2.delete_tags(["ami-1a2b3c4ed"])
  end

  test "delete_tags with tags" do
    expected = build_query(:delete_tags, %{
      "ResourceId.1" => "ami-1a2b3c4ed",
      "Tag.1.Key" => "webserver",
      "Tag.1.Value" => "",
      "Tag.2.Key" => "stack",
      "Tag.2.Value" => ""
      })

    assert expected == EC2.delete_tags(
      ["ami-1a2b3c4ed"],
      [tags: ["webserver": "", "stack": ""]])
  end

  test "delete_tags with dry_run" do
    expected = build_query(:delete_tags, %{
      "ResourceId.1" => "ami-1234567",
      "ResourceId.2" => "i-abc123def456",
      "DryRun" => true
      })

    assert expected == EC2.delete_tags(
    ["ami-1234567", "i-abc123def456"], [dry_run: true])
  end

  ########################################
  # Regions and Availability Zones Tests #
  ########################################

  test "describe_availability_zones with zone names" do
    expected = build_query(:describe_availability_zones, %{
      "ZoneName.1" => "us-east-1d",
      "ZoneName.2" => "us-east-1a"
      })

    assert expected == EC2.describe_availability_zones(
      [zone_names: ["us-east-1d", "us-east-1a"]])
  end

  test "describe_regions" do
    expected = build_query(:describe_regions, %{})

    assert expected == EC2.describe_regions
  end

  test "describe_regions with region names" do
    expected = build_query(:describe_regions, %{
      "RegionName.1" => "us-east-1",
      "RegionName.2" => "eu-west-1"
      })

    assert expected == EC2.describe_regions(
      [region_names: ["us-east-1", "eu-west-1"]])
  end

  ######################
  # Resource Ids Tests #
  ######################
  test "describe_id_format" do
    expected = build_query(:describe_id_format, %{})

    assert expected == EC2.describe_id_format
  end

  test "describe_id_format with instance resource" do
    expected = build_query(:describe_id_format, %{
      "Resource" => "instance"
      })

    assert expected == EC2.describe_id_format([resource: "instance"])
  end

  test "modify_id_format" do
    expected = build_query(:modify_id_format, %{
      "Resource" => "instance",
      "UseLongIds" => true
      })

    assert expected == EC2.modify_id_format("instance", true)
  end

  ############################
  # Account Attributes Tests #
  ############################
  test "describe_account_attributes" do
    expected = build_query(:describe_account_attributes, %{})

    assert expected == EC2.describe_account_attributes
  end

  test "describe_account_attributes with attribute name" do
    expected = build_query(:describe_account_attributes, %{
      "AttributeName.1" => "supported-platforms"
      })

    assert expected ==
      EC2.describe_account_attributes([attribute_names: ["supported-platforms"]])
  end


  #############
  # VPC Tests #
  #############

  test "describe_vpcs" do
    expected = build_query(:describe_vpcs, %{})

    assert expected == EC2.describe_vpcs
  end

  test "describe_vpcs with filters" do
    expected = build_query(:describe_vpcs, %{
      "Filter.1.Name" => "options-id",
      "Filter.1.Value.1" => "dopt-7a8b9c2d",
      "Filter.1.Value.2" => "dopt-2b2a3d3c",
      "Filter.2.Name" => "state",
      "Filter.2.Value.1" => "available"
      })

    assert expected == EC2.describe_vpcs(
      filters: ["options-id": ["dopt-7a8b9c2d", "dopt-2b2a3d3c"],
                "state": ["available"]])
  end

  test "describe vpcs with vpc ids" do
    expected = build_query(:describe_vpcs, %{
      "VpcId.1" => "vpc-123456",
      "VpcId.2" => "vpc-a1b2c3"
      })

    assert expected == EC2.describe_vpcs(
      vpc_ids: ["vpc-123456", "vpc-a1b2c3"]
    )
  end

  test "create_vpc" do
    expected = build_query(:create_vpc, %{
      "CidrBlock" => "10.0.0.0/16"
      })

    assert expected == EC2.create_vpc("10.0.0.0/16")
  end

  test "create_vpc with amazon provided cidr block enabled and instance tenancy set" do
    expected = build_query(:create_vpc, %{
      "CidrBlock"                   => "10.0.0.0/16",
      "InstanceTenancy"             => "dedicated",
      "AmazonProvidedIpv6CidrBlock" => true
      })

    assert expected == EC2.create_vpc("10.0.0.0/16",
      [instance_tenancy: "dedicated", amazon_provided_ipv6_cidr_block: true])
  end

  test "delete_vpc" do
    expected = build_query(:delete_vpc, %{
      "VpcId" => "vpc-1a2b3c4d"
      })

    assert expected == EC2.delete_vpc("vpc-1a2b3c4d")
  end

  test "delete_vpc with dry_run" do
    expected = build_query(:delete_vpc, %{
      "VpcId"  => "vpc-1a2b3c4d",
      "DryRun" => true
      })

    assert expected == EC2.delete_vpc("vpc-1a2b3c4d", [dry_run: true])
  end

  test "describe_vpc_attribute" do
    expected = build_query(:describe_vpc_attribute, %{
      "VpcId"     => "vpc-1a2b3c4d",
      "Attribute" => "enableDnsSupport"
      })

    assert expected == EC2.describe_vpc_attribute("vpc-1a2b3c4d", "enableDnsSupport")
  end

  test "modify_vpc_attribute with enable_dns_hostnames and enable_dns_support" do
    expected = build_query(:modify_vpc_attribute, %{
      "VpcId"                     => "vpc-1a2b3c4d",
      "EnableDnsHostnames.Value"  => true,
      "EnableDnsSupport.Value"    => true
    })

    assert expected == EC2.modify_vpc_attribute("vpc-1a2b3c4d",
      [enable_dns_hostnames: true, enable_dns_support: true]
    )
  end

  #################
  # Subnets Tests #
  #################

  test "describe_subnets" do
    expected = build_query(:describe_subnets, %{})

    assert expected == EC2.describe_subnets
  end

  test "describe_subnets filters" do
    expected = build_query(:describe_subnets, %{
      "Filter.1.Name"    => "vpc-id",
      "Filter.1.Value.1" => "vpc-1a2b3c4d",
      "Filter.1.Value.2" => "vpc-6e7f8a92",
      "Filter.2.Name"    => "state",
      "Filter.2.Value.1" => "available"
      })

    assert expected == EC2.describe_subnets([
        filters: [
          "vpc-id": ["vpc-1a2b3c4d", "vpc-6e7f8a92"],
          "state": ["available"]
        ]
      ])
  end

  test "describe_subnets with subnets" do
    expected = build_query(:describe_subnets, %{
      "SubnetId.1" => "subnet-9d4a7b6c",
      "SubnetId.2" => "subnet-6e7f829e"
      })

    assert expected == EC2.describe_subnets([
      subnet_ids: ["subnet-9d4a7b6c", "subnet-6e7f829e"]
      ])
  end

  test "create_subnet" do
    expected = build_query(:create_subnet, %{
      "VpcId"     => "vpc-1a2b3c4d",
      "CidrBlock" => "10.0.1.0/24"
      })

    assert expected == EC2.create_subnet("vpc-1a2b3c4d", "10.0.1.0/24")
  end

  test "create_subnet with an IPv6 CIDR block" do
    expected = build_query(:create_subnet, %{
      "VpcId"         => "vpc-1a2b3c4d",
      "CidrBlock"     => "10.0.1.0/24",
      "Ipv6CidrBlock" => "2001:db8:1234:1a00::/64"
      })

    assert expected == EC2.create_subnet("vpc-1a2b3c4d", "10.0.1.0/24",
        [ipv6_cidr_block: "2001:db8:1234:1a00::/64"])
  end

  test "delete_subnet" do
    expected = build_query(:delete_subnet, %{
      "SubnetId" => "subnet-9d4a7b6c"
      })

    assert expected == EC2.delete_subnet("subnet-9d4a7b6c")
  end

  test "delete_subnet with dry_run" do
    expected = build_query(:delete_subnet, %{
      "SubnetId" => "subnet-9d4a7b6c",
      "DryRun"   => true
      })

    assert expected == EC2.delete_subnet("subnet-9d4a7b6c", [dry_run: true])
  end

  test "modify_subnet_attribute with map_public_ip_on_launch" do
    expected = build_query(:modify_subnet_attribute, %{
      "SubnetId" => "subnet-9d4a7b6c",
      "MapPublicIpOnLaunch.Value" => true
      })

    assert expected == EC2.modify_subnet_attribute("subnet-9d4a7b6c",
      [map_public_ip_on_launch: true])
  end

  test "modify_subnet_attriute with assign_ipv6_address_on_creation" do
    expected = build_query(:modify_subnet_attribute, %{
      "SubnetId" => "subnet-9d4a7b6c",
      "AssignIpv6AddressOnCreation.Value" => true
      })

    assert expected == EC2.modify_subnet_attribute("subnet-9d4a7b6c",
      [assign_ipv6_address_on_creation: true])
  end

  ##################
  # Key Pair Tests #
  ##################

  test "describe_key_pairs" do
    expected = build_query(:describe_key_pairs, %{})

    assert expected == EC2.describe_key_pairs
  end

  test "describe_key_pairs with filters" do
    expected  = build_query(:describe_key_pairs, %{
      "Filter.1.Name"    => "key-name",
      "Filter.1.Value.1" => "*Dave*"
    })

    assert expected == EC2.describe_key_pairs([
      filters: ["key-name": ["*Dave*"]]
      ])
  end

  test "describe_key_pairs with key_names" do
    expected = build_query(:describe_key_pairs, %{
      "KeyName.1" => "test-key-pair",
      "KeyName.2" => "that-key-pair"
      })

    assert expected == EC2.describe_key_pairs([
      key_names: ["test-key-pair", "that-key-pair"]
      ])
  end

  test "create_key_pair with dry_run" do
    expected = build_query(:create_key_pair, %{
      "KeyName" => "test-key-pair",
      "DryRun"  => true
      })

    assert expected == EC2.create_key_pair("test-key-pair",
      [dry_run: true])
  end

  test "delete_key_pair with dry_run" do
    expected = build_query(:delete_key_pair, %{
      "KeyName" => "test-key-pair",
      "DryRun"  => true
      })

    assert expected == EC2.delete_key_pair("test-key-pair",
      [dry_run: true])
  end

  test "import_key_pair no options" do
    expected = build_query(:import_key_pair, %{
      "KeyName" => "test-key-pair",
      "PublicKeyMaterial" => Base.url_encode64("test")
      })

    assert expected == EC2.import_key_pair(
      "test-key-pair",
      Base.url_encode64("test"))
  end

  test "import_key_pair with dry_run" do
    expected = build_query(:import_key_pair, %{
      "KeyName" => "test-key-pair",
      "PublicKeyMaterial" => Base.url_encode64("test"),
      "DryRun" => true
      })

    assert expected == EC2.import_key_pair(
      "test-key-pair", Base.url_encode64("test"),
      [dry_run: true])
  end

  #########################
  # Security Groups Tests #
  #########################
  test "describe_security_groups no options" do
    expected = build_query(:describe_security_groups, %{})

    assert expected == EC2.describe_security_groups
  end

  test "describe_security_groups with group_names" do
    expected = build_query(:describe_security_groups, %{
      "GroupName.1" => "Test",
      "GroupName.2" => "WebServer"
    })

    assert expected == EC2.describe_security_groups(
      [group_names: ["Test", "WebServer"]]
    )
  end

  test "describe_security_groups with filters" do
    expected = build_query(:describe_security_groups, %{
      "Filter.1.Name" => "ip-permission.protocol",
      "Filter.1.Value.1" => "tcp",
      "Filter.2.Name" => "ip-permission.from-port",
      "Filter.2.Value.1" => "22",
      "Filter.3.Name" => "ip-permission.to-port",
      "Filter.3.Value.1" => "22",
      "Filter.4.Name" => "ip-permission.group-name",
      "Filter.4.Value.1" => "app_server_group",
      "Filter.4.Value.2" => "database_group"
    })

    assert expected == EC2.describe_security_groups(
      [filters: ["ip-permission.protocol": ["tcp"],
                 "ip-permission.from-port": ["22"],
                 "ip-permission.to-port": ["22"],
                 "ip-permission.group-name": ["app_server_group", "database_group"]
                 ]
       ])
  end

  test "describe_security_groups with group_ids" do
    expected = build_query(:describe_security_groups, %{
      "GroupId.1" => "sg-9bf6ceff",
      "GroupId.2" => "sg-12345678"
      })

    assert expected == EC2.describe_security_groups(
      [group_ids: ["sg-9bf6ceff", "sg-12345678"]]
    )
  end

  test "create_security_group with no options" do
    expected = build_query(:create_security_group, %{
      "GroupName" => "Test",
      "GroupDescription" => "Test Description"
      })

    assert expected == EC2.create_security_group("Test", "Test Description")
  end

  test "create_security_group with vpc_id" do
    expected = build_query(:create_security_group, %{
      "GroupName" => "Test",
      "GroupDescription" => "Test Description",
      "VpcId" => "vpc-3325caf2"
      })

    assert expected == EC2.create_security_group("Test", "Test Description",
      [vpc_id: "vpc-3325caf2"])
  end

  test "authorize_security_group_ingress with ip_permissions and group_name" do
    expected = build_query(:authorize_security_group_ingress, %{
      "GroupName" => "websrv",
      "IpPermissions.1.IpProtocol" => "tcp",
      "IpPermissions.1.FromPort" => 22,
      "IpPermissions.1.ToPort" => 22,
      "IpPermissions.1.IpRanges.1.CidrIp" => "192.0.2.0/24",
      "IpPermissions.1.IpRanges.2.CidrIp" => "198.51.100.0/24"
    })

    assert expected == EC2.authorize_security_group_ingress([group_name: "websrv",
    ip_permissions: [
      [ip_protocol: "tcp", from_port: 22, to_port: 22, ip_ranges: [
        [cidr_ip: "192.0.2.0/24"], [cidr_ip: "198.51.100.0/24"]
      ]]
    ]])
  end

  test "authorize_security_group_egress with ip_permissions" do
    expected = build_query(:authorize_security_group_egress, %{
      "GroupId" => "sg-9a8d7f5c",
      "IpPermissions.1.IpProtocol" => "udp",
      "IpPermissions.1.FromPort" => 22,
      "IpPermissions.1.ToPort" => 22,
      "IpPermissions.1.Ipv6Ranges.1.CidrIpv6" => "2001:db8:1234:1a00::/64",
      "IpPermissions.1.UserIdGroupPairs.1.GroupId" => "sg-987654",
      "IpPermissions.1.UserIdGroupPairs.1.GroupName" => "test"
      })

    assert expected == EC2.authorize_security_group_egress("sg-9a8d7f5c", [
      ip_permissions: [
        [ip_protocol: "udp", from_port: 22, to_port: 22, ipv6_ranges: [[cidr_ipv6: "2001:db8:1234:1a00::/64"]],
          user_id_group_pairs: [
              [group_id: "sg-987654", group_name: "test"]
          ]
        ]
      ]
    ])
  end

  test "revoke_security_group_ingress with ip_permissions and group_name" do
    expected = build_query(:revoke_security_group_ingress, %{
      "GroupName" => "websrv",
      "IpPermissions.1.IpProtocol" => "tcp",
      "IpPermissions.1.FromPort" => 80,
      "IpPermissions.1.ToPort" => 80,
      "IpPermissions.1.Ipv6Ranges.1.CidrIpv6" => "2001:db8:1234:1a00::/64",
      "IpPermissions.1.Ipv6Ranges.2.CidrIpv6" => "2001:db9:1234:1a00::/64"
    })

    assert expected == EC2.revoke_security_group_ingress([group_name: "websrv",
        ip_permissions: [
            [ip_protocol: "tcp", from_port: 80, to_port: 80, ipv6_ranges: [
              [cidr_ipv6: "2001:db8:1234:1a00::/64"],
              [cidr_ipv6: "2001:db9:1234:1a00::/64"]
            ]]
        ]
      ])
  end

  test "revoke_security_group_egress with cidr_ip" do
    expected = build_query(:revoke_security_group_egress, %{
      "GroupId" => "websrv",
      "CidrIp" => "TestCidrIp"
    })

    assert expected == EC2.revoke_security_group_egress("websrv", [cidr_ip: "TestCidrIp"])
  end
end
