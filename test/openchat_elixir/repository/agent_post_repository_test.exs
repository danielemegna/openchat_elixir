defmodule OpenchatElixirWeb.AgentPostRepositoryTest do
  use ExUnit.Case 
  alias OpenchatElixir.AgentPostRepository
  alias OpenchatElixir.Entities.Post
  import OpenchatElixirWeb.Support.AssertionsHelper

  setup do
    AgentPostRepository.start_link([])
    :ok
  end

  test "get post from empty repository" do
    assert [] == AgentPostRepository.get_by_userid('not-present')
  end

  test "store and get post" do
    now_datetime = DateTime.utc_now() 
    post = %Post{
      user_id: "user.id", 
      text: "Post text.", 
      datetime: now_datetime
    }

    stored_id = AgentPostRepository.store(post)
    assert_valid_uuid stored_id

    expected_stored_post = %Post{
      id: stored_id,
      user_id: "user.id", 
      text: "Post text.", 
      datetime: now_datetime
    }
    assert [expected_stored_post] == AgentPostRepository.get_by_userid("user.id")
    assert [] == AgentPostRepository.get_by_userid('not-present')
  end

  test "in this repository posts are stored in reverse order" do
    first_post_date = DateTime.utc_now() 
    first_post = %Post{
      user_id: "user.id", 
      text: "Post text.", 
      datetime: first_post_date
    }
    first_post_id = AgentPostRepository.store(first_post)

    second_post_date = DateTime.utc_now() 
    second_post = %Post{
      user_id: "user.id", 
      text: "Second post text.", 
      datetime: second_post_date
    }
    second_post_id = AgentPostRepository.store(second_post)

    posts = AgentPostRepository.get_by_userid("user.id")

    assert posts == [
      %Post{
        id: second_post_id,
        user_id: "user.id", 
        text: "Second post text.", 
        datetime: second_post_date
      },
      %Post{
        id: first_post_id,
        user_id: "user.id", 
        text: "Post text.", 
        datetime: first_post_date
      }
    ]
  end

end
