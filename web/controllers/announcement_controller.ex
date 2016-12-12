defmodule StarterApp.AnnouncementController do
	use StarterApp.Web, :controller

	def index(conn, _params) do
		
		contents = File.read!("announcements.txt")  
    list = String.split(contents, ",")    

    [current | previous] = Enum.reverse(list)
    [last_one | last_two ] = previous
    
    announcements = %{
      :last_two => last_two,
      :last_one => last_one,
      :current => current
      } |> IO.inspect

    # IO.inspect announcements
    conn
    |> assign(:announcements, announcements)
		|> render("index.html")
	end
  
  def write_announcement(conn, text_string) do
    
    #write to announcement file and render announcements page.
    contents = File.read!("announcements.txt")
    |> String.split(",") 
    |> List.delete_at(0) |> List.insert_at(-1, text_string)
    |> Enum.join(",")
    |> IO.puts
    
    # File.write!("announcements.txt", text_string, :binary)
    # not sure how to do this file write...
    File.open("announcements.txt", [:read, :write, :utf8], fn f ->
      IO.write(f, contents)
    end)
        
    # file = File.open("announcements.txt", [:write])
    # File.write!("announcements.txt", contents)
    # File.close file
    
    # IO.puts "Reading new file"
    # nc = File.read!("announcements.txt")
    # |> IO.puts
    
  end

end