defmodule PhxAppWeb.Api.V1.UserController do
  use PhxAppWeb, :controller

  alias PhxAppWeb.Helper.ActionHelper
  alias PhxApp.Auth
  alias PhxApp.Accounts
  alias PhxApp.Accounts.User

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def action(conn, _) do
    apply_args = ActionHelper.get_apply_args(conn)
    apply(__MODULE__, action_name(conn), apply_args)
  end

  def index(conn, params) do
    users = Accounts.list_users(params["limit"], params["offset"])
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user) do
    with {:ok, user} <- Accounts.get_user(id),
         :ok <- Auth.check_policy(user, current_user),
         {:ok, %User{} = user} <- Accounts.update_user(user, update_params(user_params)) do
      render(conn, "user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    with {:ok, user} <- Accounts.get_user(id),
         :ok <- Auth.check_policy(user, current_user),
         {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def update_params(user_params) do
    filter_list = ["password"]
    Map.drop(user_params, filter_list)
  end
end
