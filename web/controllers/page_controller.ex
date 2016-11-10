defmodule StarterApp.PageController do
  use StarterApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
