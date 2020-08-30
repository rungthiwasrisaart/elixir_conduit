defmodule ConduitWeb.Router do
  use ConduitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug(Guardian.Plug.Pipeline,
      error_handler: ConduitWeb.ErrorHandler,
      module: Conduit.Auth.Guardian
    )

    plug(Guardian.Plug.VerifyHeader, realm: "Token")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/api", ConduitWeb do
    pipe_through :api

    post "/articles", ArticleController, :create

    get "/user", UserController, :current
    post "/users/login", SessionController, :create
    post "/users", UserController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ConduitWeb.Telemetry
    end
  end
end
