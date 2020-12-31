defmodule Aht20.Repo.Migrations.CreateValues do
  use Ecto.Migration

  def change do
    create table(:values) do
      add :temperature, :float, null: false
      add :humidity, :float, null: false
      add :time, :integer, null: false

      timestamps()
    end
  end
end
