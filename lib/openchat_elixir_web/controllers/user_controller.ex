defmodule OpenchatElixirWeb.UserController do
  use OpenchatElixirWeb, :controller

  def get_all(conn, _params) do
    json(conn, [])
  end
end
