defmodule StarterApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
  	create table(:users) do
  	  add :name, :string
  	  add :email, :string
  	  add :team, :string
  	  timestamps
  	end
  end

end
