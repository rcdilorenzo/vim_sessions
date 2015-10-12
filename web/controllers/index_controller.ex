defmodule VimSessions.IndexController do
  use VimSessions.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", post: Post.latest
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
