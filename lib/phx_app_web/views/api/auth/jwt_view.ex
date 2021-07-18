defmodule PhxAppWeb.Api.Auth.JwtView do
  use PhxAppWeb, :view

  def render("sign_in.json", %{user: _user, jwt: jwt}) do
    %{token: jwt}
  end

  def render("error.json", %{message: msg}) do
    %{
      statusCode: 401,
      message: msg
    }
  end
end
