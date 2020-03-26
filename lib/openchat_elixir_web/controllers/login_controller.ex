defmodule OpenchatElixirWeb.LoginController do
  use OpenchatElixirWeb, :controller
  #alias OpenchatElixir.{LoginCommand,Entities.User}

  def authenticate(conn, _params) do
    text(put_status(conn, :not_found), "Invalid credentials.")
  end

end
