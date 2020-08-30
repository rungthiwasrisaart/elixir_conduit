defmodule Conduit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Accounts.Projections.User
  alias Conduit.Accounts.Queries.UserByUsername
  alias Conduit.Repo
  alias Conduit.App

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    register_user =
      attrs
      |> assign(:user_uuid, uuid)
      |> RegisterUser.new()

    with :ok <- App.dispatch(register_user, consistency: :strong) do
      get(User, uuid)
    else
      reply -> reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end

  @doc """
  Get an existing user by their username, or return `nil` if not registered
  """
  def user_by_username(username) do
    username
    |> String.downcase()
    |> UserByUsername.new()
    |> Repo.one()
  end

  # generate a unique identity
  defp assign(attrs, key, value), do: Map.put(attrs, key, value)
end
