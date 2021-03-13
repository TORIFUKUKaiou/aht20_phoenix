defmodule Aht20Web.YubabaLive do
  use Aht20Web, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign_yubaba(socket)}
  end

  def render(assigns) do
    ~L"""
    <h1>湯婆婆</h1>
    <%= if @submitted do %>
      <img class="rounded-full" src="https://www.torifuku-kaiou.app/img/chihiro017.jpg">
    <% else %>
      <img class="rounded-full" src="https://www.torifuku-kaiou.app/img/chihiro016.jpg">
    <% end %>
    <form phx-submit="yubaba" class="pt-6">
      <input type="text" name="name" value="<%= @name %>"
        placeholder="契約書だよ。そこに名前を書きな。"
        autofocus autocomplete="off"
        <%= if @submitted, do: "disabled" %> />

      <%= unless @submitted do %>
      <button type="submit">
        回答
      </button>
      <% end %>
    </form>

    <%= if @submitted do %>
    <button phx-click="reset">
      もう一度
    </button>
    <% end %>
    """
  end

  def handle_event("yubaba", %{"name" => name}, socket) do
    new_name = Yubaba.Yubaba.new_name(name)

    msg = """
    フン。#{name}というのかい。贅沢な名だねぇ。
    今からお前の名前は#{new_name}だ。いいかい、#{new_name}だよ。分かったら返事をするんだ、#{new_name}!
    """

    socket =
      update(socket, :name, fn _ -> name end)
      |> update(:new_name, fn _ -> new_name end)
      |> update(:submitted, &(!&1))
      |> put_flash(:info, msg)

    {:noreply, socket}
  end

  def handle_event("reset", _, socket) do
    socket = assign_yubaba(socket)
    {:noreply, socket}
  end

  defp assign_yubaba(socket) do
    assign(socket, name: "", submitted: false, new_name: "")
    |> clear_flash()
  end
end
