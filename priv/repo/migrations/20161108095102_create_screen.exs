defmodule StarterApp.Repo.Migrations.CreateScreen do
  use Ecto.Migration

  def change do
    create table(:screens) do
      add :status, :string
      add :count, :integer

      timestamps()
    end

  end
end
