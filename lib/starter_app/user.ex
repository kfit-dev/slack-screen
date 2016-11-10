defmodule StarterApp.User do
	use Ecto.Model

	schema "users" do
		field :name, :string
		field :email, :string
		timestamps
	end
end
