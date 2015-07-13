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
    pipe_through :browser # Use the default browser stack

    get "/", IndexController, :index

    get "/login",    UserController, :login
    get "/register", UserController, :show_register

  end

  scope "/" do
    pipe_through :browser

    # TODO: Don't add routes for the following that are sent to the root page
    addict :routes,
      register: [controller: VimSessions.UserController, action: :register],
      recover_password: [controller: IndexController, action: :index],
      reset_password: [controller: IndexController, action: :index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", VimSessions do
  #   pipe_through :api
  # end
end
