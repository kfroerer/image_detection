defmodule Heb.Imagga do
  require Logger
  alias Heb.Imagga.Adapter

  @base_url "https://api.imagga.com/v2/"
  @type responses ::
          {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
          | {:error, HTTPoison.Error.t()}

  # TODO: handle local files, move into adapter.
  def get_image_tags_by_url(image_url) do
    # parse the args?
    # {:ok, binary} = File.read("lib/resources/DSC_0150.jpg")
    url = @base_url <> "tags?image_url=" <> image_url
    headers = get_headers()
    # send the request
    response = HTTPoison.get(url, headers)
    # handle_response
    handle_response(response)
  end

  def get_headers() do
    [
      {"Authorization",
       "Basic " <> api_key}
    ]
  end

  @spec handle_response(responses) :: Image.t() | :error
  def handle_response(response) do
    case response do
      {:ok, %{status_code: 200, body: body} = successful_response} ->
        with {:ok, decoded_body} <- Jason.decode(body, keys: :atoms) do
          parse_result_for_tags(decoded_body.result)
        end

      {:ok, %{status_code: status_code} = response} ->
        Logger.info("Non 200 response received. Status code: #{status_code}")

      {:error, response_error} ->
        Logger.error("Imagga request error")
        Logger.error(response_error)
    end
  end

  @spec parse_result_for_tags(map()) :: [Strings.t()]
  def parse_result_for_tags(%{tags: tags}) do
    image_tags =
      tags
      |> Enum.map(fn t ->
        if t.confidence > 0.55, do: Map.values(t.tag)
      end)
      |> Enum.take(5)
      |> List.flatten()

    IO.inspect(image_tags)
    # save image with tags
  end
end
