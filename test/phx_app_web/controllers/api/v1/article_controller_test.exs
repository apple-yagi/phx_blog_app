defmodule PhxAppWeb.Api.V1.ArticleControllerTest do
  use PhxAppWeb.ConnCase

  alias PhxApp.Accounts
  alias PhxApp.Blog

  @create_user_attrs %{email: "test@example.com", name: "Jone Doe", password: "password"}
  @create_article_attrs %{content: "some content", title: "some title"}

  def fixture(:article) do
    {:ok, user} = Accounts.create_user(@create_user_attrs)
    {:ok, article} = Blog.create_article(@create_article_attrs, user)
    article
  end

  describe "index" do
    setup [:create_article]

    test "lists all articles", %{conn: conn} do
      response = get(conn, Routes.article_path(conn, :index))
      articles = Jason.decode!(response.resp_body)

      assert response.status == 200
      assert length(articles) == 1
    end
  end

  defp create_article(_) do
    article = fixture(:article)
    %{article: article}
  end
end
