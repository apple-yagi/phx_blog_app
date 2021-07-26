defmodule PhxApp.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias PhxApp.Repo

  alias PhxApp.Accounts.User

  def authenticate_user(name, plain_text_password) do
    query = from u in User, where: u.name == ^name

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
