defmodule Aht20.Values do
  def get do
    Aht20.Measurements.last()
    |> handle_get()
  end

  defp handle_get(nil), do: {0, 0}

  defp handle_get(%Aht20.Measurements.Value{temperature: temperature, humidity: humidity}) do
    {temperature, humidity}
  end
end
