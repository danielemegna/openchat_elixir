ExUnit.start(trace: true)
Application.stop(:openchat_elixir)
Mox.defmock(MockUserRepository, for: OpenchatElixir.UserRepository)
