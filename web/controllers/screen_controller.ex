defmodule StarterApp.ScreenController do
  use StarterApp.Web, :controller
  alias StarterApp.Screen

  def switch_channel(conn, _params) do
    token     = _params["token"]
    user_name = _params["user_name"]
    command   = _params["command"]
    text      = _params["text"]

    # Application.get_env(:starter_app, Slack)
    #   |> IO.inspect
    IO.puts "Token is : " <> token <> ", The UserName is : " <> user_name
    validate_slack_request(conn, token, command, text)
  end

  defp validate_slack_request(conn, token, command, text)  do
    config_token = Application.get_env(:starter_app, Slack)[:token]

    if token == config_token && command == "/screen" do
      map_correct_url conn, text

    else
      IO.puts "Not a valid request, some information might be wrong."
      json conn, %{message: "Request not accepted. One of %token, %channel_name, %command not supported."}
    end
  end

  defp map_correct_url(conn, text) do
    config_shortcuts = Application.get_env(:starter_app, Slack)[:shortcut_urls]
    # IO.inspect config_shortcuts

    if Regex.match?(~r/url\(/, text) do
      process_url_link conn, text
    else 
      Enum.each(config_shortcuts, fn (sc) -> 
        if text == sc.short do
          IO.puts "The url is: "<> sc.url
          broadcast_screen_main conn, sc.url
        end
      end)
    end

    # If not keyword or url(), then:
    IO.puts "Nothing matched. No valid channels founded."
    json conn, %{message: "Channel requested is not a valid choice. :" <> text}
  end

  defp broadcast_screen_main(conn, urlString) do
    base = "http://"
    StarterApp.Endpoint.broadcast! "screen:main", "new:screen", %{url: base <> urlString}
    json conn, %{message: "Screen change request received from Slack POST."}
  end

  defp process_url_link(conn, text) do
      clean_url = String.replace_leading(text, "url(", "") 
        |> String.replace_trailing(")", "")
      IO.puts "Text received is an url. :: " <> clean_url
      broadcast_screen_main conn, clean_url
  end

end
