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
      "regionRegex" => "^(us|eu|ap|sa|ca)\\-\\w+\\-\\d+$",
      "regions" => %{
        "ap-northeast-1" => %{"description" => "Asia Pacific (Tokyo)"},
        "ap-northeast-2" => %{"description" => "Asia Pacific (Seoul)"},
        "ap-south-1" => %{"description" => "Asia Pacific (Mumbai)"},
        "ap-southeast-1" => %{"description" => "Asia Pacific (Singapore)"},
        "ap-southeast-2" => %{"description" => "Asia Pacific (Sydney)"},
        "ca-central-1" => %{"description" => "Canada (Central)"},
        "eu-central-1" => %{"description" => "EU (Frankfurt)"},
        "eu-west-1" => %{"description" => "EU (Ireland)"},
        "eu-west-2" => %{"description" => "EU (London)"},
        "sa-east-1" => %{"description" => "South America (Sao Paulo)"},
        "us-east-1" => %{"description" => "US East (N. Virginia)"},
        "us-east-2" => %{"description" => "US East (Ohio)"},
        "us-west-1" => %{"description" => "US West (N. California)"},
        "us-west-2" => %{"description" => "US West (Oregon)"}
      },
      "services" => %{
        "firehose" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
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
        "elasticache" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "config" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "pinpoint" => %{
          "defaults" => %{"credentialScope" => %{"service" => "mobiletargeting"}},
          "endpoints" => %{"us-east-1" => %{}}
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
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
            "ap-southeast-2" => %{},
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
        "glacier" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "acm" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "elasticmapreduce" => %{
          "defaults" => %{
            "protocols" => ["http", "https"],
            "sslCommonName" => "{region}.{service}.{dnsSuffix}"
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{"sslCommonName" => "{service}.{region}.{dnsSuffix}"},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
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
            "ap-south-1" => %{},
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
        "kinesis" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "events" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "health" => %{"endpoints" => %{"us-east-1" => %{}}},
        "glue" => %{"endpoints" => %{"us-east-1" => %{}, "us-east-2" => %{}, "us-west-2" => %{}}},
        "lightsail" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
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
        "polly" => %{
          "endpoints" => %{
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "lambda" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "dynamodb" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
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
        "streams.dynamodb" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "dynamodb"},
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
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
        "es" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
            "ap-south-1" => %{},
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
        "clouddirectory" => %{
          "endpoints" => %{
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
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
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "elasticloadbalancing" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "mturk-requester" => %{
          "endpoints" => %{
            "sandbox" => %{"hostname" => "mturk-requester-sandbox.us-east-1.amazonaws.com"},
            "us-east-1" => %{}
          },
          "isRegionalized" => false
        },
        "devicefarm" => %{"endpoints" => %{"us-west-2" => %{}}},
        "athena" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "mobileanalytics" => %{"endpoints" => %{"us-east-1" => %{}}},
        "metering.marketplace" => %{
          "defaults" => %{"credentialScope" => %{"service" => "aws-marketplace"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "ec2" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "opsworks-cm" => %{
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
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
        "ds" => %{
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
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "apigateway" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "elastictranscoder" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
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
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "rds" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"sslCommonName" => "{service}.{dnsSuffix}"},
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
        "cloudtrail" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "opsworks" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
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
            "ap-south-1" => %{},
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
        "ecr" => %{
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
        "cognito-idp" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "iot" => %{
          "defaults" => %{"credentialScope" => %{"service" => "execute-api"}},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
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
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
          }
        },
        "rekognition" => %{
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "s3" => %{
          "defaults" => %{"protocols" => ["http", "https"], "signatureVersions" => ["s3v4"]},
          "endpoints" => %{
            "ap-northeast-1" => %{
              "hostname" => "s3-ap-northeast-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{
              "hostname" => "s3-ap-southeast-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ap-southeast-2" => %{
              "hostname" => "s3-ap-southeast-2.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{
              "hostname" => "s3-eu-west-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "eu-west-2" => %{},
            "s3-external-1" => %{
              "credentialScope" => %{"region" => "us-east-1"},
              "hostname" => "s3-external-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "sa-east-1" => %{
              "hostname" => "s3-sa-east-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-east-1" => %{
              "hostname" => "s3.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-east-2" => %{},
            "us-west-1" => %{
              "hostname" => "s3-us-west-1.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            },
            "us-west-2" => %{
              "hostname" => "s3-us-west-2.amazonaws.com",
              "signatureVersions" => ["s3", "s3v4"]
            }
          },
          "isRegionalized" => true,
          "partitionEndpoint" => "us-east-1"
        },
        "elasticbeanstalk" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "datapipeline" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
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
            "ap-south-1" => %{},
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
        "sts" => %{
          "defaults" => %{
            "credentialScope" => %{"region" => "us-east-1"},
            "hostname" => "sts.amazonaws.com"
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{
              "credentialScope" => %{"region" => "ap-northeast-2"},
              "hostname" => "sts.ap-northeast-2.amazonaws.com"
            },
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "aws-global" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
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
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "ca-central-1" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "sa-east-1" => %{},
            "us-east-1" => %{"sslCommonName" => "queue.{dnsSuffix}"},
            "us-east-2" => %{},
            "us-west-1" => %{},
            "us-west-2" => %{}
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
        "cur" => %{"endpoints" => %{"us-east-1" => %{}}},
        "tagging" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "redshift" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "email" => %{"endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}},
        "storagegateway" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "kinesisanalytics" => %{
          "endpoints" => %{"eu-west-1" => %{}, "us-east-1" => %{}, "us-west-2" => %{}}
        },
        "autoscaling" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "cloudhsmv2" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-south-1" => %{},
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
        "runtime.lex" => %{
          "defaults" => %{"credentialScope" => %{"service" => "lex"}},
          "endpoints" => %{"us-east-1" => %{}}
        },
        "data.iot" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "iotdata"},
            "protocols" => ["https"]
          },
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-west-2" => %{}
          }
        },
        "xray" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "elasticfilesystem" => %{
          "endpoints" => %{
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
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
        "dms" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "codedeploy" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "codestar" => %{
          "endpoints" => %{
            "ap-southeast-1" => %{},
            "ap-southeast-2" => %{},
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
            "ap-northeast-1" => %{},
            "ap-southeast-2" => %{},
            "eu-central-1" => %{},
            "eu-west-1" => %{},
            "eu-west-2" => %{},
            "us-east-1" => %{},
            "us-east-2" => %{},
            "us-west-2" => %{}
          }
        },
        "ecs" => %{
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
        "cognito-identity" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "cloudformation" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "inspector" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
            "ap-southeast-2" => %{},
            "eu-west-1" => %{},
            "us-east-1" => %{},
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
        "swf" => %{
          "endpoints" => %{
            "ap-northeast-1" => %{},
            "ap-northeast-2" => %{},
            "ap-south-1" => %{},
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
        "models.lex" => %{
          "defaults" => %{"credentialScope" => %{"service" => "lex"}},
          "endpoints" => %{"us-east-1" => %{}}
        },
        "codebuild" => %{
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
            "us-west-1" => %{},
            "us-west-2" => %{}
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
      "regions" => %{"cn-north-1" => %{"description" => "China (Beijing)"}},
      "services" => %{
        "elasticache" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "config" => %{"endpoints" => %{"cn-north-1" => %{}}},
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
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "elasticmapreduce" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "logs" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "kinesis" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "events" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "sns" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "dynamodb" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "streams.dynamodb" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "dynamodb"},
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "es" => %{},
        "monitoring" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "elasticloadbalancing" => %{
          "defaults" => %{"protocols" => ["https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "ec2" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "rds" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "cloudtrail" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "ssm" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "ecr" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "iot" => %{
          "defaults" => %{"credentialScope" => %{"service" => "execute-api"}},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "s3" => %{
          "defaults" => %{"protocols" => ["http", "https"], "signatureVersions" => ["s3v4"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "elasticbeanstalk" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "application-autoscaling" => %{
          "defaults" => %{
            "credentialScope" => %{"service" => "application-autoscaling"},
            "hostname" => "autoscaling.{region}.amazonaws.com",
            "protocols" => ["http", "https"]
          },
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "sts" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "sqs" => %{
          "defaults" => %{
            "protocols" => ["http", "https"],
            "sslCommonName" => "{region}.queue.{dnsSuffix}"
          },
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "tagging" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "redshift" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "storagegateway" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "autoscaling" => %{
          "defaults" => %{"protocols" => ["http", "https"]},
          "endpoints" => %{"cn-north-1" => %{}}
        },
        "codedeploy" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "ecs" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "directconnect" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "cloudformation" => %{"endpoints" => %{"cn-north-1" => %{}}},
        "swf" => %{"endpoints" => %{"cn-north-1" => %{}}}
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
      "regions" => %{"us-gov-west-1" => %{"description" => "AWS GovCloud (US)"}},
      "services" => %{
        "elasticache" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "config" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
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
        "snowball" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "glacier" => %{"endpoints" => %{"us-gov-west-1" => %{"protocols" => ["http", "https"]}}},
        "acm" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "elasticmapreduce" => %{
          "endpoints" => %{"us-gov-west-1" => %{"protocols" => ["http", "https"]}}
        },
        "logs" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "kinesis" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "events" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "sns" => %{"endpoints" => %{"us-gov-west-1" => %{"protocols" => ["http", "https"]}}},
        "lambda" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "dynamodb" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "streams.dynamodb" => %{
          "defaults" => %{"credentialScope" => %{"service" => "dynamodb"}},
          "endpoints" => %{"us-gov-west-1" => %{}}
        },
        "monitoring" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "elasticloadbalancing" => %{
          "endpoints" => %{"us-gov-west-1" => %{"protocols" => ["http", "https"]}}
        },
        "ec2" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "apigateway" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "kms" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "sms" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "rds" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "cloudtrail" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "ssm" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "cloudhsm" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "rekognition" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "s3" => %{
          "defaults" => %{"signatureVersions" => ["s3", "s3v4"]},
          "endpoints" => %{
            "fips-us-gov-west-1" => %{
              "credentialScope" => %{"region" => "us-gov-west-1"},
              "hostname" => "s3-fips-us-gov-west-1.amazonaws.com"
            },
            "us-gov-west-1" => %{
              "hostname" => "s3-us-gov-west-1.amazonaws.com",
              "protocols" => ["http", "https"]
            }
          }
        },
        "sts" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "sqs" => %{
          "endpoints" => %{
            "us-gov-west-1" => %{
              "protocols" => ["http", "https"],
              "sslCommonName" => "{region}.queue.{dnsSuffix}"
            }
          }
        },
        "redshift" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "autoscaling" => %{
          "endpoints" => %{"us-gov-west-1" => %{"protocols" => ["http", "https"]}}
        },
        "codedeploy" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "directconnect" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "cloudformation" => %{"endpoints" => %{"us-gov-west-1" => %{}}},
        "swf" => %{"endpoints" => %{"us-gov-west-1" => %{}}}
      }
    }
  ],
  "version" => 3
}
