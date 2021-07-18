defmodule PhxAppWeb.Api.V1.UserController do
  use PhxAppWeb, :controller

  alias PhxApp.Accounts
  alias PhxApp.Accounts.User

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def action(conn, _) do
    current_user =
      if Map.has_key?(conn.assigns, :current_user) do
        elem(conn.assigns.current_user, 1)
      else
        nil
      end

    apply(__MODULE__, action_name(conn), [
      conn,
      conn.params,
      current_user
    ])
  end

  def index(conn, _params, _) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}, _) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}, _) do
    with {:ok, user} <- Accounts.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user) do
    with {:ok, user} <- Accounts.get_user(id),
         :ok <- Accounts.check_policy(user, current_user),
         {:ok, %User{} = user} <- Accounts.update_user(user, update_params(user_params)) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    with {:ok, user} <- Accounts.get_user(id),
         :ok <- Accounts.check_policy(user, current_user),
         {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def update_params(user_params) do
    filter_list = ["password"]
    Map.drop(user_params, filter_list)
  end
end
