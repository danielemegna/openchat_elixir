defmodule OpenchatElixirWeb.PageController do
  use OpenchatElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
