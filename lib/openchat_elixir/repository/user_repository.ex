defmodule OpenchatElixir.UserRepository do

  def start_link() do
    {:ok, agent} = Agent.start_link(fn -> [] end)
    agent
  end

  def get_all(agent) do
    Agent.get(agent, &(&1))
  end

  def store(agent, user) do
    new_id = UUID.uuid4()
    ready_to_store = %{ user | id: new_id }
    Agent.update(agent, &([ready_to_store | &1]))
    new_id
  end

end
