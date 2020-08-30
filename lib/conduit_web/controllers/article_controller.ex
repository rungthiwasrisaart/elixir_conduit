defmodule ConduitWeb.ArticleController do
  use ConduitWeb, :controller

  # alias Conduit.Blog
  # alias Conduit.Blog.Article

  action_fallback ConduitWeb.FallbackController
end
