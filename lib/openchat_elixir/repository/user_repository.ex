defmodule OpenchatElixir.UserRepository do

  def get_all() do
    Agent.get(:user_repository, &(&1))
  end

  def store(user) do
    new_id = UUID.uuid4()
    ready_to_store = %{ user | id: new_id }
    Agent.update(:user_repository, &([ready_to_store | &1]))
    new_id
  end

end
