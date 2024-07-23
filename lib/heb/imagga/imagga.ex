defmodule Heb.Imagga do
  require Logger

  @base_url "https://api.imagga.com/v2/"
  @type responses ::
          {:ok, HTTPoison.Response.t()}
          | {:error, HTTPoison.Error.t()}

  def get_headers() do
    api_key = Application.get_env(:heb, :api_key)

    [
      {"Authorization", "Basic " <> api_key}
    ]
  end

  @spec get_image_tags_by_url(String.t()) :: {:ok, [String.t()]} | {:error, HTTPoison.Error.t()}
  def get_image_tags_by_url(image_url) do
    url = @base_url <> "tags?image_url=" <> image_url
    headers = get_headers()
    response = HTTPoison.get(url, headers) |> IO.inspect()
    handle_tag_response(response)
  end

  @spec handle_tag_response(responses) :: {:ok, [String.t()]} | {:error, HTTPoison.Error.t()}
  def handle_tag_response(response) do
    case response do
      {:ok, %{status_code: 200, body: body}} ->
        with {:ok, decoded_body} <- Jason.decode(body, keys: :atoms) do
          {:ok, parse_result_for_tags(decoded_body.result)}
        end

      {:ok, %{status_code: status_code} = response} ->
        Logger.info("Non 200 response received. Status code: #{status_code}")
        {:error, response}

      {:error, response_error} ->
        Logger.error("Imagga request error")
        {:error, response_error}
    end
  end

  def get_image_tags_from_file(file_path) do
    make_upload_request(file_path)
  end

  def make_upload_request(file_path) do
    api_key = Application.get_env(:heb, :api_key)

    headers =
      [
        {"Authorization", "Basic " <> api_key},
        {"Content-Type", "multipart/form-data"},
        multipart: :multipart
      ]

    body =
      {:multipart,
       [
         {:file, file_path,
          {"form-data", [{:name, "image"}, {:filename, Path.basename(file_path)}]}, []}
       ]}

    HTTPoison.post(
      @base_url <> "uploads",
      body,
      headers
    )
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
