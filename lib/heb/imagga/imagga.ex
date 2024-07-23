defmodule Heb.Imagga do
  require Logger
  alias Heb.Imagga.Adapter
  alias Heb.Images

  @base_url "https://api.imagga.com/v2/"
  @type responses ::
          {:ok, HTTPoison.Response.t()}
          | {:error, HTTPoison.Error.t()}

  # TODO: handle local files, move into adapter.
  @spec get_image_tags_by_url(String.t()) :: [String.t()] | {:error, HTTPoison.Error.t()}
  def get_image_tags_by_url(image_url) do
    # {:ok, binary} = File.read("lib/resources/DSC_0150.jpg")
    url = @base_url <> "tags?image_url=" <> image_url
    headers = get_headers()
    response = HTTPoison.get(url, headers)
    handle_response(response)
  end

  def get_headers() do
    [
      {"Authorization",
       "Basic " <> api_key}
    ]
  end

  @spec handle_response(responses) :: [String.t()] | {:error, HTTPoison.Error.t()}
  def handle_response(response) do
    case response do
      {:ok, %{status_code: 200, body: body}} ->
        with {:ok, decoded_body} <- Jason.decode(body, keys: :atoms) do
          parse_result_for_tags(decoded_body.result)
        end

      {:ok, %{status_code: status_code} = response} ->
        Logger.info("Non 200 response received. Status code: #{status_code}")
        {:error, response}

      {:error, response_error} ->
        Logger.error("Imagga request error")
        {:error, response_error}
    end
  end

  @spec parse_result_for_tags(map()) :: [Strings.t()]
  def parse_result_for_tags(%{tags: tags}) do
    tags
    |> Enum.map(fn t ->
      if t.confidence > 0.55, do: Map.values(t.tag)
    end)
    |> Enum.take(5)
    |> List.flatten()
  end

  def parse_result_for_tags(_), do: []
end
