defmodule OpenchatElixir.RegisterUserCommand do

  alias OpenchatElixir.Entities.User

  def run(user, user_repository \\ OpenchatElixir.AgentUserRepository) do
    cond do
      has_invalid_data?(user) ->
        {:invalid_user_data, nil}
      username_already_used?(user.username, user_repository) ->
        {:username_already_used, nil}
      true ->
        store(user, user_repository)
    end
  end

  defp store(user, user_repository) do
    stored_id = user_repository.store(user)
    stored_user = %{ user | id: stored_id }
    {:ok, stored_user}
  end

  defp has_invalid_data?(%User{username: ""}), do: true
  defp has_invalid_data?(%User{username: nil}), do: true
  defp has_invalid_data?(%User{password: ""}), do: true
  defp has_invalid_data?(%User{password: nil}), do: true
  defp has_invalid_data?(%User{}), do: false
  
  defp username_already_used?(username, user_repository), do:
    user_repository.get_by_username(username) != nil

end
