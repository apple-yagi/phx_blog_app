defmodule PhxAppWeb.Api.V1.UserControllerTest do
  use PhxAppWeb.ConnCase

  alias PhxApp.Accounts

  @create_attrs %{email: "test@example.com", name: "Jone Doe", password: "password"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    setup [:create_user]

    test "lists all users", %{conn: conn} do
      response = get(conn, "/api/v1/users")
      users = Jason.decode!(response.resp_body)

      assert response.status == 200
      assert length(users) == 1
    end
  end

  describe "show" do
    setup [:create_user]

    test "gets a single user", %{conn: conn, user: user} do
      response = get(conn, Routes.user_path(conn, :show, user))
      user_as_json = Jason.decode!(response.resp_body)

      assert response.status == 200
      assert user.id == user_as_json["id"]
    end

    test "not found user", %{conn: conn, user: user} do
      response = get(conn, Routes.user_path(conn, :show, user.id + 1))

      assert response.status == 404
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
