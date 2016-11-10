defmodule StarterApp.Repo do
  use Ecto.Repo, otp_app: :starter_app, adapter: Sqlite.Ecto
end
