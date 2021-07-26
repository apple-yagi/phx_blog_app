defmodule PhxAppWeb.Api.V1.ArticleController do
  use PhxAppWeb, :controller

  alias PhxAppWeb.Helper.ActionHelper
  alias PhxApp.Auth
  alias PhxApp.Blog
  alias PhxApp.Blog.Article

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def action(conn, _) do
    apply_args = ActionHelper.get_apply_args(conn)
    apply(__MODULE__, action_name(conn), apply_args)
  end

  def index(conn, params) do
    articles = Blog.list_articles(params["limit"], params["offset"])
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params, "tags" => tags_params}, current_user) do
    with {:ok, %Article{} = article} <-
           Blog.create_article(article_params, current_user),
         {:ok, %Article{} = article} <-
           Blog.assoc_article_tags(article, tags_params),
         {:ok, %Article{} = article} <-
           Blog.get_article(article.id) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, article} <- Blog.get_article(id) do
      render(conn, "show.json", article: article)
    end
  end

  def update(conn, %{"id" => id, "article" => article_params}, current_user) do
    with {:ok, article} <- Blog.get_article(id),
         :ok <- Auth.check_policy(article.user_id, current_user.id),
         {:ok, %Article{} = article} <- Blog.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    with {:ok, article} <- Blog.get_article(id),
         :ok <- Auth.check_policy(article.user_id, current_user.id),
         {:ok, %Article{}} <- Blog.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
