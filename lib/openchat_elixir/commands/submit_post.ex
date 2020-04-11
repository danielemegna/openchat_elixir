defmodule OpenchatElixir.SubmitPostCommand do
  alias OpenchatElixir.{AgentUserRepository, AgentPostRepository}
  alias OpenchatElixir.Entities.Post

  def run(
    user_id,
    post_text,
    user_repository \\ AgentUserRepository,
    post_repository \\ AgentPostRepository
  ) do
    user_from_repository = user_repository.get_by_id(user_id)
    case(user_from_repository) do
      nil -> {:user_not_found, nil}
      _ -> {:ok, store_post(user_id, post_text, post_repository)}
    end
  end
  
  defp store_post(user_id, post_text, post_repository) do
    post_to_store = %Post{
      user_id: user_id, 
      text: post_text, 
      datetime: DateTime.utc_now()
    }
    stored_post_id = post_repository.store(post_to_store)
    %{ post_to_store | id: stored_post_id }
  end

end
