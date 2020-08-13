defmodule OpenchatElixirWeb.UserController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.{GetAllUsersCommand,RegisterUserCommand,Entities.User}

  def get_all(conn, _params) do
    users = GetAllUsersCommand.run()

    json(put_status(conn, :ok), Enum.map(users, &serialize_user/1))
  end

  def register(conn, params) do
    user = %User{
      username: params["username"],
      password: params["password"],
      about: params["about"]
    }

    case(RegisterUserCommand.run(user)) do
      {:ok, created_user} ->
        json(put_status(conn, :created), serialize_user(created_user))
      {:username_already_used, _} ->
        text(put_status(conn, :bad_request), "Username already in use.")
      {:invalid_user_data, _} ->
        text(put_status(conn, :bad_request), "Username and password cannot be empty.")
    end

  end

  defp serialize_user(user) do
    %{
      id: user.id,
      username: user.username,
      about: user.about
    }
  end

end
