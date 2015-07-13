defmodule Post do
  use Ecto.Model

  schema "posts" do
    field :title
    field :description
    field :content
    field :video_url
    timestamps

    belongs_to :author, User
    belongs_to :category, Category
    has_many :post_tags, PostTag
    has_many :tags, through: [:post_tags, :tag]
  end
end
