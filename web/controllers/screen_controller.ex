defmodule StarterApp.ScreenController do
  use StarterApp.Web, :controller

  alias StarterApp.Screen

  # def show(conn, %{"id" => id}) do
  #   # screen = Repo.get!(Screen, id)
  #   render(conn, "screens.html")
  # end

  def switch(conn, %{"token" => token, "team_id" => team_id, "team_domain" => team_domain, "channel_id" => channel_id, "channel_name" => channel_name, "user_id" => user_id, "user_name" => user_name, "command" => command, "text" => text, "response_url" => response_url}) do

    IO.puts "Got the call. The token is : " <> token <> " the user_name is : " <> user_name
    validateSlackRequest conn, token, channel_name, command, text

    # Try to broadcast the message to the screen:main channel and any clients listening to it.
    
    #StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: url}
    json(conn, %{message: "Screen change request received from user: " <> user_name})
  end

  defp validateSlackRequest(conn, token, channel_name, command, text)  do
    if token == "gIkuvaNzQIHg97ATvDxqgjtO" && channel_name == "screen-kontrol" && command == "/screen" do
      mapCorrectUrl conn, text
    else
      IO.puts "Not a valid request, some informations might be wrong."
      json(conn, %{message: "Request not accepted. One of %token, %channel_name, %command not supported."})
    end
  end

  defp mapCorrectUrl(conn, text) do
    base = "http://"
    case text do
      "kfit" ->
        #IO.puts "the requested channel is :kfit"
        StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "kfit.com"}
      "fave" ->
        #IO.puts "the requested channel is :fave web"
        StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "myfave.com"}
      "twitter" ->
        #IO.puts "the requested channel is :twiiter"
        StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "twiiter.com"}
      "ka" ->
        IO.puts "the request channel is :khan academy"
        StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "khanacademy.org"}
      _ ->
        # example: screen url(http://facebook.com)
        if Regex.match?(~r/url\(/, text) do
          IO.puts "is a url."
          StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "google.com"}
          
        else
          IO.puts "Nothing matched. No valid channels founded."
          json(conn, %{message: "Channel requested is not a valid choice. :" <> text})
        end
    end
  end

end
