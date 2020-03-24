defmodule OpenchatElixir.UserRepository do
  @callback get_all() :: [OpenchatElixir.Entities.User.t]
  @callback store(OpenchatElixir.Entities.User.t) :: String.t
end
