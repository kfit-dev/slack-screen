defmodule StarterApp.ScreenControllerTest do
  use StarterApp.ConnCase

  alias StarterApp.Screen
  @valid_attrs %{count: 42, status: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, screen_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = get conn, screen_path(conn, :show, screen)
    assert json_response(conn, 200)["data"] == %{"id" => screen.id,
      "status" => screen.status,
      "count" => screen.count}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, screen_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, screen_path(conn, :create), screen: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Screen, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, screen_path(conn, :create), screen: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = put conn, screen_path(conn, :update, screen), screen: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Screen, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = put conn, screen_path(conn, :update, screen), screen: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = delete conn, screen_path(conn, :delete, screen)
    assert response(conn, 204)
    refute Repo.get(Screen, screen.id)
  end
end
