defmodule PostTag do
  use Ecto.Model

  schema "post_tags" do
    belongs_to :post, Post
    belongs_to :tag, Tag
  end
end
