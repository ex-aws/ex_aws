defmodule ExAws.ECSTest do
  use ExUnit.Case, async: true
  alias ExAws.ECS

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
      }]
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
    opts = %{volumes: volumes}

    assert expected_data == ECS.register_task_definition(container_definitions, "fooTask", opts).data

  end
end
