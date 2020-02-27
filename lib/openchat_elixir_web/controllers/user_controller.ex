defmodule OpenchatElixirWeb.UserController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.{GetAllUsersCommand,RegisterUserCommand,Entities.User}

  def get_all(conn, _params) do
    users = GetAllUsersCommand.run()
    json(conn, users)
  end

  def register(conn, params) do
    user = %User{
      id: params["id"],
      username: params["username"],
      about: params["about"]
    }

    created_user = RegisterUserCommand.run(user)

    conn
      |> put_status(:created)
      |> json(%{
        id: created_user.id,
        username: created_user.username,
        about: created_user.about
      })
  end


end
