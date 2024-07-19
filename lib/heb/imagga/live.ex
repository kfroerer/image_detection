defmodule Heb.Imagga.Live do
  @behaviour Heb.Imagga.Adapter

  # get the api key and put it in the config?
  # get the api url

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
        Crowbar.Logger.error("some reason", reason: reason)
        nil

      {:error, %HTTPoison.Error{reason: reason}} ->
        Crowbar.Logger.error("unknown reason ", reason: reason)
        nil
    end
  end
end
