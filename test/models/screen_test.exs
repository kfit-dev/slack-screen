defmodule StarterApp.ScreenTest do
  use StarterApp.ModelCase

  alias StarterApp.Screen

  @valid_attrs %{count: 42, status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Screen.changeset(%Screen{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Screen.changeset(%Screen{}, @invalid_attrs)
    refute changeset.valid?
  end
end
