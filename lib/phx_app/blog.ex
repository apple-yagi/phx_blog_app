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

      iex> list_articles(limit \\ 20, offset \\ 0)
      [%Article{}, ...]

  """
  def list_articles(limit \\ 20, offset \\ 0) do
    query =
      from a in Article,
        limit: ^limit,
        offset: ^offset,
        preload: [:user, :tags],
        order_by: [desc: :inserted_at]

    Repo.all(query)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_article(%User{}, 123)
      {:ok, %Article{}}

      iex> get_user(%{}, 456)
      {:error, :not_found}

  """
  def get_user_article(%User{id: user_id}, id) do
    try do
      article =
        Article
        |> where([a], a.id == ^id and a.user_id == ^user_id)
        |> Repo.one()
        |> Repo.preload([:user, :tags])

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

  alias PhxApp.Blog.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  ## Examples

      iex> get_tag(123)
      {:ok, %Tag{}}

      iex> get_tag(456)
      {:error, :not_found}
  """
  def get_tag(id) do
    try do
      tag = Repo.get(Tag, id) |> Repo.preload([:articles, articles: :user, articles: :tags])
      {:ok, tag}
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
      _e -> [:error, :internal_server_error]
    end
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Gets a single tag.

  ## Examples

      iex> get_tag(123)
      {:ok, %Tag{}}

      iex> get_tag(456)
      {:error, :not_found}
  """
  def get_tag_by_name(name) do
    try do
      tag =
        Repo.get_by!(Tag, name: name)
        |> Repo.preload([:articles, articles: :user, articles: :tags])

      {:ok, tag}
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
      _e -> {:error, :interval_server_error}
    end
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  @doc """
  Associate a tag.

  ## Examples

      iex> assoc_article_tag(article, tags)
      {:ok, %Article{}}

      iex> assoc_article_tag(article, tags)
      {:error, %Ecto.Changeset{}}
  """
  def assoc_article_tags(%Article{} = article, tags) do
    article
    |> Repo.preload(:tags)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:tags, tags |> Enum.map(&get_tag!(&1)))
    |> Repo.update()
  end
end
