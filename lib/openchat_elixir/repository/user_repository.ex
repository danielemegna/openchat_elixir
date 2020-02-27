defmodule OpenchatElixir.UserRepository do

  def start_link() do
    {:ok, agent} = Agent.start_link(fn -> [] end)
    agent
  end

  def get_all(agent) do
    Agent.get(agent, &(&1))
  end

  def store(agent, user) do
    Agent.update(agent, &([user | &1]))
  end

end
