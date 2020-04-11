defmodule OpenchatElixir.Entities.Post do
  @enforce_keys [:user_id, :text]
  defstruct [:id, :user_id, :text, :datetime]
end
