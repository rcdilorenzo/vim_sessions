defmodule VimSessions.AdminPostController do
  use VimSessions.Web, :controller
  import Ecto.Query

  plug Addict.Plugs.Authenticated when action in [:new, :create, :index]

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    IO.inspect params
    changeset = Post.changeset(%Post{}, params
                  |> Map.put("author_id", conn.assigns.current_user.id))
    if changeset.valid? do
      Repo.insert changeset
      redirect conn, to: "/admin/posts"
    else
      conn |> put_flash(:error, Enum.join(Render.get_errors(changeset), "\n"))
           |> put_status(400)
           |> render("new.html")
    end
  end

  def index(conn, _params) do
    user = conn.assigns.current_user
    posts = from(p in Post, limit: 10, select: p) |> Repo.all |> IO.inspect
    render conn, "index.html", posts: posts
  end

end
