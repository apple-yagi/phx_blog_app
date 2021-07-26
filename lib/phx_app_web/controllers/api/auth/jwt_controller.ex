defmodule PhxAppWeb.Api.Auth.JwtController do
  use PhxAppWeb, :controller
  alias PhxApp.Auth
  alias PhxApp.Auth.Guardian

  def sign_in(conn, %{"user" => %{"name" => name, "password" => password}}) do
    case Auth.authenticate_user(name, password) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

        conn
        |> render("sign_in.json", user: user, jwt: jwt)

      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end
end
