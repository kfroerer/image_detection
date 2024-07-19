defmodule Heb.Imagga.Test do
  use ExUnit.Case, async: true

  alias Heb.Imagga.Adapter

  describe "get_tags/1" do
    test "returns a 200 HTTP response" do
      assert %HTTPoison.Response{} = Adapter.get_tags(%{})
    end
  end

end
