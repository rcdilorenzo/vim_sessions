defmodule VimSessions.PostController do
  use VimSessions.Web, :controller

  def show(conn, %{"id" => id}) do
    post = Repo.get Post, String.to_integer(id)
    Earmark.to_html(post.content) |> IO.puts
    render conn, "show.html", post: post
  end

end
