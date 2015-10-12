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

  def changeset(model, params \\ nil) do
    params = Enum.reduce params, %{}, fn
      ({key, ""}, map) -> map
      ({key, value}, map) -> Map.put(map, key, value)
    end
    model |> cast(params, ~w(title description content author_id), ~w(video_url))
  end

  def latest do
    from(p in Post, order_by: [desc: p.inserted_at], limit: 1) |> VimSessions.Repo.one!
  end

  defimpl Poison.Encoder do
    def encode(self, _) do
      self |> Map.from_struct
           |> Map.take([:title, :description, :video_url, :content])
           |> Poison.encode!
    end
  end
end
