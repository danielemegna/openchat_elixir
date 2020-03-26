defmodule OpenchatElixir.RegisterUserCommand do

  def run(user, user_repository \\ OpenchatElixir.AgentUserRepository) do
    case(user_repository.get_by_username(user.username)) do
      nil -> 
        stored_id = user_repository.store(user)
        stored_user = %{ user | id: stored_id }
        {:ok, stored_user}
      _ ->
        {:username_already_used, nil}
    end
  end

end
