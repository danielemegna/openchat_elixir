defmodule OpenchatElixir.GetAllUsersCommand do
  def run() do
    OpenchatElixir.AgentUserRepository.get_all()
  end
end
