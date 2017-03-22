defmodule ExAws.ElasticTranscoder do
  @moduledoc """
  Operations on AWS Elastic Transcoder

  ### Examples
  ```
  ElasticTranscoder.list_pipelines() |> ExAws.request!()
  ElasticTranscoder.create_job(%{"Key" => "abcd.mp4", ...}) |> ExAws.request!()
  ```
  """
  @api_version_date "2012-09-25"

  ########################
  ### Pipeline Actions ###
  ########################

  @doc "List pipelines, may return paginated result"
  def list_pipelines(next_token \\ nil) do
    request(:get, "/pipelines", with_next_token(next_token))
  end

  @doc "Get description of a single pipeline"
  def read_pipeline(pipeline_id) do
    request(:get, "/pipelines/#{pipeline_id}")
  end

  @doc "Create a new pipeline"
  def create_pipeline(data) do
    request(:post, "/pipelines", data)
  end

  @doc "Update an existing pipeline, omit attributes to leave them unchanged"
  def update_pipeline(pipeline_id, data) do
  request(:put, "/pipelines/#{pipeline_id}", data)
  end

  @doc "Update the status of an existing pipeline"
  def update_pipeline_status(pipeline_id, status) when status in ["Active", "Paused"] do
  request(:post, "/pipelines/#{pipeline_id}/status", %{"Status" => status})
  end

  @doc "Update the notification callback SNS queue ARNs of an existing pipeline"
  def update_pipeline_notifications(pipeline_id, notifications) do
    request(:post, "/pipelines/#{pipeline_id}/notifications", %{"Notifications" => notifications})
  end

  @doc "Delete a pipeline"
  def delete_pipeline(pipeline_id) do
    request(:delete, "/pipelines/#{pipeline_id}")
  end

  ###################
  ### Job Actions ###
  ###################

  @doc "List jobs of a given pipeline, may return paginated result"
  def list_jobs_by_pipeline(pipeline_id, next_token \\ nil) do
    request(:get, "/jobsByPipeline/#{pipeline_id}", with_next_token(next_token))
  end

  @doc "List jobs with a given status, may return paginated result"
  def list_jobs_by_status(status, next_token \\ nil) when status in ["Submitted", "Progressing", "Complete", "Canceled", "Error"] do
    request(:get, "/jobsByStatus/#{status}", with_next_token(next_token))
  end

  @doc "Get description of a single job"
  def read_job(job_id) do
    request(:get, "/jobs/#{job_id}")
  end

  @doc "Create a new job"
  def create_job(data) do
    request(:post, "/jobs", data)
  end

  @doc "Cancel a pending job"
  def cancel_job(job_id) do
    request(:delete, "/jobs/#{job_id}")
  end

  ######################
  ### Preset Actions ###
  ######################

  @doc "List all preset, may return paginated result"
  def list_presets(next_token \\ nil) do
    request(:get, "/presets", with_next_token(next_token))
  end

  @doc "Get description of a single preset"
  def read_preset(preset_id) do
    request(:get, "/presets/#{preset_id}")
  end

  @doc "Create a new preset"
  def create_preset(data) do
    request(:post, "/presets", data)
  end

  @doc "Delete a preset"
  def delete_preset(preset_id) do
    request(:delete, "/presets/#{preset_id}")
  end

  defp with_next_token(nil), do: %{}
  defp with_next_token(token), do: %{"PageToken" => token}

  defp request(http_method, path, data \\ %{})

  defp request(:get, path, data) do
    %ExAws.Operation.JSON{
      http_method: :get,
      path: "/" <> @api_version_date <> path,
      params: data,
      service: :elastictranscoder,
    }
  end

  defp request(http_method, path, data) do
    %ExAws.Operation.JSON{
      http_method: http_method,
      path: "/" <> @api_version_date <> path,
      data: data,
      service: :elastictranscoder,
    }
  end
end
