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

    created_user = %{ user | id: "f15c0fc0-ee61-46e4-b27a-b88d186f7325" }
    response_body = %{
      id: created_user.id,
      username: created_user.username,
      about: created_user.about
    }

    conn
      |> put_status(:created)
      |> json(response_body)
  end


end
