defmodule OpenchatElixirWeb.UserController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.{GetAllUsersCommand,RegisterUserCommand,Entities.User}

  def get_all(conn, _params) do
    users = GetAllUsersCommand.run()

    json(put_status(conn, :ok), Enum.map(users, fn(user) ->
      %{
        id: user.id,
        username: user.username,
        about: user.about
      }
    end))
  end

  def register(conn, params) do
    user = %User{
      username: params["username"],
      password: params["password"],
      about: params["about"]
    }

    case(RegisterUserCommand.run(user)) do
      {:ok, created_user} ->
        json(put_status(conn, :created), %{
          id: created_user.id,
          username: created_user.username,
          about: created_user.about
        })
      {:username_already_used, _} ->
        text(put_status(conn, :bad_request), "Username already in use.")
    end

  end


end
