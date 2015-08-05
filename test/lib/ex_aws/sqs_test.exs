defmodule Test.Dummy.SQS do
  use ExAws.SQS.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(_client, queue_name, action, params) do
    params
    |> Enum.into(%{})
    |> Map.put(:queue_name, queue_name)
    |> Map.put(:action, action)
  end
end

defmodule ExAws.SQSTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.SQS


  test "#create_queue" do

  end

  test "#delete_queue" do

  end

  test "#list_queues" do

  end

  test "#get_queue_attributes" do

  end

  test "#set_queue_attributes" do

  end

  test "#purge_queue" do

  end

  test "#get_dead_letter_source_queues" do

  end

  test "#add_permission" do

  end

  test "#remove_permission" do

  end

  test "#send_message" do

  end

  test "#send_message_batch" do

  end

  test "#receive_message" do

  end

  test "#delete_message" do

  end

  test "#delete_message_batch" do

  end

  test "#change_message_visibility" do

  end

  test "#change_message_visibility_batch" do

  end
end
