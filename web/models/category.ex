defmodule Category do
  use Ecto.Model

  schema "categories" do
    field :name
    timestamps

    has_many :posts, Post
    has_many :post_authors, through: [:posts, :author]
  end
end
