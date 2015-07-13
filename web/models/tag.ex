defmodule Tag do
  use Ecto.Model

  schema "tags" do
    field :name
    timestamps

    has_many :post_tags, PostTag
    has_many :posts, through: [:post_tags, :post]
  end
end
