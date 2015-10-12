defmodule User do
  use Ecto.Model

  schema "users" do
    field :first_name
    field :last_name
    field :username
    field :email
    field :hash
    field :recovery_hash
    field :bio
    timestamps

    has_many :posts, Post
  end

  def changeset(user, params \\ nil) do
    params = Enum.reduce params, %{}, fn
      ({key, ""}, map) -> map
      ({key, value}, map) -> Map.put(map, key, value)
    end
    user
     |> cast(params, ~w(first_name last_name username email bio))
     |> validate_format(:email, ~r/@/)
  end

  defimpl Poison.Encoder do
    def encode(self, _) do
      self |> Map.from_struct
           |> Map.take([:username, :email, :first_name, :last_name])
           |> Poison.encode!
    end
  end
end
