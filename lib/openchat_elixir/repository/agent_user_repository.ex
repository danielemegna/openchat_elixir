defmodule OpenchatElixir.AgentUserRepository do
  alias OpenchatElixir.UserRepository
  @behaviour UserRepository

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: :user_repository)
  end

  @impl UserRepository
  def get_all do
    Agent.get(:user_repository, &(&1))
  end

  @impl UserRepository
  def get_by_username(username) do
    Agent.get(:user_repository, &(&1))
      |> Enum.find(fn u -> u.username == username end)
  end

  @impl UserRepository
  def get_by_id(user_id) do
    Agent.get(:user_repository, &(&1))
      |> Enum.find(fn u -> u.id == user_id end)
  end

  @impl UserRepository
  def store(user) do
    new_id = UUID.uuid4()
    ready_to_store = %{ user | id: new_id }
    Agent.update(:user_repository, &([ready_to_store | &1]))
    new_id
  end

end
