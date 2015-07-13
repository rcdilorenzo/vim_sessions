defmodule VimSessions.Repo.Migrations.AddCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      timestamps
    end

    alter table(:posts) do
      add :category_id, references(:categories)
    end
  end
end
