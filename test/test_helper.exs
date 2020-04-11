ExUnit.start()
Application.stop(:openchat_elixir)
Mox.defmock(MockUserRepository, for: OpenchatElixir.UserRepository)
Mox.defmock(MockPostRepository, for: OpenchatElixir.PostRepository)
