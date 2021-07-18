defmodule PhxAppWeb.Api.Auth.JwtController do
  use PhxAppWeb, :controller
  alias PhxApp.Accounts
  alias PhxApp.Auth.Guardian

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
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
