# Note that these lists are the CONTROL regions (since those are where we can hit the API),
# not the MEDIA regions.
# See https://docs.aws.amazon.com/general/latest/gr/chime-sdk.htm
chime_identity_regions = [
  "eu-central-1",
  "us-east-1"
]

chime_meeting_regions = [
  "ap-south-1",
  "ap-south-2",
  "ap-northeast-1",
  "ap-northeast-2",
  "ap-southeast-1",
  "ap-southeast-2",
  "ca-central-1",
  "eu-central-1",
  "eu-west-2",
  "il-central-1",
  "us-gov-east-1",
  "us-gov-west-1",
  "us-east-1",
  "us-west-2"
]

chime_media_pipeline_regions = [
  "ap-southeast-1",
  "eu-central-1",
  "us-east-1",
  "us-west-2"
]

chime_messaging_regions = [
  "eu-central-1",
  "us-east-1"
]

chime_voice_regions = [
  "ap-nottheast-1",
  "ap-nottheast-2",
  "ap-southeast-1",
  "ap-southeast-2",
  "ca-central-1",
  "eu-central-1",
  "eu-west-1",
  "eu-west-2",
  "us-east-1",
  "us-west-2"
]

%{
  "partitions" => [
    %{
      "defaults" => %{
        "hostname" => "{service}.{region}.{dnsSuffix}",
        "protocols" => ["https"],
        "signatureVersions" => ["v4"]
      },
      "dnsSuffix" => "amazonaws.com",
      "partition" => "aws",
      "partitionName" => "AWS Standard",
      "regionRegex" => "^(us|eu|af|ap|sa|ca|me)\\-\\w+\\-\\d+$",
      "regions" => %{
        "af-south-1" => %{"description" => "Africa (Cape Town)"},
        "ap-northeast-1" => %{"description" => "Asia Pacific (Tokyo)"},
        "ap-northeast-2" => %{"description" => "Asia Pacific (Seoul)"},
        "ap-east-1" => %{"description" => "Asia Pacific (Hong Kong)"},
        "ap-south-1" => %{"description" => "Asia Pacific (Mumbai)"},
        "ap-south-2" => %{"description" => "Asia Pacific (Hyderabad)"},
        "ap-southeast-1" => %{"description" => "Asia Pacific (Singapore)"},
        "ap-southeast-2" => %{"description" => "Asia Pacific (Sydney)"},
        "ap-southeast-3" => %{"description" => "Asia Pacific (Jakarta)"},
        "ca-central-1" => %{"description" => "Canada (Montreal)"},
        "ca-west-1" => %{"description" => "Canada (Calgary)"},
        "eu-central-1" => %{"description" => "EU (Frankfurt)"},
        "eu-west-1" => %{"description" => "EU (Ireland)"},
        "eu-west-2" => %{"description" => "EU (London)"},
        "eu-west-3" => %{"description" => "EU (Paris)"},
        "eu-north-1" => %{"description" => "EU (Stockholm)"},
        "eu-south-1" => %{"description" => "EU (Milan)"},
        "eu-south-2" => %{"description" => "EU (Spain)"},
        "me-south-1" => %{"description" => "Middle East (Bahrain)"},
        "sa-east-1" => %{"description" => "South America (Sao Paulo)"},
        "us-east-1" => %{"description" => "US East (N. Virginia)"},
        "us-east-2" => %{"description" => "US East (Ohio)"},
        "us-west-1" => %{"description" => "US West (N. California)"},
        "us-west-2" => %{"description" => "US West (Oregon)"}
      },
      "services" => %{
        "personalize" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-west-1" => %{},
            "eu-central-1" => %{}
          }
        },
        "personalize-events" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-west-1" => %{},
            "eu-central-1" => %{}
          }
        },
        "personalize-runtime" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-west-1" => %{},
            "eu-central-1" => %{}
          }
        },
        "bedrock" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-northeast-3" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "eu-south-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "bedrock-runtime" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-northeast-3" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "eu-south-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "bedrock-agent" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "bedrock-agent-runtime" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "connect" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "codeartifact" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-central-1" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{}
          }
        },
        "firehose" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "me-central-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "organizations" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "organizations.us-east-1.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "serverlessrepo" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{"protocols" => ["https"]},
            "ap-northeast-2" => %{"protocols" => ["https"]},
            "ap-south-1" => %{"protocols" => ["https"]},
            "ap-south-2" => %{"protocols" => ["https"]},
            "ap-southeast-1" => %{"protocols" => ["https"]},
            "ap-southeast-2" => %{"protocols" => ["https"]},
            "ca-central-1" => %{"protocols" => ["https"]},
            "eu-central-1" => %{"protocols" => ["https"]},
            "eu-west-1" => %{"protocols" => ["https"]},
            "eu-west-2" => %{"protocols" => ["https"]},
            "eu-north-1" => %{"protocols" => ["https"]},
            "sa-east-1" => %{"protocols" => ["https"]},
            "us-east-1" => %{"protocols" => ["https"]},
            "us-east-2" => %{"protocols" => ["https"]},
            "us-west-1" => %{"protocols" => ["https"]},
            "us-west-2" => %{"protocols" => ["https"]}
          }
        },
        "elasticache" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-east-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "config" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "mobiletargeting" => %{
          "endpoints" => %{
            "us-east-1" => %{
              "hostname" => "pinpoint.us-east-1.amazonaws.com"
            },
            "us-east-2" => %{
              "hostname" => "pinpoint.us-east-2.amazonaws.com"
            },
            "us-west-1" => %{
              "hostname" => "pinpoint.us-west-1.amazonaws.com"
            },
            "us-west-2" => %{
              "hostname" => "pinpoint.us-west-2.amazonaws.com"
            },
            "ap-south-1" => %{
              "hostname" => "pinpoint.ap-south-1.amazonaws.com"
            },
            "ap-south-2" => %{
              "hostname" => "pinpoint.ap-south-2.amazonaws.com"
            },
            "ap-northeast-1" => %{
              "hostname" => "pinpoint.ap-northeast-1.amazonaws.com"
            },
            "ap-northeast-2" => %{
              "hostname" => "pinpoint.ap-northeast-2.amazonaws.com"
            },
            "ap-southeast-1" => %{
              "hostname" => "pinpoint.ap-southeast-1.amazonaws.com"
            },
            "ap-southeast-2" => %{
              "hostname" => "pinpoint.ap-southeast-2.amazonaws.com"
            },
            "ca-central-1" => %{
              "hostname" => "pinpoint.ca-central-1.amazonaws.com"
            },
            "eu-central-1" => %{
              "hostname" => "pinpoint.eu-central-1.amazonaws.com"
            },
            "eu-west-1" => %{
              "hostname" => "pinpoint.eu-west-1.amazonaws.com"
            },
            "eu-west-2" => %{
              "hostname" => "pinpoint.eu-west-2.amazonaws.com"
            }
          }
        },
        "pinpoint" => %{
          "defaults" => %{"credentialScope" => %{"service" => "mobiletargeting"}},
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{}
          }
        },
        "iam" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "iam.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "gamelift" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "snowball" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "glacier" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ingest.timestream" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-west-1" => %{}
          }
        },
        "query.timestream" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-west-1" => %{}
          }
        },
        "translate" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-central-1" => %{}
          }
        },
        "acm" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "elasticmapreduce" => %{
          "defaults" => %{
            "protocols" => ["http", "https"],
            "sslCommonName" => "{region}.{service}.{dnsSuffix}"
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{"sslCommonName" => "{service}.{region}.{dnsSuffix}"},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"sslCommonName" => "{service}.{region}.{dnsSuffix}"},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "workdocs" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "marketplacecommerceanalytics" => %{"endpoints" => %{"us-east-1" => %{}}},
        "logs" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "kinesis" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "neptune" => %{
          "endpoints" => %{
            "eu-west-1" => %{
              "credentialScope" => %{"region" => "eu-west-1"},
              "hostname" => "rds.eu-west-1.amazonaws.com"
            },
            "us-east-1" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "rds.us-east-1.amazonaws.com"
            },
            "us-east-2" => %{
              "credentialScope" => %{"region" => "us-east-2"},
              "hostname" => "rds.us-east-2.amazonaws.com"
            },
            "us-west-2" => %{
              "credentialScope" => %{"region" => "us-west-2"},
              "hostname" => "rds.us-west-2.amazonaws.com"
            }
          }
        },
        "events" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "scheduler" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "guardduty" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          },
          "isRegionalized" => true
        },
        "importexport" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1", "service" => "IngestionService"},
              "hostname" => "importexport.amazonaws.com",
              "signatureVersions" => ["v2", "v4"]
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "greengrass" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          },
          "isRegionalized" => true
        },
        "sns" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "health" => %{"endpoints" => %{"us-east-1" => %{}}},
        "glue" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "lightsail" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "polly" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "lambda" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-central-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "dynamodb" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "local" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "localhost:8000",
              "protocols" => ["http"]
            },
            "me-central-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "streams.dynamodb" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "dynamodb"},
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "local" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "localhost:8000",
              "protocols" => ["http"]
            },
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "fms" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{"us-east-1" => %{}, "us-west-2" => %{}}
        },
        "es" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "aoss" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "session.qldb" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "shield" => %{
          "defaults" => %{
            "protocols" => ["https"],
            "sslCommonName" => "Shield.us-east-1.amazonaws.com"
          },
          "endpoints" => %{"us-east-1" => %{}},
          "isRegionalized" => false
        },
        "monitoring" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "clouddirectory" => %{
          "endpoints" => %{
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "workspaces" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "elasticloadbalancing" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "mturk-requester" => %{
          "endpoints" => %{
            "sandbox" => %{"hostname" => "mturk-requester-sandbox.us-east-1.amazonaws.com"},
            "us-east-1" => %{}
          },
          "isRegionalized" => false
        },
        "sagemaker" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "devicefarm" => %{"endpoints" => %{"us-west-2" => %{}}},
        "athena" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "api.mediatailor" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{}
          }
        },
        "mobileanalytics" => %{"endpoints" => %{"us-east-1" => %{}}},
        "api.pricing" => %{
          "defaults" => %{"credentialScope" => %{"service" => "pricing"}},
          "endpoints" => %{"ap-south-1" => %{}, "us-east-1" => %{}}
        },
        "mediaconvert" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "resource-groups" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "metering.marketplace" => %{
          "defaults" => %{"credentialScope" => %{"service" => "aws-marketplace"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ivs" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ec2" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "opsworks-cm" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "sdb" => %{
          "defaults" => %{"protocols" => ["http", "https"], "signatureVersions" => ["v2"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"hostname" => "sdb.amazonaws.com"},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ce" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "ce.us-east-1.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "bcm-data-exports" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "bcm-data-exports.us-east-1.api.aws"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "ds" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "autoscaling-plans" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "autoscaling-plans"},
            "hostname" => "autoscaling.{region}.amazonaws.com",
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{
            "ap-southeast-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "apigateway" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "route53" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "route53.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "kms" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-southeast-3" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-south-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-central-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-1-fips" => %{
              "hostname" => "kms-fips.us-east-1.amazonaws.com",
              "credentialScope" => %{"region" => "us-east-1"}
            },
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "elastictranscoder" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "entitlement.marketplace" => %{
          "defaults" => %{"credentialScope" => %{"service" => "aws-marketplace"}},
          "endpoints" => %{"us-east-1" => %{}}
        },
        "sms" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "rds" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-southeast-3" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-south-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-central-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"sslCommonName" => "{service}.{dnsSuffix}"},
            "us-east-1-fips" => %{
              "sslCommonName" => "{service}.{dnsSuffix}",
              "hostname" => "rds-fips.us-east-1.amazonaws.com",
              "credentialScope" => %{"region" => "us-east-1"}
            },
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cognito-sync" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "budgets" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "budgets.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "servicecatalog" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "quicksight" => %{
          "endpoints" => %{
            "us-east-2" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-northeast-1" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{}
          }
        },
        "cloudtrail" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "opsworks" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "appstream2" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "appstream"},
            "protocols" => ["https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "machinelearning" => %{"endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}}},
        "ssm" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ssm-incidents" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ssm-contacts" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "servicediscovery" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "dax" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ecr" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "eks" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cognito-idp" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "sa-east-1" => %{}
          }
        },
        "runtime.sagemaker" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "me-south-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{},
            "sa-east-1" => %{}
          }
        },
        "a2i-runtime.sagemaker" => %{
          "endpoints" => %{
            "us-east-2" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-northeast-1" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{}
          }
        },
        "cloudhsm" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "a4b" => %{"endpoints" => %{"us-east-1" => %{}}},
        "iot" => %{
          "defaults" => %{"credentialScope" => %{"service" => "execute-api"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "waf-regional" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "rekognition" => %{
          "endpoints" => %{
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        # Deprecated - will not work after 2024-06-29:
        "chime" => %{
          "endpoints" => %{
            "aws-global" => %{
              "hostname" => "service.chime.aws.amazon.com",
              "signatureVersions" => ["v2", "v3", "v4"]
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "chime-sdk-identity" => %{
          "defaults" => %{"signatureVersions" => ["v4"]},
          "endpoints" =>
            Enum.map(
              chime_identity_regions,
              &{&1, %{"hostname" => "identity-chime.#{&1}.amazonaws.com"}}
            )
            |> Map.new()
        },
        "chime-sdk-media-pipelines" => %{
          "defaults" => %{"signatureVersions" => ["v4"]},
          "endpoints" =>
            Enum.map(
              chime_media_pipeline_regions,
              &{&1, %{"hostname" => "media-pipelines-chime.#{&1}.amazonaws.com"}}
            )
            |> Map.new()
        },
        "chime-sdk-meetings" => %{
          "defaults" => %{"signatureVersions" => ["v4"]},
          "endpoints" =>
            Enum.map(
              chime_meeting_regions,
              &{&1, %{"hostname" => "meetings-chime.#{&1}.amazonaws.com"}}
            )
            |> Map.new()
        },
        "chime-sdk-messaging" => %{
          "defaults" => %{"signatureVersions" => ["v4"]},
          "endpoints" =>
            Enum.map(
              chime_messaging_regions,
              &{&1, %{"hostname" => "messaging-chime.#{&1}.amazonaws.com"}}
            )
            |> Map.new()
        },
        "chime-sdk-voice" => %{
          "defaults" => %{"signatureVersions" => ["v4"]},
          "endpoints" =>
            Enum.map(
              chime_voice_regions,
              &{&1, %{"hostname" => "voice-chime.#{&1}.amazonaws.com"}}
            )
            |> Map.new()
        },
        "s3" => %{
          "defaults" => %{"protocols" => ["http", "https"], "signatureVersions" => ["s3v4"]},
          "endpoints" => %{
            "ap-northeast-1" => %{
              "hostname" => "s3.ap-northeast-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{
              "hostname" => "s3.ap-southeast-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ap-southeast-2" => %{
              "hostname" => "s3.ap-southeast-2.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ap-southeast-3" => %{
              "hostname" => "s3.ap-southeast-3.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "af-south-1" => %{
              "hostname" => "s3.af-south-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{
              "hostname" => "s3.eu-west-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "eu-south-1" => %{},
            "eu-south-2" => %{
              "hostname" => "s3.eu-south-2.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "il-central-1" => %{},
            "me-central-1" => %{},
            "me-south-1" => %{},
            "s3-external-1" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "s3-external-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "sa-east-1" => %{
              "hostname" => "s3.sa-east-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-east-1-fips" => %{
              "hostname" => "s3-fips.us-east-1.amazonaws.com",
              "credentialScope" => %{"region" => "us-east-1"}
            },
            "us-east-1" => %{
              "hostname" => "s3.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-east-2" => %{},
            "us-west-1" => %{
              "hostname" => "s3.us-west-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-west-2" => %{
              "hostname" => "s3.us-west-2.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            }
          },
          "isRegionalized" => true,
          "partitionEndpoint" => "us-east-1"
        },
        "elasticbeanstalk" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "datapipeline" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "medialive" => %{
          "endpoints" => %{
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "sa-east-1" => %{}
          }
        },
        "discovery" => %{"endpoints" => %{"us-west-2" => %{}}},
        "application-autoscaling" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "application-autoscaling"},
            "hostname" => "autoscaling.{region}.amazonaws.com",
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "sts" => %{
          "defaults" => %{
            "credentialScope" => %{"region" => "us-east-1"},
            "hostname" => "sts.amazonaws.com"
          },
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{
              "credentialScope" => %{"region" => "ap-northeast-2"},
              "hostname" => "sts.ap-northeast-2.amazonaws.com"
            },
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-southeast-3" => %{},
            "aws-global" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-south-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "me-central-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "sts-fips.us-east-1.amazonaws.com"
            },
            "us-east-2" => %{},
            "us-east-2-fips" => %{
              "credentialScope" => %{"region" => "us-east-2"},
              "hostname" => "sts-fips.us-east-2.amazonaws.com"
            },
            "us-west-1" => %{},
            "us-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-west-1"},
              "hostname" => "sts-fips.us-west-1.amazonaws.com"
            },
            "us-west-2" => %{},
            "us-west-2-fips" => %{
              "credentialScope" => %{"region" => "us-west-2"},
              "hostname" => "sts-fips.us-west-2.amazonaws.com"
            }
          },
          "partitionEndpoint" => "aws-global"
        },
        "sqs" => %{
          "defaults" => %{
            "protocols" => ["http", "https"],
            "sslCommonName" => "{region}.queue.{dnsSuffix}"
          },
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "fips-us-east-1" => %{},
            "fips-us-east-2" => %{},
            "fips-us-west-1" => %{},
            "fips-us-west-2" => %{},
            "me-central-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"sslCommonName" => "queue.{dnsSuffix}"},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "comprehend" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-northeast-1" => %{},
            "ca-central-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "textract" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "us-east-2" => %{},
            "us-east-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{},
            "ca-central-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{}
          }
        },
        "waf" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "waf.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "codecommit" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cur" => %{"endpoints" => %{"us-east-1" => %{}}},
        "workmail" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "tagging" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "redshift" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "redshift-data" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "email" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "me-south-1" => %{}
          }
        },
        "storagegateway" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "kinesisanalytics" => %{
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "autoscaling" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cloudhsmv2" => %{
          "defaults" => %{"credentialScope" => %{"service" => "cloudhsm"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-north-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "runtime.lex" => %{
          "defaults" => %{"credentialScope" => %{"service" => "lex"}},
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "cloud9" => %{
          "endpoints" => %{
            "ap-southeast-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "data.iot" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "iotdata"},
            "protocols" => ["https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "xray" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "mediastore" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "acm-pca" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "fsx" => %{
          "endpoints" => %{
            "us-east-2" => %{},
            "us-east-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{},
            "af-south-1" => %{},
            "ap-east-1" => %{},
            "ap-southeast-3" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-northeast-3" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-northeast-1" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-south-1" => %{},
            "eu-west-3" => %{},
            "eu-south-2" => %{},
            "eu-north-1" => %{},
            "eu-central-2" => %{},
            "me-south-1" => %{},
            "me-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "elasticfilesystem" => %{
          "endpoints" => %{
            "ap-northeast-2" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "secretsmanager" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "kinesisvideo" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-central-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "eu-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "mgh" => %{"endpoints" => %{"us-west-2" => %{}}},
        "support" => %{"endpoints" => %{"us-east-1" => %{}}},
        "codepipeline" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "dms" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "codedeploy" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "codestar" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "route53domains" => %{"endpoints" => %{"us-east-1" => %{}}},
        "states" => %{
          "endpoints" => %{
            "ap-east-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "ecs" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cognito-identity" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "directconnect" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cloudformation" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-central-2" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "inspector" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "cloudsearch" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "batch" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-north-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "swf" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "transcribe" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-east-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-north-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "mediapackage" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "models.lex" => %{
          "defaults" => %{"credentialScope" => %{"service" => "lex"}},
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "codebuild" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "ca-west-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "codebuild-fips.us-east-1.amazonaws.com"
            },
            "us-east-2" => %{},
            "us-east-2-fips" => %{
              "credentialScope" => %{"region" => "us-east-2"},
              "hostname" => "codebuild-fips.us-east-2.amazonaws.com"
            },
            "us-west-1" => %{},
            "us-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-west-1"},
              "hostname" => "codebuild-fips.us-west-1.amazonaws.com"
            },
            "us-west-2" => %{},
            "us-west-2-fips" => %{
              "credentialScope" => %{"region" => "us-west-2"},
              "hostname" => "codebuild-fips.us-west-2.amazonaws.com"
            }
          }
        },
        "cloudfront" => %{
          "endpoints" => %{
            "aws-global" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "cloudfront.amazonaws.com",
              "protocols" => ["http", "https"]
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-global"
        },
        "qldb" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "places.geo" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-north-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "maps.geo" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-north-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "geofencing.geo" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-north-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "tracking.geo" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-north-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "routes.geo" => %{
          "endpoints" => %{
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{},
            "eu-north-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "sa-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "sso" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "pipes" => %{
          "endpoints" => %{
            "af-south-1" => %{},
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-east-1" => %{},
            "ap-south-1" => %{},
            "ap-south-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ap-southeast-3" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "eu-west-3" => %{},
            "eu-north-1" => %{},
            "eu-south-1" => %{},
            "me-south-1" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        }
      }
    },
    %{
      "defaults" => %{
        "hostname" => "{service}.{region}.{dnsSuffix}",
        "protocols" => ["https"],
        "signatureVersions" => ["v4"]
      },
      "dnsSuffix" => "amazonaws.com.cn",
      "partition" => "aws-cn",
      "partitionName" => "AWS China",
      "regionRegex" => "^cn\\-\\w+\\-\\d+$",
      "regions" => %{
        "cn-north-1" => %{"description" => "China (Beijing)"},
        "cn-northwest-1" => %{"description" => "China (Ningxia)"}
      },
      "services" => %{
        "personalize" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "personalize-runtime" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "personalize-events" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "elasticache" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "config" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "iam" => %{
          "endpoints" => %{
            "aws-cn-global" => %{
              "credentialScope" => %{"region" => "cn-north-1"},
              "hostname" => "iam.cn-north-1.amazonaws.com.cn"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-cn-global"
        },
        "snowball" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "glacier" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "elasticmapreduce" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "logs" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "kinesis" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "events" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "sns" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "lambda" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "dynamodb" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "streams.dynamodb" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "dynamodb"},
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "es" => %{"endpoints" => %{"cn-northwest-1" => %{}}},
        "aoss" => %{"endpoints" => %{"cn-northwest-1" => %{}}},
        "monitoring" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "elasticloadbalancing" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "ec2" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "apigateway" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "sms" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "rds" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "cloudtrail" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "ssm" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "ecr" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "iot" => %{
          "defaults" => %{"credentialScope" => %{"service" => "execute-api"}},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "chime" => %{"endpoints" => %{"defaults" => %{}}},
        "s3" => %{
          "defaults" => %{"protocols" => ["http", "https"], "signatureVersions" => ["s3v4"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "elasticbeanstalk" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "application-autoscaling" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "application-autoscaling"},
            "hostname" => "autoscaling.{region}.amazonaws.com",
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "sts" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "sqs" => %{
          "defaults" => %{
            "protocols" => ["http", "https"],
            "sslCommonName" => "{region}.queue.{dnsSuffix}"
          },
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "tagging" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "redshift" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "redshift-data" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "storagegateway" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "autoscaling" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}
        },
        "data.iot" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "iotdata"},
            "protocols" => ["https"]
          },
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "codedeploy" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "ecs" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "cognito-identity" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "directconnect" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "cloudformation" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}},
        "swf" => %{"endpoints" => %{"cn-north-1" => %{}, "cn-northwest-1" => %{}}}
      }
    },
    %{
      "defaults" => %{
        "hostname" => "{service}.{region}.{dnsSuffix}",
        "protocols" => ["https"],
        "signatureVersions" => ["v4"]
      },
      "dnsSuffix" => "amazonaws.com",
      "partition" => "aws-us-gov",
      "partitionName" => "AWS GovCloud (US)",
      "regionRegex" => "^us\\-gov\\-\\w+\\-\\d+$",
      "regions" => %{
        "us-gov-east-1" => %{"description" => "AWS GovCloud (US-East)"},
        "us-gov-west-1" => %{"description" => "AWS GovCloud (US-West)"}
      },
      "services" => %{
        "bedrock" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{},
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "bedrock-fips.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1" => %{},
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "bedrock-fips.us-gov-west-1.amazonaws.com"
            }
          }
        },
        "bedrock-runtime" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "us-gov-east-1" => %{},
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "bedrock-runtime-fips.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1" => %{},
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "bedrock-runtime-fips.us-gov-west-1.amazonaws.com"
            }
          }
        },
        "bedrock-agent" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "us-gov-east-1" => %{},
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "bedrock-agent-fips.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1" => %{},
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "bedrock-agent-fips.us-gov-west-1.amazonaws.com"
            }
          }
        },
        "bedrock-agent-runtime" => %{
          "defaults" => %{"credentialScope" => %{"service" => "bedrock"}},
          "endpoints" => %{
            "us-gov-east-1" => %{},
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "bedrock-agent-runtime-fips.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1" => %{},
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "bedrock-agent-runtime-fips.us-gov-west-1.amazonaws.com"
            }
          }
        },
        "elasticache" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "fsx" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "fsx-fips.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "fsx-fips.us-gov-west-1.amazonaws.com"
            }
          }
        },
        "config" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "iam" => %{
          "endpoints" => %{
            "aws-us-gov-global" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "iam.us-gov.amazonaws.com"
            }
          },
          "isRegionalized" => false,
          "partitionEndpoint" => "aws-us-gov-global"
        },
        "snowball" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "glacier" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "acm" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "elasticmapreduce" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "logs" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "kinesis" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "events" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "sns" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "polly" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "lambda" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "dynamodb" => %{
          "endpoints" => %{
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "dynamodb.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "dynamodb.us-gov-west-1.amazonaws.com"
            },
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "streams.dynamodb" => %{
          "defaults" => %{"credentialScope" => %{"service" => "dynamodb"}},
          "endpoints" => %{
            "us-gov-east-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "dynamodb.us-gov-east-1.amazonaws.com"
            },
            "us-gov-west-1-fips" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "dynamodb.us-gov-west-1.amazonaws.com"
            },
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        },
        "es" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "aoss" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "monitoring" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "elasticloadbalancing" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "metering.marketplace" => %{
          "defaults" => %{"credentialScope" => %{"service" => "aws-marketplace"}},
          "endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}
        },
        "ec2" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "apigateway" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "kms" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{
              "hostname" => "kms-fips.us-gov-east-1.amazonaws.com",
              "credentialScope" => %{"region" => "us-gov-east-1"}
            },
            "us-gov-west-1" => %{
              "hostname" => "kms-fips.us-gov-west-1.amazonaws.com",
              "credentialScope" => %{"region" => "us-gov-west-1"}
            }
          }
        },
        "sms" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "rds" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "cloudtrail" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "ssm" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "ecr" => %{
          "endpoints" => %{
            "fips-us-gov-east-1" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "ecr-fips.us-gov-east-1.amazonaws.com"
            },
            "fips-us-gov-west_fips-1" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "ecr-fips.us-gov-west-1.amazonaws.com"
            },
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "cloudhsm" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "rekognition" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "chime" => %{"endpoints" => %{"defaults" => %{}}},
        "s3" => %{
          "defaults" => %{"signatureVersions" => ["s3", "s3v4"]},
          "endpoints" => %{
            "fips-us-gov-east-1" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "s3-fips.us-gov-east-1.amazonaws.com"
            },
            "fips-us-gov-west-1" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "s3-fips.us-gov-west-1.amazonaws.com"
            },
            "us-gov-east-1" => %{
              "hostname" => "s3-fips.us-gov-east-1.amazonaws.com",
              "protocols" => ["http", "https"]
            },
            "us-gov-west-1" => %{
              "hostname" => "s3-fips.us-gov-west-1.amazonaws.com",
              "protocols" => ["http", "https"]
            }
          }
        },
        "elasticbeanstalk" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "sts" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "sqs" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{
              "protocols" => ["http", "https"],
              "sslCommonName" => "{region}.queue.{dnsSuffix}"
            },
            "us-gov-west-1" => %{
              "protocols" => ["http", "https"],
              "sslCommonName" => "{region}.queue.{dnsSuffix}"
            }
          }
        },
        "tagging" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "redshift" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "redshift-data" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "storagegateway" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "autoscaling" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "cloudhsmv2" => %{
          "defaults" => %{"credentialScope" => %{"service" => "cloudhsm"}},
          "endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}
        },
        "dms" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "codedeploy" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "ecs" => %{
          "endpoints" => %{
            "fips-us-gov-east-1" => %{
              "credentialScope" => %{"region" => "us-gov-east-1"},
              "hostname" => "ecs-fips-us-gov-east-1.amazonaws.com"
            },
            "fips-us-gov-west-1" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "ecs-fips-us-gov-west-1.amazonaws.com"
            },
            "us-gov-east-1" => %{"protocols" => ["http", "https"]},
            "us-gov-west-1" => %{"protocols" => ["http", "https"]}
          }
        },
        "directconnect" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "cloudformation" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "swf" => %{"endpoints" => %{"us-gov-east-1" => %{}, "us-gov-west-1" => %{}}},
        "sagemaker" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "sso" => %{
          "endpoints" => %{
            "us-gov-east-1" => %{},
            "us-gov-west-1" => %{}
          }
        }
      }
    }
  ],
  "version" => 3
}
