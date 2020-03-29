defmodule OpenchatElixir.SubmitPostCommand do
  alias OpenchatElixir.AgentUserRepository

  def run(_user_id, _post_text, _user_repository \\ AgentUserRepository) do
    {:user_not_found, nil}
  end

end
