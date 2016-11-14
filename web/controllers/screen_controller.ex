defmodule StarterApp.ScreenController do
  use StarterApp.Web, :controller

  alias StarterApp.Screen

  # def show(conn, %{"id" => id}) do
  #   # screen = Repo.get!(Screen, id)
  #   render(conn, "screens.html")
  # end

  def switchChannel(conn, %{"token" => token, "team_id" => team_id, "team_domain" => team_domain, "channel_id" => channel_id, "channel_name" => channel_name, "user_id" => user_id, "user_name" => user_name, "command" => command, "text" => text, "response_url" => response_url}) do

    IO.puts "Got the call. The token is : " <> token <> " the user_name is : " <> user_name
    validateSlackRequest conn, token, channel_name, command, text
  end

  defp validateSlackRequest(conn, token, channel_name, command, text)  do
    if token == "gIkuvaNzQIHg97ATvDxqgjtO" && channel_name == "screen-kontrol" && command == "/screen" do
      mapCorrectUrl conn, text
    else
      IO.puts "Not a valid request, some informations might be wrong."
      json conn, %{message: "Request not accepted. One of %token, %channel_name, %command not supported."}
    end
  end

  defp extractUrlFromString() do
    
  end

  defp broadcastScreenMain(conn, urlString) do
    base = "http://"
    StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> urlString}
    json conn, %{message: "Screen change request received from Slack POST."}
  end

  defp mapCorrectUrl(conn, text) do
    case text do
      "kfit" ->
        # StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> "kfit.com"}
        broadcastScreenMain conn, "kfit.com"
      "fave" ->
        broadcastScreenMain conn, "myfave.com"
      "twitter" ->
        broadcastScreenMain conn, "twitter.com"
      "ka" ->
        broadcastScreenMain conn, "khanacademy.org"
      _ ->
        # example: screen url(http://google.com)
        if Regex.match?(~r/url\(/, text) do
          cleanUrl = String.replace_leading(text, "url(", "") |> String.replace_trailing(")", "")
          IO.puts "Text received is an url. :: " <> cleanUrl
          broadcastScreenMain conn, cleanUrl
        else
          IO.puts "Nothing matched. No valid channels founded."
          json conn, %{message: "Channel requested is not a valid choice. :" <> text}
        end
    end
  end

end
