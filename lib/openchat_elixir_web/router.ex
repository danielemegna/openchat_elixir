defmodule OpenchatElixirWeb.Router do
  use OpenchatElixirWeb, :router

  get "/users", OpenchatElixirWeb.UserController, :get_all
  post "/users", OpenchatElixirWeb.UserController, :register

  post "/login", OpenchatElixirWeb.LoginController, :authenticate

  get "/users/:user_id/timeline", OpenchatElixirWeb.TimelineController, :get
  post "/users/:user_id/timeline", OpenchatElixirWeb.TimelineController, :submit_post

  post "/followings", OpenchatElixirWeb.FollowingsController, :create
  get "/followings/:user_id/followees", OpenchatElixirWeb.FollowingsController, :get
end
