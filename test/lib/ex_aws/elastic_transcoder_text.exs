defmodule ExAws.ElasticTranscoderTest do
  use ExUnit.Case, async: true
  alias ExAws.ElasticTranscoder

  ######################
  ### Pipeline Tests ###
  ######################

  test "list_pipelines without token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/pipelines",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_pipelines()
  end

  test "list_pipelines with token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/pipelines?PageToken=1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_pipelines("1234")
  end

  test "create_pipeline" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :post,
        path: "/2012-09-25/pipelines",
        data: %{"Name" => "some-pipeline"},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.create_pipeline(%{"Name" => "some-pipeline"})
  end

  test "update_pipeline" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :put,
        path: "/2012-09-25/pipelines/1234",
        data: %{"Name" => "some-pipeline"},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.update_pipeline(1234, %{"Name" => "some-pipeline"})
  end

  test "update_pipeline_status" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :post,
        path: "/2012-09-25/pipelines/1234/status",
        data: %{"Status" => "Paused"},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.update_pipeline_status(1234, "Paused")
  end

  test "update_pipeline_notifications" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :post,
        path: "/2012-09-25/pipelines/1234/notifications",
        data: %{"Notifications" => %{"Error" => "arn::fake"}},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.update_pipeline_notifications(1234, %{"Error" => "arn::fake"})
  end

  test "delete_pipeline" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :delete,
        path: "/2012-09-25/pipelines/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.delete_pipeline("1234")
  end

  #################
  ### Job Tests ###
  #################

  test "list_jobs_by_pipeline without token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/jobsByPipeline/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_jobs_by_pipeline("1234")
  end

  test "list_jobs_by_pipeline with token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/jobsByPipeline/1234?PageToken=abcd",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_jobs_by_pipeline("1234", "abcd")
  end

  test "list_jobs_by_status without token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/jobsByStatus/Submitted",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_jobs_by_status("Submitted")
  end

  test "list_jobs_by_status with token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/jobsByStatus/Submitted?PageToken=abcd",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_jobs_by_status("Submitted", "abcd")
  end

  test "read_job" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/jobs/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.read_job("1234")
  end

  test "create_job" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :post,
        path: "/2012-09-25/jobs",
        data: %{"Key" => "abcd.mp4"},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.create_job(%{"Key" => "abcd.mp4"})
  end

  test "cancel_job" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :delete,
        path: "/2012-09-25/jobs/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.cancel_job("1234")
  end

  ####################
  ### Preset Tests ###
  ####################

  test "list_presets without token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/presets",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_presets()
  end

  test "list_presets with token" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/presets?PageToken=abcd",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.list_presets("abcd")
  end

  test "read_preset" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :get,
        path: "/2012-09-25/presets/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.read_preset("1234")
  end

  test "create_preset" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :post,
        path: "/2012-09-25/presets",
        data: %{"Name" => "some-preset"},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.create_preset(%{"Name" => "some-preset"})
  end

  test "delete_preset" do
    expected =
      %ExAws.Operation.JSON{
        http_method: :delete,
        path: "/2012-09-25/presets/1234",
        data: %{},
        service: :elastictranscoder,
      }

    assert expected == ElasticTranscoder.delete_preset("1234")
  end
end
