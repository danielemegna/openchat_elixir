defmodule OpenchatElixirWeb.Router do
  use OpenchatElixirWeb, :router

  get "/users", OpenchatElixirWeb.UserController, :get_all
  post "/users", OpenchatElixirWeb.UserController, :register
  post "/login", OpenchatElixirWeb.LoginController, :authenticate
end
