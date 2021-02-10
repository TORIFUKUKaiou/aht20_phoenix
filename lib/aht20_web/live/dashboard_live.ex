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
            <%= @temperature %>℃
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
    </div>

    <p><a href="https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347">AHT20で温度湿度を取得して全世界に惜しげもなく公開する(Elixir/Nerves/Phoenix)</a></p>
    <p><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3">#大晦日ハッカソン</a></p>
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
