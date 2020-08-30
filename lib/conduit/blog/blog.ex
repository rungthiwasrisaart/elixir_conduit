defmodule Conduit.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  # alias Conduit.Blog.Projections.Article
  alias Conduit.Blog.Commands.{CreateAuthor, PublishArticle}
  alias Conduit.Blog.Projections.{Author, Article}
  alias Conduit.Blog.Queries.ArticleBySlug
  alias Conduit.{Repo, App}

  @doc """
  Create an author.
  An author shares the same uuid as the user, but with a different prefix.
  """
  def create_author(%{user_uuid: uuid} = attrs) do
    create_author =
      attrs
      |> CreateAuthor.new()
      |> CreateAuthor.assign_uuid(uuid)

    with :ok <- App.dispatch(create_author, consistency: :strong) do
      get(Author, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Publishes an article by the given author.
  """
  def publish_article(%Author{} = author, attrs \\ %{}) do
    uuid = UUID.uuid4()

    publish_article =
      attrs
      |> PublishArticle.new()
      |> PublishArticle.assign_uuid(uuid)
      |> PublishArticle.assign_author(author)
      |> PublishArticle.generate_url_slug()

    with :ok <- App.dispatch(publish_article, consistency: :strong) do
      get(Article, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Get an article by its URL slug, or return `nil` if not found.
  """
  def article_by_slug(slug) do
    slug
    |> String.downcase()
    |> ArticleBySlug.new()
    |> Repo.one()
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
