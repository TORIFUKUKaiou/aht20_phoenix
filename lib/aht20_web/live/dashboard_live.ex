defmodule Aht20Web.DashboardLive do
  use Aht20Web, :live_view

  alias Aht20.Values

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

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

      <p><a href="https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347">Article</a></p>
    </div>
    """
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    {temperature, humidity} = Values.get()

    assign(socket,
      temperature: temperature,
      humidity: humidity
    )
  end
end
