defmodule OpenchatElixirWeb.FollowingsController do
  use OpenchatElixirWeb, :controller
  alias OpenchatElixir.{GetFollowedCommand,CreateFollowingCommand}

  def get(conn, params) do
    case(GetFollowedCommand.run(params["user_id"])) do
      {:ok, followed_users} ->
        json(put_status(conn, :ok), Enum.map(followed_users, &serialize_user/1))
      {:error, :user_not_found} ->
        text(put_status(conn, :not_found), "User not found.")
    end

  end

  def create(conn, _params) do
    case(CreateFollowingCommand.run()) do
      {:ok, :created} -> text(put_status(conn, :created), "Following created.")
      _ -> raise "Not handled yet."
    end
  end

  defp serialize_user(_following) do
    %{
      id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      username: "string",
      about: "string"
    }
  end

end
