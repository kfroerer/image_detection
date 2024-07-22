defmodule Heb.Imagga.Mock do
  @moduledoc """
  Mock API responses from Imagga for local testing
  """

  @behaviour Heb.Imagga.Adapter

  @impl Heb.Imagga.Adapter
  @spec get_tags(map()) :: HTTPoison.Response.t()
  def get_tags(args) do
    %HTTPoison.Response{
      status_code: 200,
      body: "some body",
      headers: [
        {"Date", "Mon, 29 Apr 2024 20:16:16 GMT"},
        {"Content-Type", "application/json"}
      ],
      request_url: "some_url",
      request: %HTTPoison.Request{
        method: :get,
        url: "some url",
        headers: [
          "Content-Type": "application/json",
          Authorization: "Bearer {Json Web Token}",
          Accept: "application/json"
        ],
        body: "",
        params: %{}
      }
    }
  end
end
