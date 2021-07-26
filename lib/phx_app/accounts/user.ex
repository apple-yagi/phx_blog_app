defmodule PhxApp.Accounts.User do
  use PhxApp.Schema
  import Ecto.Changeset
  alias PhxApp.Blog.Article

  schema "users" do
    field(:name, :string)

    field(:photo_url, :string,
      default: "https://d1d9yfqtve2e82.cloudfront.net/account_photo/beginner_dog.png"
    )

    field(:password, :string)

    has_many(:articles, Article)
    timestamps()
  end

  @doc false
  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :photo_url, :password])
    |> validate_required([:name, :password])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 4)
    |> validate_length(:password, min: 5)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
