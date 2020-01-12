defmodule OpenchatElixirWeb.Router do
  use OpenchatElixirWeb, :router

  get "/users", OpenchatElixirWeb.UserController, :get_all
end
