# defmodule PhxApp.AccessoriesTest do
#   use PhxApp.DataCase

#   alias PhxApp.Accessories

#   describe "tags" do
#     alias PhxApp.Accessories.Tag

#     @valid_attrs %{icon_path: "some icon_path", name: "some name"}
#     @update_attrs %{icon_path: "some updated icon_path", name: "some updated name"}
#     @invalid_attrs %{icon_path: nil, name: nil}

#     def tag_fixture(attrs \\ %{}) do
#       {:ok, tag} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Accessories.create_tag()

#       tag
#     end

#     test "list_tags/0 returns all tags" do
#       tag = tag_fixture()
#       assert Accessories.list_tags() == [tag]
#     end

#     test "get_tag!/1 returns the tag with given id" do
#       tag = tag_fixture()
#       assert Accessories.get_tag!(tag.id) == tag
#     end

#     test "create_tag/1 with valid data creates a tag" do
#       assert {:ok, %Tag{} = tag} = Accessories.create_tag(@valid_attrs)
#       assert tag.icon_path == "some icon_path"
#       assert tag.name == "some name"
#     end

#     test "create_tag/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Accessories.create_tag(@invalid_attrs)
#     end

#     test "update_tag/2 with valid data updates the tag" do
#       tag = tag_fixture()
#       assert {:ok, %Tag{} = tag} = Accessories.update_tag(tag, @update_attrs)
#       assert tag.icon_path == "some updated icon_path"
#       assert tag.name == "some updated name"
#     end

#     test "update_tag/2 with invalid data returns error changeset" do
#       tag = tag_fixture()
#       assert {:error, %Ecto.Changeset{}} = Accessories.update_tag(tag, @invalid_attrs)
#       assert tag == Accessories.get_tag!(tag.id)
#     end

#     test "delete_tag/1 deletes the tag" do
#       tag = tag_fixture()
#       assert {:ok, %Tag{}} = Accessories.delete_tag(tag)
#       assert_raise Ecto.NoResultsError, fn -> Accessories.get_tag!(tag.id) end
#     end

#     test "change_tag/1 returns a tag changeset" do
#       tag = tag_fixture()
#       assert %Ecto.Changeset{} = Accessories.change_tag(tag)
#     end
#   end
#
