defmodule OpenchatElixir.PostRepository do
  @callback get_by_userid(String.t) :: [OpenchatElixir.Entities.Post.t]
  @callback store(OpenchatElixir.Entities.Post.t) :: String.t
end
