defmodule OpenchatElixirWeb.TimelineController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.{GetUserTimelineCommand, SubmitPostCommand}

  def get(conn, params) do
    {result, posts} = GetUserTimelineCommand.run(params["user_id"])
    case(result) do
      :ok -> json(conn, Enum.map(posts, &serialize_post/1))
      :user_not_found -> text(put_status(conn, :not_found), "User not found.")
    end
  end

  def submit_post(conn, params) do
    {result, post} = SubmitPostCommand.run(params["user_id"], params["text"])
    case(result) do
      :ok -> json(put_status(conn, :created), serialize_post(post))
      :user_not_found -> text(put_status(conn, :not_found), "User not found.")
    end
  end

  defp serialize_post(post) do
    %{
      postId: post.id,
      userId: post.user_id,
      text: post.text,
      dateTime: NimbleStrftime.format(post.datetime, "%xT%XZ")
    }
  end

end
