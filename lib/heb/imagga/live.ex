defmodule Heb.Imagga.Live do
  @behaviour Heb.Imagga.Adapter
  require Logger

  # get the api key and put it in the config?
  # get the api url

  @impl Heb.Imagga.Adapter
  def get_tags(args) do
    headers = [
      "Content-Type": "application/json",
      Authorization: "Bearer #{}",
      Accept: "application/json"
    ]

    url = ""

    # is it POST or is it GET- look up
    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200} = response} ->
        response

      {:ok, %{status_code: 401} = reason} ->
        Logger.error("Error Code 401: #{reason}")
        nil

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Other Error: #{reason}")
        nil
    end
  end
end
