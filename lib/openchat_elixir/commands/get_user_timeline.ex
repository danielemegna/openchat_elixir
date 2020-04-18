defmodule OpenchatElixir.GetUserTimelineCommand do
  alias OpenchatElixir.AgentUserRepository
  alias OpenchatElixir.AgentPostRepository

  def run(user_id, user_repository \\ AgentUserRepository, post_repository \\ AgentPostRepository) do
    user = user_repository.get_by_id(user_id)
    case(user) do
      nil -> {:user_not_found, nil}
      _ -> {:ok, post_repository.get_by_userid(user_id)}
    end
  end

end
