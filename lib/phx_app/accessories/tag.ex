defmodule PhxApp.Accessories.Tag do
  use PhxApp.Schema
  import Ecto.Changeset
  alias PhxApp.Blog.Article

  schema "tags" do
    field :icon_path, :string
    field :name, :string
    many_to_many :articles, Article, join_through: "articles_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :icon_path])
    |> validate_required([:name, :icon_path])
  end
end
