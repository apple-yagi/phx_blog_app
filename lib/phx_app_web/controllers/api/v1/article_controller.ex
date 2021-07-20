defmodule PhxAppWeb.Api.V1.ArticleController do
  use PhxAppWeb, :controller

  alias PhxApp.Accounts
  alias PhxApp.Blog
  alias PhxApp.Blog.Article

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def action(conn, _) do
    current_user =
      if Map.has_key?(conn.assigns, :current_user) do
        elem(conn.assigns.current_user, 1)
      else
        nil
      end

    apply(__MODULE__, action_name(conn), [
      conn,
      conn.params,
      current_user
    ])
  end

  def index(conn, _params, _) do
    articles = Blog.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params, "tags" => tags_params}, current_user) do
    with {:ok, %Article{} = article} <-
           Blog.create_article(article_params, current_user),
         {:ok, %Article{} = article} <-
           Blog.assoc_article_tags(article, tags_params) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}, _) do
    with {:ok, article} <- Blog.get_article(id) do
      render(conn, "show.json", article: article)
    end
  end

  def update(conn, %{"id" => id, "article" => article_params}, current_user) do
    with {:ok, article} <- Blog.get_article(id),
         :ok <- Accounts.check_policy(article.user_id, current_user.id),
         {:ok, %Article{} = article} <- Blog.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    with {:ok, article} <- Blog.get_article(id),
         :ok <- Accounts.check_policy(article.user_id, current_user.id),
         {:ok, %Article{}} <- Blog.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
