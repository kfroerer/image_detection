defmodule ImaggaTest do
  use ExUnit.Case, async: true

  alias Heb.Imagga

  describe("handle_tag_response") do
    test "returns parsed tags" do
      response = successful_response()
      {:ok, tags} = Imagga.handle_tag_response(response)
      assert tags == ["domestic"]
    end
  end

  defp successful_response() do
    Heb.Support.Imagga.Mock.success_response()
  end
end
