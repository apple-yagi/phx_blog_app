defmodule PhxApp.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias PhxApp.Repo

  alias PhxApp.Accounts.User
  alias PhxApp.Blog.Article

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_article(123)
      {:ok, %Article{}}

      iex> get_user(456)
      {:error, :not_found}

  """
  def get_article(id) do
    try do
      article = Repo.get!(Article, id)
      {:ok, article}
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
      _e -> {:error, :internal_server_error}
    end
  end

  @spec get_article!(any) :: any
  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @spec create_article(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any},
          %User{}
        ) :: any
  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})e
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}, current_user) do
    Ecto.build_assoc(current_user, :articles)
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
