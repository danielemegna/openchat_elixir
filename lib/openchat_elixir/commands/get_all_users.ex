defmodule OpenchatElixir.GetAllUsersCommand do
  alias OpenchatElixir.UserRepository

  def run() do
    UserRepository.get_all()
  end

end
