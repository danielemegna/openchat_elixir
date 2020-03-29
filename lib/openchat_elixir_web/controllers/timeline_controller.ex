defmodule OpenchatElixirWeb.TimelineController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.GetUserTimelineCommand

  def get(conn, params) do
    {result, posts} = GetUserTimelineCommand.run(params["user_id"])
    case(result) do
      :ok -> json(conn, posts)
      :user_not_found -> text(put_status(conn, :not_found), "User not found.")
    end
  end

  def submit_post(conn, _params) do
    text(put_status(conn, :not_found), "User not found.")
  end

end
