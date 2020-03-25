defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router

  pipeline :auth do
    plug ElixirApiWeb.Auth.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  scope "/api", ElixirApiWeb do
    pipe_through [:api, :auth]
    resources "/tweets", TweetController, except: [:new, :edit]
  end

end
