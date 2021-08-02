defmodule PhxApp.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :display_name, :string, null: false
      add :icon_path, :string

      timestamps()
    end

    create unique_index(:tags, [:name])
  end
end
