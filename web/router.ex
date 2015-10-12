defmodule VimSessions.Router do
  use VimSessions.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VimSessions do
    pipe_through :browser

    get "/", IndexController, :index

    get "/forbidden", ErrorController, :forbidden

    get "/login",    UserController, :login
    get "/register", UserController, :show_register

    scope "/admin" do
      resources "/posts", PostController
    end
  end

  scope "/" do
    pipe_through :browser

    addict :routes,
      register: [controller: VimSessions.UserController, action: :register],
      recover_password: [controller: IndexController, action: :index],
      reset_password: [controller: IndexController, action: :index]
  end
end
