defmodule Heb.ImagesTest do
  use Heb.DataCase

  alias Heb.Images

  describe "images" do
    alias Heb.Images.Image

    import Heb.ImagesFixtures

    @invalid_attrs %{label: nil, uri: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Images.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Images.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{label: "some label", uri: "some uri"}

      assert {:ok, %Image{} = image} = Images.create_image(valid_attrs)
      assert image.label == "some label"
      assert image.uri == "some uri"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Images.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{label: "some updated label", uri: "some updated uri"}

      assert {:ok, %Image{} = image} = Images.update_image(image, update_attrs)
      assert image.label == "some updated label"
      assert image.uri == "some updated uri"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Images.update_image(image, @invalid_attrs)
      assert image == Images.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Images.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Images.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Images.change_image(image)
    end

    test "find_matching_images" do
      image_fixture()
      [first_image | _] = Images.find_matching_images(["dog"])
      assert Enum.any?(first_image.tags, fn tag -> tag == "dog" end)

      assert [] = Images.find_matching_images(["woman"])
    end
  end
end
