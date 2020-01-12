defmodule OpenchatElixirWeb.Router do
  use OpenchatElixirWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipe_through :api
  
  get "/users", OpenchatElixirWeb.UserController, :get_all
end
