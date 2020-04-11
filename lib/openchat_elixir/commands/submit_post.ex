defmodule OpenchatElixir.SubmitPostCommand do
  alias OpenchatElixir.AgentUserRepository
  alias OpenchatElixir.Entities.Post

  def run(user_id, post_text, user_repository \\ AgentUserRepository) do
    user_from_repository = user_repository.get_by_id(user_id)
    case(user_from_repository) do
      nil -> {:user_not_found, nil}
      _ -> {:ok, submit_post(user_id, post_text)}
    end
  end
  
  defp submit_post(user_id, post_text) do
    %Post{
      id: UUID.uuid4(),
      user_id: user_id, 
      text: post_text, 
      datetime: DateTime.utc_now()
    }
  end

end
