defmodule HebWeb.Router do
  use HebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HebWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HebWeb do
    pipe_through :api

    get "/images", ImageController, :index
    post "/images", ImageController, :create
    get "/images/:id", ImageController, :show
    get "/images:params", ImageController, :index
    get "/", ImageController, :index
  end
end
