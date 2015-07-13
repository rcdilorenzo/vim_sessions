defmodule VimSessions.UserController do
  use VimSessions.Web, :controller
  require IEx

  def login(conn, _params) do
    render conn, "login.html"
  end

  def show_register(conn, _params) do
    render conn, "register.html"
  end

  # JSON endpoint
  def register(conn, params) do
    changeset = User.changeset %User{}, Map.drop(params, [:password])
    if changeset.valid? do
      Addict.Controller.register(conn, params)
    else
      conn |> put_status(400)
           |> json %{error: ChangesetHelper.concat_errors(changeset, "\n")}
    end
  end
end
