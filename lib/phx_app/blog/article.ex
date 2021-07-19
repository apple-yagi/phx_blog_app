defmodule PhxApp.Blog.Article do
  use PhxApp.Schema
  import Ecto.Changeset
  alias PhxApp.Accounts.User
  alias PhxApp.Accessories.Tag

  schema "articles" do
    field :content, :string
    field :title, :string
    field :thumbnail_url, :string
    belongs_to :user, User
    many_to_many :tag, Tag, join_through: "articles_tags"

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :content, :thumbnail_url, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
