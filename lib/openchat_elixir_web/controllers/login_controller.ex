defmodule OpenchatElixirWeb.LoginController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.LoginCommand

  def authenticate(conn, params) do
    {login_result, logged_user} = LoginCommand.run(params["username"], params["password"])
    case(login_result) do
      :ok ->
        json(put_status(conn, :ok), %{
          id: logged_user.id,
          username: logged_user.username,
          about: logged_user.about
        })
      :invalid_credentials ->
        text(put_status(conn, :not_found), "Invalid credentials.")
    end
  end

end
