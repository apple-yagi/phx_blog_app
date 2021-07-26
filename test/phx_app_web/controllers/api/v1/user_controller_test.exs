defmodule PhxAppWeb.Api.V1.UserControllerTest do
  use PhxAppWeb.ConnCase

  alias PhxApp.Accounts

  @create_attrs %{name: "JoneDoe", password: "password"}
  @invalid_attrs %{name: nil, password: nil}
  @update_attrs %{name: "UpdateDoe"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    setup [:create_user]

    test "lists all users", %{conn: conn} do
      response = get(conn, Routes.user_path(conn, :index))
      users = Jason.decode!(response.resp_body)

      assert response.status == 200
      assert length(users) == 1
    end
  end

  describe "show" do
    setup [:create_user]

    test "gets a single user", %{conn: conn, user: user} do
      response = get(conn, Routes.user_path(conn, :show, user.name))
      user_as_json = Jason.decode!(response.resp_body)

      assert response.status == 200
      assert user.id == user_as_json["id"]
    end

    test "not found user", %{conn: conn, user: _user} do
      dummy_uuid = Ecto.UUID.generate()
      response = get(conn, Routes.user_path(conn, :show, dummy_uuid))

      assert response.status == 404
    end
  end

  describe "create user" do
    test "response user when data is valid", %{conn: conn} do
      response = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      user_as_json = Jason.decode!(response.resp_body)

      assert response.status == 201
      assert @create_attrs[:name] == user_as_json["name"]
    end

    test "response error when data is invalid", %{conn: conn} do
      response = post(conn, Routes.user_path(conn, :create), user: @update_attrs)
      errors_as_json = Jason.decode!(response.resp_body)

      assert response.status == 422
      assert Map.has_key?(errors_as_json, "errors") == true
    end
  end

  describe "update user" do
    setup [:create_user]

    test "response unauthorized when not logged in", %{conn: conn, user: user} do
      response = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)

      assert response.status == 401
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "response unauthorized when not logged in", %{conn: conn, user: user} do
      response = delete(conn, Routes.user_path(conn, :delete, user))

      assert response.status == 401
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
