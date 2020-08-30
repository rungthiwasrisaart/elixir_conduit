defmodule Conduit.Blog.Projections.Article do
  use Ecto.Schema

  schema "blog_articles" do
    field :author_bio, :string
    field :author_image, :string
    field :author_username, :string
    field :author_uuid, :binary
    field :body, :string
    field :description, :string
    field :favorite_count, :integer
    field :published_at, :naive_datetime
    field :slug, :string
    field :tag_list, {:array, :string}
    field :title, :string

    timestamps()
  end
end
