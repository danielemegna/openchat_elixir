defmodule OpenchatElixir.RegisterUserCommand do

  def run(user, user_repository \\ OpenchatElixir.AgentUserRepository) do
    stored_id = user_repository.store(user)
    stored_user = %{ user | id: stored_id }
    {:ok, stored_user}
  end

end
