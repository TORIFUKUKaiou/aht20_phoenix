defmodule Aht20.Measurements.Value do
  use Ecto.Schema
  import Ecto.Changeset

  schema "values" do
    field :humidity, :float
    field :temperature, :float
    field :time, :integer

    timestamps()
  end

  @doc false
  def changeset(value, attrs) do
    value
    |> cast(attrs, [:temperature, :humidity, :time])
    |> validate_required([:temperature, :humidity, :time])
  end
end
