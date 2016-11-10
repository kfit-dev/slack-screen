defmodule StarterApp.ScreenView do
  use StarterApp.Web, :view

  def render("index.json", %{screens: screens}) do
    %{data: render_many(screens, StarterApp.ScreenView, "screen.json")}
  end

  def render("show.json", %{screen: screen}) do
    %{data: render_one(screen, StarterApp.ScreenView, "screen.json")}
  end

  def render("screen.json", %{screen: screen}) do
    %{id: screen.id,
      status: screen.status,
      count: screen.count}
  end
end
