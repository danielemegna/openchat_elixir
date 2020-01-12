defmodule OpenchatElixir.Entities.User do
  @enforce_keys [:username, :about]
  defstruct [:id, :username, :about, :password]
end
