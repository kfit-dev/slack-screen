defmodule StarterApp.ScreenChannel do
	use StarterApp.Web, :channel

	def join("screen:main", message, socket) do
		Process.flag(:trap_exit, true)
		send(self, {:after_join, message})
		{:ok, socket}
	end

	def join("screen:" <> _something_else, _msg, _socket) do
		{:error, %{reason: "Invalid option."}}
	end

	def handle_info({:after_join, msg}, socket) do
		broadcast! socket, "new:msg", %{user: msg["user"]}
		push socket, "join", %{status: "connected"}
		{:noreply, socket}
	end

	def terminate(_reason, _socket) do
		:ok
	end

	# def handle_in("new:message", msg, socket) do
	# 	broadcast! socket, "new:msg", %{user: msg["user"], urlToOpen: msg["urlToOpen"]}
	# 	{:reply, {:ok, %{msg: msg["urlToOpen"]}}, assign(socket, :user, msg["user"])}
	# end

end