defmodule Invite do
  use Ecto.Model

  schema "invites" do
    field :code,        Ecto.UUID, null: false
    field :valid_until, :datetime, null: false
    timestamps
  end
end
