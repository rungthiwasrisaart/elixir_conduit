defmodule Conduit.Router do
  use Commanded.Commands.Router

  alias Conduit.Accounts.Aggregates.User
  alias Conduit.Accounts.Commands.RegisterUser

  alias Conduit.Blog.Aggregates.Author
  alias Conduit.Blog.Commands.CreateAuthor

  alias Conduit.Support.Middleware.{Uniqueness, Validate}

  middleware(Validate)
  middleware(Uniqueness)

  identify(Author, by: :author_uuid, prefix: "author-")
  identify(User, by: :user_uuid, prefix: "user-")

  dispatch([RegisterUser], to: User)
  dispatch([CreateAuthor], to: Author)
end
