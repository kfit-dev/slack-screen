defmodule StarterApp.Screen do
  use StarterApp.Web, :model

  schema "screens" do
    field :status, :string
    field :count, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  # def changeset(struct, params \\ %{}) do
  #   struct
  #   |> cast(params, [:status, :count])
  #   |> validate_required([:status, :count])
  # end
end
