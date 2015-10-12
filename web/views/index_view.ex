defmodule VimSessions.IndexView do
  use VimSessions.Web, :view

  def link_to(%Post{id: id} = post, action) do
    VimSessions.Router.Helpers.post_path(VimSessions.Endpoint, action, id)
  end
end
