defmodule PhxApp.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PhxApp.Repo

  alias PhxApp.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users(limit \\ 20, offset \\ 0)
      [%User{}, ...]

  """
  def list_users(limit \\ 20, offset \\ 0) do
    query =
      from u in User,
        limit: ^limit,
        offset: ^offset

    Repo.all(query)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user(456)
      {:error, :not_found}

  """
  def get_user(id) do
    try do
      user = Repo.get!(User, id) |> Repo.preload([:articles])
      {:ok, user}
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
      _e -> {:error, :internal_server_error}
    end
  end

  @doc """
  Gets a single user.
  Raises `Ecto.NoResultsError` if the User does not exist.
  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by name.

  ## Examples

      iex> get_user_by_name("yagi")
      %User{}

      iex> get_user_by_name(nil)
      {:error, :not_found}

  """
  def get_user_by_name(name) do
    try do
      user =
        Repo.get_by!(User, name: name)
        |> Repo.preload([:articles, articles: :user, articles: :tags])

      {:ok, user}
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
      _e -> {:error, :interval_server_error}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
