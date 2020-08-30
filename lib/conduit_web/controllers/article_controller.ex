defmodule ConduitWeb.ArticleController do
  use ConduitWeb, :controller

  alias Conduit.Blog
  alias Conduit.Blog.Projections.Article

  action_fallback ConduitWeb.FallbackController

  plug(Guardian.Plug.EnsureAuthenticated when action in [:current])

  def create(conn, %{"article" => article_params}) do
    user = Conduit.Auth.Guardian.Plug.current_resource(conn)
    author = Blog.get_author!(user.uuid)

    with {:ok, %Article{} = article} <- Blog.publish_article(author, article_params) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def index(conn, params) do
    {articles, total_count} = Blog.list_articles(params)
    render(conn, "index.json", articles: articles, total_count: total_count)
  end
end
