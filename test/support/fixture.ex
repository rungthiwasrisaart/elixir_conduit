defmodule Conduit.Fixture do
  alias Conduit.{Accounts, Blog}

  import Conduit.Factory

  def fixture(resource, attrs \\ [])

  def fixture(:user, attrs) do
    build(:user, attrs) |> Accounts.register_user()
  end

  def fixture(:author, attrs) do
    build(:author, attrs) |> Blog.create_author()
  end
end
