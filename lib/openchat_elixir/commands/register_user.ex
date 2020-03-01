defmodule OpenchatElixir.RegisterUserCommand do
  alias OpenchatElixir.UserRepository

  def run(user) do
    stored_id = UserRepository.store(user)
    %{ user | id: stored_id }
  end

end
