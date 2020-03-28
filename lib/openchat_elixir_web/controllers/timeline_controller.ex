defmodule OpenchatElixirWeb.TimelineController do
  use OpenchatElixirWeb, :controller

  def get(conn, params) do
    if(params["user_id"] != "unexisting_id") do
      json(conn, [])
    else
      text(put_status(conn, :not_found), "User not found.")
    end
  end

end
