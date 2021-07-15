defmodule PhxAppWeb.Api.V1.UserController do
  use PhxAppWeb, :controller

  alias PhxApp.Accounts
  alias PhxApp.Accounts.User

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user!(id) do
      render(conn, "show.json", user: user)
    else
      err -> err
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, user} <- Accounts.get_user!(id),
         {:ok, %User{} = user} <- Accounts.update_user(user, update_params(user_params)) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user!(id),
         {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def update_params(user_params) do
    filter_list = ["password"]
    Map.drop(user_params, filter_list)
  end
end
