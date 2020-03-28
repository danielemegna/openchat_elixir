defmodule OpenchatElixir.GetUserTimelineCommand do
  alias OpenchatElixir.AgentUserRepository

  def run(user_id, user_repository \\ AgentUserRepository) do
    user = user_repository.get_by_id(user_id)
    case(user) do
      nil -> {:user_not_found, nil}
      _ -> {:ok, []}
    end
  end

end
