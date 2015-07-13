defmodule VimSessions.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name,    :string, null: false
      add :last_name,     :string, null: false
      add :username,      :string, null: false
      add :email,         :string, null: false
      add :hash,          :string
      add :recovery_hash, :string
      add :bio,           :text
      timestamps
    end

    alter table(:posts) do
      add :author_id, references(:users)
    end
  end
end
