defmodule ExAws.ECSTest do
  use ExUnit.Case, async: true
  alias ExAws.ECS

  # optional, simple parameters are not always present in tests to keep testcode slimmer

  test "#create_cluster" do
    expected_data = %{ "clusterName" => "my_cluster"}
    assert expected_data == ECS.create_cluster("my_cluster").data
  end
  test "#create_service" do
    expected_data = %{
      "deploymentConfiguration" => %{
        "maximumPercent" => 150,
        "minimumHealthyPercent" => 50
      },
      "desiredCount" => 4,
      "loadBalancers" => [
        %{
          "containerName" => "foo",
          "containerPort" => 4000,
          "loadBalancerName" => "alb",
          "targetGroupArn" => "tga"
        }
      ],
      "placementConstraints" => [
        %{
          "expression" => "query",
          "type" => "memberOf"
        }
      ],
      "placementStrategy" => [
        %{
          "field" => "memory",
          "type" => "binpack"
        }
      ],
      "serviceName" => "sname",
      "taskDefinition" => "task_def"
    }
    opts = %{
      deployment_configuration: %{maximum_percent: 150, minimum_healthy_percent: 50},
      load_balancers: [
        %{
          container_name: "foo",
          container_port: 4000,
          load_balancer_name: "alb",
          target_group_arn: "tga"
        }
      ],
      placement_constraints: [
        %{
          expression: "query",
          type: :memberOf
        }
      ],
      placement_strategy: [
        %{
          field: "memory",
          type: :binpack
        }
      ]
    }
    assert expected_data == ECS.create_service("sname", "task_def", 4, opts).data
  end
  test "#delete_attributes" do
    expected_data = %{
      "attributes" => [
        %{
          "name" => "a",
          "targetId" => "b",
          "targetType" => "c",
          "value" => "d"
        }
      ],
      "cluster" => "my_cluster"
    }
    attribute = %{
      name: "a",
      target_id: "b",
      target_type: "c",
      value: "d"
    }
    assert expected_data == ECS.delete_attributes([attribute], "my_cluster").data
  end
  test "#delete_cluster" do
    expected_data = %{"cluster" => "my_cluster"}
    assert expected_data == ECS.delete_cluster("my_cluster").data
  end
  test "#delete_service" do
    expected_data = %{
      "cluster" => "my_cluster",
      "service" => "my_service"
    }
    assert expected_data == ECS.delete_service("my_service", "my_cluster").data
  end
  test "#deregister_container_instance" do
    expected_data = %{
      "cluster" => "my_cluster",
      "containerInstance" => "arn",
      "force" => true
    }
    opts = %{
      cluster: "my_cluster",
      force: true
    }
    assert expected_data == ECS.deregister_container_instance("arn", opts).data
  end
  test "#deregister_task_definition" do
    expected_data = %{
      "taskDefinition" => "task_def"
    }
    assert expected_data == ECS.deregister_task_definition("task_def").data
  end
  test "#describe_clusters" do
    expected_data = %{
      "clusters" => ["default", "my_cluster"]
    }
    assert expected_data == ECS.describe_clusters(["default","my_cluster"]).data
  end
  test "#describe_container_instances" do
    expected_data = %{
      "cluster" => "my_cluster",
      "containerInstances" => ["arn-1", "arn-2"]
    }
    assert expected_data == ECS.describe_container_instances(["arn-1", "arn-2"], "my_cluster").data
  end
  test "#describe_services" do
    expected_data = %{
      "cluster" => "my_cluster",
      "services" => ["svc"]
    }
    assert expected_data == ECS.describe_services(["svc"], "my_cluster").data
  end
  test "#describe_task_definition" do
    expected_data = %{
      "taskDefinition" => "task_def"
    }
    assert expected_data == ECS.describe_task_definition("task_def").data
  end
  test "#describe_tasks" do
    expected_data = %{
      "cluster" => "my_cluster",
      "tasks" => ["task_1", "task_2"]
    }
    assert expected_data == ECS.describe_tasks(["task_1", "task_2"], "my_cluster").data
  end
  test "#list_attributes" do
    expected_data = %{
      "attributeName" => "a",
      "attributeValue" => "b",
      "targetType" => "container-instance"
    }
    opts = %{
      attribute_name: "a",
      attribute_value: "b"
    }
    assert expected_data == ECS.list_attributes(:"container-instance", opts).data
  end
  test "#list_clusters" do
    expected_data = %{
      "maxResults" => 100,
      "nextToken" => "token"
    }
    opts = %{
      max_results: 100,
      next_token: "token"
    }
    assert expected_data == ECS.list_clusters(opts).data
  end
  test "#list_container_instances" do
    expected_data = %{
      "maxResults" => 1,
      "status" => "DRAINING"
    }
    opts = %{
      max_results: 1,
      status: :DRAINING
    }
    assert expected_data == ECS.list_container_instances(opts).data
  end
  test "#list_services" do
    expected_data = %{}
    assert expected_data == ECS.list_services().data
  end
  test "#list_task_definition_families" do
    expected_data = %{
      "status" => "INACTIVE"
    }
    opts = %{
      status: :INACTIVE
    }
    assert expected_data == ECS.list_task_definitions(opts).data
  end
  test "#list_task_definitions" do
    expected_data = %{
     "cluster" => "my_cluster",
     "containerInstance" => "i-123",
     "desiredStatus" => "ACTIVE",
     "family" => "taskFamily",
     "maxResults" => 4,
     "nextToken" => "next",
     "serviceName" => "service_1",
     "startedBy" => "me"
    }
    opts = %{
      cluster: "my_cluster",
      container_instance: "i-123",
      desired_status: :ACTIVE,
      family: "taskFamily",
      max_results: 4,
      next_token: "next",
      service_name: "service_1",
      started_by: "me"
    }
    assert expected_data == ECS.list_tasks(opts).data
  end
  test "#list_tasks" do
    expected_data = %{
      "desiredStatus" => "STOPPED",
    }
    opts = %{
      desired_status: :STOPPED
    }
    assert expected_data == ECS.list_tasks(opts).data
  end
  test "#put_attributes" do
    expected_data = %{
      "attributes" => [
        %{
           "name" => "attr-name",
        }
      ]
    }
    attribute = %{
      name: "attr-name"
    }
    assert expected_data == ECS.put_attributes([attribute]).data
  end
 test "#register_task_definition" do
    expected_data = %{"containerDefinitions" => [
      %{
        "command" => ["iex","-S","mix"],
        "cpu" => 512,
        "disableNetworking" => false,
        "dockerLabels" => %{
          "Dlabel"  => "baz"
        },
        "environment" => [
          %{
            "name" => "MIX_ENV",
            "value" => "prod"
          },
          %{
            "name" => "DATABASE",
            "value" => "postgres://hello:world@bigdb.foo.com"
          },
        ],
        "logConfiguration" => %{
          "logDriver" => "json-file",
          "options" => %{
             "fishy-location"  => "/foo.json"
          }
        },
        "mountPoints" => [
          %{
            "containerPath" => "/tmp",
            "readOnly" => true,
            "sourceVolume" => "tmpvolume"
          }
        ],
        "name" => "foobar",
        "portMappings" => [
         %{
            "containerPort" => 4000,
            "hostPort" => 0,
            "protocol" => "tcp"
          }
        ]
      }
    ],
    "family" => "fooTask",
    "volumes" => [
      %{
        "host" => %{
          "sourcePath" => "/instancetmp"
        },
        "name" => "tmpvolume"
      }],
    "placementConstraints" => [
        %{"expression" => "complex query", "type" => "memberOf"},
        %{"expression" => "simple query", "type" => "distinctInstance"}
      ]
    }

    container_definitions = [
      %{
        command: ["iex", "-S", "mix"],
        cpu: 512,
        disable_networking: false,
        docker_labels: %{"Dlabel" => "baz"},
        environment: [
          %{name: "MIX_ENV", value: "prod"},
          %{name: "DATABASE", value: "postgres://hello:world@bigdb.foo.com" }
        ],
        log_configuration: %{
          log_driver: :"json-file",
          options: %{"fishy-location" => "/foo.json"},
        },
        mount_points: [
          %{
            container_path: "/tmp",
            read_only: true,
            source_volume:  "tmpvolume"
          }
        ],
        name: "foobar",
        port_mappings: [
          %{
            container_port: 4000,
            host_port: 0,
            protocol: :tcp
          }
        ]
      }
    ]
    volumes = [
      %{
        host: %{source_path: "/instancetmp"},
        name: "tmpvolume"
      }
    ]
    placement_constraints = [
      %{expression: "complex query", type: :memberOf},
      %{expression: "simple query", type: :distinctInstance}
    ]
    opts = %{volumes: volumes, placement_constraints: placement_constraints}

    assert expected_data == ECS.register_task_definition(container_definitions, "fooTask", opts).data
  end
  test "#run_task" do
    expected_data = %{
      "taskDefinition" => "task_def",
      "overrides" => %{
        "containerOverrides" => [
          %{
            "command" => ["rm", "-rf"],
            "environment" => [
              %{
                "name" => "MIX_ENV",
                "value" => "prod"
              }
            ],
            "name" => "my_container"
          }
        ],
        "taskRoleArn" => "arn:"
      },
      "placementConstraints" => [
        %{
          "expression" => "foo",
          "type" => "distinctInstance"
        }
      ],
      "placementStrategy" => [
        %{
          "type" => "random"
        }
      ]
    }
    opts = %{
      overrides: %{
        container_overrides: [
          %{
            command: ["rm","-rf"],
            environment: [
              %{name: "MIX_ENV", value: "prod"}
            ],
            name: "my_container"
          }
        ],
        task_role_arn: "arn:"
      },
      placement_constraints: [
        %{
          expression: "foo",
          type: :distinctInstance
        }
      ],
      placement_strategy: [
        %{
          type: :random
        }
      ]
    }
    assert expected_data == ECS.run_task("task_def", opts).data
  end
  test "#start_task" do
    expected_data = %{
      "containerInstances" => ["ec2_1","ec2_2"],
      "taskDefinition" => "task_def"
    }
    assert expected_data == ECS.start_task("task_def", ["ec2_1","ec2_2"]).data
  end
  test "#stop_task" do
    expected_data = %{
      "cluster" => "my_cluster",
      "reason" => "terminator",
      "task" => "my_task"
    }
    opts = %{
      cluster: "my_cluster",
      reason: "terminator"
    }
    assert expected_data == ECS.stop_task("my_task", opts).data
  end
  test "#update_container_agent" do
    expected_data = %{
      "containerInstance" => "arn::",
      "cluster" => "my_cluster"
    }
    assert expected_data == ECS.update_container_agent("arn::", "my_cluster").data
  end
  test "#update_container_instances_state" do
    expected_data = %{
      "containerInstances" => ["1", "2"],
      "status" => "DRAINING"
    }
    assert expected_data == ECS.update_container_instances_state(["1","2"], :DRAINING).data
  end
  test "#update_service" do
    expected_data = %{
      "deploymentConfiguration" => %{
        "maximumPercent" => 300,
        "minimumHealthyPercent" => 100
      },
      "desiredCount" => 5,
      "service" => "svc_1",
      "taskDefinition" => "tdef_1"
    }
    opts = [
      deployment_configuration: %{maximum_percent: 300, minimum_healthy_percent: 100},
      desired_count: 5,
      task_definition: "tdef_1"
    ]
    assert expected_data == ECS.update_service("svc_1", opts).data
  end

  test "header x-amz-target" do
    headers = ECS.list_task_definitions().headers
    assert  Enum.any?(headers, (&(&1 == {"x-amz-target","AmazonEC2ContainerServiceV20141113.ListTaskDefinitions"})))
  end


end
