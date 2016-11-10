defmodule StarterApp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
  	create table(:comments) do
  	  add :user_name, :string
  	  add :user_email, :string
  	  add :user_comment, :text
  	  timestamps
  	end
  end
end
