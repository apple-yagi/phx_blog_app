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

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    Repo.one(query)
    |> check_password(plain_text_password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect username or password"}

  defp check_password(user, plain_text_password) do
    case Bcrypt.verify_pass(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end

  @spec check_policy(%User{}, %User{}) :: :ok | {:error, :forbidden}
  def check_policy(user, current_user)
      when is_struct(user, User) and is_struct(current_user, User) do
    case user.id == current_user.id do
      true -> :ok
      false -> {:error, :forbidden}
    end
  end

  @spec check_policy(String, String) :: :ok | {:errro, :forbidden}
  def check_policy(id, user_id) when is_binary(id) and is_binary(user_id) do
    case id == user_id do
      true -> :ok
      false -> {:error, :forbidden}
    end
  end
end
