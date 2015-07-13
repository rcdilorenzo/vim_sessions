defmodule VimSessions.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title,       :string, null: false
      add :description, :string, null: false
      add :content,     :text
      add :video_url,   :string

      timestamps
    end
  end
end
