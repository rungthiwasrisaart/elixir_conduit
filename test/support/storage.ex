defmodule Conduit.Storage do
  @doc """
  Reset the event store and read store databases.
  """
  def reset! do
    :ok = Application.stop(:conduit)

    reset_eventstore!()
    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:conduit)
  end

  defp reset_eventstore! do
    {:ok, conn} =
      Conduit.EventStore.config()
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore! do
    {:ok, conn} = Conduit.Repo.config() |> Postgrex.start_link()
    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      accounts_users,
      projection_versions,
      blog_authors
    RESTART IDENTITY;
    """
  end
end
