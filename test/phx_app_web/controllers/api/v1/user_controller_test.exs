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

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
