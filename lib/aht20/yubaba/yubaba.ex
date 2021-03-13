defmodule Yubaba.Yubaba do
  def new_name(""), do: "千"

  def new_name(name) do
    cond do
      String.contains?(name, "千") -> "千"
      String.contains?(name, "☆") -> "☆"
      true -> String.codepoints(name) |> Enum.random()
    end
  end
end
