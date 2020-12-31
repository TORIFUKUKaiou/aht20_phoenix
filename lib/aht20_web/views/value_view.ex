defmodule Aht20Web.ValueView do
  use Aht20Web, :view
  alias Aht20Web.ValueView

  def render("index.json", %{values: values}) do
    %{data: render_many(values, ValueView, "value.json")}
  end

  def render("show.json", %{value: value}) do
    %{data: render_one(value, ValueView, "value.json")}
  end

  def render("value.json", %{value: value}) do
    %{id: value.id, temperature: value.temperature, humidity: value.humidity, time: value.time}
  end
end
