defmodule Heb.Support.Imagga.Mock do
  @moduledoc """
  Mock API responses from Imagga for local testing
  """

  @spec success_response() :: {:ok, [String.t()]}
  def success_response() do
    {:ok,
     %HTTPoison.Response{
       status_code: 200,
       body:
         "{\"result\": {\"tags\":[{\"confidence\":67.0043640136719,\"tag\":{\"en\":\"domestic\"}}]}}",
       headers: [
         {"Date", "Tue, 23 Jul 2024 14:34:23 GMT"},
         {"Content-Type", "application/json; charset=utf-8"},
         {"Content-Length", "4829"},
         {"Connection", "keep-alive"},
         {"Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS"},
         {"Access-Control-Allow-Headers",
          "content-type, accept, cache-control, x-requested-with, authorization"},
         {"Access-Control-Allow-Origin", "*"},
         {"Monthly-Limit-Remaining", "983"},
         {"Access-Control-Max-Age", "60"},
         {"Monthly-Limit-Reset", "1724351878"},
         {"Monthly-Limit", "1000"}
       ],
       request_url: "test url",
       request: %HTTPoison.Request{
         method: :get,
         url: "test url",
         headers: [],
         body: "",
         params: %{},
         options: []
       }
     }}
  end

  def error_response() do
    {:error,
     %HTTPoison.Response{
       status_code: 400,
       body:
         "{\"status\":{\"text\":\"Unexpected error while running the classification job.\",\"type\":\"error\"}}",
       headers: [
         {"Date", "Tue, 23 Jul 2024 14:27:02 GMT"},
         {"Content-Type", "application/json; charset=utf-8"},
         {"Content-Length", "91"},
         {"Connection", "keep-alive"},
         {"Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS"},
         {"Access-Control-Allow-Headers",
          "content-type, accept, cache-control, x-requested-with, authorization"},
         {"Access-Control-Allow-Origin", "*"},
         {"Monthly-Limit-Remaining", "985"},
         {"Access-Control-Max-Age", "60"},
         {"Monthly-Limit-Reset", "1724351878"},
         {"Monthly-Limit", "1000"}
       ],
       request_url: "some url",
       request: %HTTPoison.Request{
         method: :get,
         url: "some other url",
         headers: [],
         body: "",
         params: %{},
         options: []
       }
     }}
  end
end

# curl -iX POST http://localhost:4000/images \
#    -H 'Content-Type: application/json' \
#    -d '{"image_url":"https://images.app.goo.gl/MRs3aeS2RCuRRChM9", "detect_objects":true}'
