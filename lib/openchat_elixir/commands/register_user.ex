defmodule OpenchatElixir.RegisterUserCommand do

  def run(user, user_repository \\ OpenchatElixir.AgentUserRepository) do
    stored_id = user_repository.store(user)
    %{ user | id: stored_id }
  end

end
