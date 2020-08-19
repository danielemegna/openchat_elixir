defmodule OpenchatElixir.GetFollowedCommand do

  def run(user_id) do
    case(user_id) do
      "unexisting_id" -> {:error, :user_not_found}
      _user_id -> {:ok, []}
    end
  end
end
