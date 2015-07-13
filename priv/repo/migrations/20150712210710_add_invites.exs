defmodule VimSessions.Repo.Migrations.AddInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :code,        :string, null: false
      add :valid_until, :datetime, null: false
      timestamps
    end
  end
end
