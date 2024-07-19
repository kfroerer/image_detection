defmodule Heb.Imagga.Adapter do
  @callback get_tags(map()) :: HTTPoison.Response.t() | nil
end
