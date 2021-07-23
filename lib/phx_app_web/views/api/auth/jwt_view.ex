defmodule PhxAppWeb.Api.Auth.JwtView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.UserView

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{token: jwt}
    |> Map.put_new(:user, render_one(user, UserView, "user.json"))
  end

  def render("error.json", %{message: msg}) do
    %{
      statusCode: 401,
      message: msg
    }
  end
end
