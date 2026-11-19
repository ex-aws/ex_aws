defmodule ExAws.ConfigTest do
  use ExUnit.Case, async: true

  setup do
    Application.delete_env(:ex_aws, :awscli_credentials)

    on_exit(fn ->
      Application.delete_env(:ex_aws, :awscli_credentials)
    end)
  end

  test "overrides work properly" do
    config = ExAws.Config.new(:s3, region: "us-west-2")
    assert config.region == "us-west-2"
  end

  test "{:system} style configs work" do
    value = "foo"
    System.put_env("ExAwsConfigTest", value)

    assert :s3
           |> ExAws.Config.new(
             access_key_id: {:system, "ExAwsConfigTest"},
             secret_access_key: {:system, "AWS_SECURITY_TOKEN"}
           )
           |> Map.get(:access_key_id) == value
  end

  test "security_token is configured properly" do
    value = "security_token"
    System.put_env("AWS_SECURITY_TOKEN", value)

    assert :s3
           |> ExAws.Config.new(
             access_key_id: {:system, "AWS_SECURITY_TOKEN"},
             security_token: {:system, "AWS_SECURITY_TOKEN"}
           )
           |> Map.get(:security_token) == value
  end

  test "config file is parsed if no given credentials in configuraion" do
    profile = "default"

    Mox.expect(ExAws.Credentials.InitMock, :security_credentials, 1, fn ^profile ->
      {:ok, %{region: "eu-west-1"}}
    end)

    config = ExAws.Config.awscli_auth_credentials(profile, ExAws.Credentials.InitMock)

    assert config.region == "eu-west-1"
  end

  test "profile config returned if given credentials in configuration" do
    profile = "default"

    example_credentials = %{
      "default" => %{
        region: "eu-west-1"
      }
    }

    Application.put_env(:ex_aws, :awscli_credentials, example_credentials)

    Mox.expect(ExAws.Credentials.InitMock, :security_credentials, 0, fn ^profile ->
      %{region: "eu-west-1"}
    end)

    config = ExAws.Config.awscli_auth_credentials(profile, ExAws.Credentials.InitMock)

    assert config.region == "eu-west-1"
  end

  test "error on wrong credentials configuration" do
    profile = "other"

    example_credentials = %{
      "default" => %{
        region: "eu-west-1"
      }
    }

    Application.put_env(:ex_aws, :awscli_credentials, example_credentials)

    Mox.expect(ExAws.Credentials.InitMock, :security_credentials, 0, fn ^profile ->
      %{region: "eu-west-1"}
    end)

    assert_raise RuntimeError, fn ->
      ExAws.Config.awscli_auth_credentials(profile, ExAws.Credentials.InitMock)
    end
  end

  test "region as a plain string" do
    region_value = "us-west-1"

    assert :s3
           |> ExAws.Config.new(region: region_value)
           |> Map.get(:region) == region_value
  end

  test "region as an envar" do
    region_value = "us-west-1"
    System.put_env("AWS_REGION", region_value)

    assert :s3
           |> ExAws.Config.new(region: {:system, "AWS_REGION"})
           |> Map.get(:region) == region_value
  end

  test "headers are passed as provided" do
    headers = [{"If-Match", "ABC"}]

    assert :s3
           |> ExAws.Config.new(headers: headers)
           |> Map.get(:headers) == headers
  end

  describe "Amazon Location services" do
    test "data plane hosts and signing names" do
      for {service, host, signing_name} <- [
            {:maps, "maps.geo.eu-west-1.amazonaws.com", :geo},
            {:places, "places.geo.eu-west-1.amazonaws.com", :geo},
            {:routes, "routes.geo.eu-west-1.amazonaws.com", :geo},
            {:geofencing, "geofencing.geo.eu-west-1.amazonaws.com", :geo},
            {:tracking, "tracking.geo.eu-west-1.amazonaws.com", :geo},
            {:metadata, "metadata.geo.eu-west-1.amazonaws.com", :geo},
            {:maps_v2, "maps.geo.eu-west-1.amazonaws.com", :"geo-maps"},
            {:places_v2, "places.geo.eu-west-1.amazonaws.com", :"geo-places"},
            {:routes_v2, "routes.geo.eu-west-1.amazonaws.com", :"geo-routes"}
          ] do
        config = ExAws.Config.new(service, region: "eu-west-1")
        assert {service, config.host} == {service, host}
        assert {service, config.service_override} == {service, signing_name}
      end
    end

    test "control plane hosts and signing names" do
      for {service, host} <- [
            {:maps_cp, "cp.maps.geo.ap-southeast-5.amazonaws.com"},
            {:places_cp, "cp.places.geo.ap-southeast-5.amazonaws.com"},
            {:routes_cp, "cp.routes.geo.ap-southeast-5.amazonaws.com"},
            {:geofencing_cp, "cp.geofencing.geo.ap-southeast-5.amazonaws.com"},
            {:tracking_cp, "cp.tracking.geo.ap-southeast-5.amazonaws.com"},
            {:metadata_cp, "cp.metadata.geo.ap-southeast-5.amazonaws.com"}
          ] do
        config = ExAws.Config.new(service, region: "ap-southeast-5")
        assert {service, config.host} == {service, host}
        assert {service, config.service_override} == {service, :geo}
      end
    end

    test "GovCloud hosts" do
      assert ExAws.Config.new(:tracking_cp, region: "us-gov-west-1").host ==
               "cp.tracking.geo.us-gov-west-1.amazonaws.com"

      assert ExAws.Config.new(:maps_v2, region: "us-gov-west-1").host ==
               "maps.geo.us-gov-west-1.amazonaws.com"
    end
  end
end
