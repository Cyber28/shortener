defmodule ShortenerWeb.PageController do
  use ShortenerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def red(conn, %{"id" => id}) do
    case :dets.lookup(:disk_storage, id) do
      [{_, here}] -> redirect(conn, external: here)
      [] -> redirect(conn, to: "/")
    end
  end
end
