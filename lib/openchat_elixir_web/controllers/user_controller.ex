defmodule OpenchatElixirWeb.UserController do
  use OpenchatElixirWeb, :controller

  def get_all(conn, _params) do
    json(conn, [])
  end

  def register(conn, params) do
    user = %OpenchatElixir.Entities.User{
      id: params["id"],
      username: params["username"],
      about: params["about"]
    }

    created_user = OpenchatElixir.RegisterUserCommand.run(user)

    conn
      |> put_status(:created)
      |> json(%{
        id: created_user.id,
        username: created_user.username,
        about: created_user.about
      })
  end


end
