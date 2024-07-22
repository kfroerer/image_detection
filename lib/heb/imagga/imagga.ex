defmodule Heb.Imagga do
  alias Hex.HTTP
  alias Heb.Imagga.Adapter

  @base_url "https://api.imagga.com/v2/"

  def get_image_tags_by_url(image_url) do
    # {:ok, binary} = File.read("lib/resources/DSC_0150.jpg")
    url = @base_url <> "tags?image_url=" <> image_url
    headers = get_headers()
    HTTPoison.get(url, headers)
    # handle_response(response)
    # parse the args
    # build the request
    # send the request
    # handle the response
  end

  def get_headers() do
    [
      {"Authorization",
       "Basic " <> api_key}
    ]
  end
end

# working curl commands:
# local image to upload
# curl --user "acc_a8e4e280bcab4b4:ae63eb2eb8da46b04ca845b825e33321" -F "image=@lib/resources/DSC_0150.jpg" "https://api.imagga.com/v2/uploads"

# getting tags for that:
# curl --user "acc_a8e4e280bcab4b4:ae63eb2eb8da46b04ca845b825e33321" "https://api.imagga.com/v2/tags?image_upload_id=i20eba48d3fd61di3ZmKg"

# using an image url:
# curl -v --user "acc_a8e4e280bcab4b4:ae63eb2eb8da46b04ca845b825e33321" "https://api.imagga.com/v2/tags?image_url=https://imagga.com/static/images/tagging/wind-farm-538576_640.jpg"
