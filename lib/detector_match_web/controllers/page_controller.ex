defmodule DetectorMatchWeb.PageController do
  use DetectorMatchWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
