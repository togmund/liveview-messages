defmodule MessengerWeb.Router do
  use MessengerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MessengerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MessengerWeb do
    pipe_through :browser

    live "/", MessageLive.Index, :index

    live "/messages", MessageLive.Index, :index
    live "/messages/new", MessageLive.Index, :new
    live "/messages/:id/edit", MessageLive.Index, :edit

    live "/messages/:id", MessageLive.Show, :show
    live "/messages/:id/show/edit", MessageLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", MessengerWeb do
  #   pipe_through :api
  # end

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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MessengerWeb.Telemetry
    end
  end
end
