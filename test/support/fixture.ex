defmodule Conduit.Fixture do
  alias Conduit.Accounts

  import Conduit.Factory

  def fixture(:user, attrs \\ []) do
    build(:user, attrs) |> Accounts.register_user()
  end
end
