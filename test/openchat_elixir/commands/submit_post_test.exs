defmodule OpenchatElixirWeb.SubmitPostCommandTest do
  alias OpenchatElixir.SubmitPostCommand

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_id, fn _ -> nil end)
    :ok
  end

  test "user not found error" do
    {result, post} = SubmitPostCommand.run("any", "any", MockUserRepository)

    assert :user_not_found == result
    assert nil == post 
  end

end
