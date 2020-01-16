defmodule OpenchatElixir.RegisterUserCommand do

  def run(user) do
    created_user = %{ user | id: UUID.uuid4() }
    created_user
  end

end
