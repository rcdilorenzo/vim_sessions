Code.require_file "factory.exs", "factories/"
Code.require_file "factory_model.exs", "factories/"

defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Populates with sample posts"
  def run(_) do
    VimSessions.Repo.start_link
    Factory.Post.create_list(:default, 20)
  end
end
