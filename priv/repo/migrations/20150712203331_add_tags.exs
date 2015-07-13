defmodule VimSessions.Repo.Migrations.AddTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string, null: false
      timestamps
    end

    create table(:post_tags) do
      add :post_id, references(:posts)
      add :tag_id, references(:tags)
    end
  end
end
