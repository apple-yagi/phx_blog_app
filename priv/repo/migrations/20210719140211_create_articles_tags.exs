defmodule PhxApp.Repo.Migrations.CreateArticlesTags do
  use Ecto.Migration

  def change do
    create table(:articles_tags) do
      add :article_id, references(:articles, type: :uuid, on_delete: :nothing)
      add :tag_id, references(:tags, type: :uuid, on_delete: :nothing)
    end

    create unique_index(:articles_tags, [:article_id, :tag_id])
  end
end
