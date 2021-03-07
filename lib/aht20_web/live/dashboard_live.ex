defmodule Aht20Web.DashboardLive do
  use Aht20Web, :live_view

  alias Aht20.Values

  @default_locale "ja"
  @default_timezone "Asia/Tokyo"
  @default_timezone_offset 9

  def mount(_params, _session, socket) do
    if connected?(socket), do: Aht20.Measurements.subscribe()

    socket =
      socket
      |> assign(locale: fetch_locale(socket))
      |> assign(timezone: fetch_timezone(socket))
      |> assign(timezone_offset: fetch_timezone_offset(socket))

    socket = assign_stats(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Dashboard</h1>
    <div id="dashboard">
      <div class="stats">
        <div class="stat">
          <span class="value">
            <%= @temperature %>`C
          </span>
          <span class="name">
            Temperature
          </span>
        </div>
        <div class="stat">
          <span class="value">
            <%= @humidity %>%
          </span>
          <span class="name">
            Humidity
          </span>
        </div>
      </div>

      <%= @time %>
      <p><a href="https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347">Article</a></p>
    </div>
    """
  end

  def handle_info({:value_created, value}, socket) do
    socket =
      update(
        socket,
        :temperature,
        fn _ -> value.temperature end
      )
      |> update(
        :humidity,
        fn _ -> value.humidity end
      )
      |> update(
        :time,
        fn _ -> Timex.from_unix(value.time) |> Aht20.Cldr.format_time() end
      )

    {:noreply, socket}
  end

  defp assign_stats(socket) do
    {temperature, humidity, time} = Values.get()

    assign(socket,
      temperature: temperature,
      humidity: humidity,
      time: Timex.from_unix(time) |> Aht20.Cldr.format_time()
    )
  end

  defp fetch_locale(socket) do
    if connected?(socket) do
      get_connect_params(socket)["locale"]
    else
      @default_locale
    end
  end

  defp fetch_timezone(socket) do
    if connected?(socket) do
      get_connect_params(socket)["timezone"]
    else
      @default_timezone
    end
  end

  defp fetch_timezone_offset(socket) do
    if connected?(socket) do
      get_connect_params(socket)["timezone_offset"]
    else
      @default_timezone_offset
    end
  end
end
