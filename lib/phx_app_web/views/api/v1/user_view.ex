defmodule PhxAppWeb.Api.V1.UserView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      createdAt: user.inserted_at,
      updatedAt: user.updated_at
    }
  end
end
