defmodule PhxApp.Blog.Tag do
  use PhxApp.Schema
  import Ecto.Changeset
  alias PhxApp.Blog.Article

  schema "tags" do
    field :icon_path, :string
    field :name, :string
    field :display_name, :string
    many_to_many :articles, Article, join_through: "articles_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :display_name, :icon_path])
    |> validate_required([:name, :display_name, :icon_path])
  end
end
