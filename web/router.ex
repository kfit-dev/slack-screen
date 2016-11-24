defmodule StarterApp.Router do
  use StarterApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StarterApp do
    pipe_through :api

    #example post from slack:
    # curl -H "Content-Type: application/json" -X POST -d '{"token":"gIkuvaNzQIHg97ATvDxqgjtO", "team_id":"T0001", "team_domain":"example", "channel_id": "C2147483705", "channel_name": "screen-kontrol", "user_id":"U2147483697", "user_name": "adrienshen", "command": "/screen", "text": "kfit", "response_url": "https://hooks.slack.com/commands/1234/5678"}' 127.0.0.1:3666/api/screens
    post "/screens", ScreenController, :switch_channel

  end

  scope "/", StarterApp do
    pipe_through :browser # Use the default browser stack

    get "/", HomeController, :index

    # get "/screens", ScreenController, :index
    # get "/screen/settings", ScreenController, :settings
  end

  # Other scopes may use custom stacks.
  # scope "/api", StarterApp do
  #   pipe_through :api
  # end
end
