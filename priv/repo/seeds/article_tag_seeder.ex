defmodule PhxApp.Repo.Seeds.ArticleTagSeeder do
  import Ecto.Query, warn: false
  alias PhxApp.Repo
  alias PhxApp.Blog
  alias PhxApp.Blog.Article
  alias PhxApp.Blog.Tag

  @articles_path "priv/repo/seeds/json/articles.json"

  def seed do
    @articles_path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Repo.get_by!(Article, title: &1["title"]) |> Blog.assoc_article_tags(get_tag_ids()))
  end

  defp get_tag_ids do
    query =
      from t in Tag,
        order_by: fragment("RANDOM()"),
        limit: 3

    Repo.all(query)
    |> Enum.map(fn(x) -> x.id end)
  end
end
