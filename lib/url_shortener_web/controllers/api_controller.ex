defmodule ShortenerWeb.ApiController do
  use ShortenerWeb, :controller

  def new(conn, %{"id" => id, "link" => link, "key" => key}) do
    IO.inspect([id, link, key])

    cond do
      key != Application.fetch_env!(:url_shortener, :secret_key) ->
        send_resp(conn, 403, "")

      verify_id!(id) == false ->
        send_resp(conn, 400, "")

      true ->
        :dets.insert(:disk_storage, {id, link})
        send_resp(conn, 201, "")
    end
  end

  defp verify_id!(id) do
    if Regex.match?(~r/([a-z]|[A-Z]|\d)+/, id), do: true, else: false
  end
end
