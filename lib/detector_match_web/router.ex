defmodule DetectorMatchWeb.Router do
  use DetectorMatchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DetectorMatchWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/addresses", AddressController
  end

  scope "/admin", DetectorMatchWeb do
    pipe_through :browser # TODO: lock down admin routes

    resources "/users", Admin.UserController
  end

  scope "/session", DetectorMatchWeb do
    pipe_through [:browser]

    get "/new", SessionController, :new
    post "/identity/callback", SessionController, :identity_callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", DetectorMatchWeb do
  #   pipe_through :api
  # end
end
