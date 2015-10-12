defmodule VimSessions.ErrorController do
  use VimSessions.Web, :controller

  @message "You must be logged in to access this part of the site."

  def forbidden(conn, params) do
    conn |> put_flash(:error, @message) |> redirect to: "/login"
  end
end
