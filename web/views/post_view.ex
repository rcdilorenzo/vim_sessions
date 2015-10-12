defmodule VimSessions.PostView do
  use VimSessions.Web, :view

  def markdown(content) do
    Earmark.to_html(content, %Earmark.Options{gfm: true}) |> raw
  end
end
