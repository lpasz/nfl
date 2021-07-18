defmodule NflWeb.Live.Components.TouchdownIcon do
  use NflWeb, :live_component

  def render(assigns) do
    ~L"""
      <%= if @is_touchdown do %>
      <div phx-click="touchdown" class="popup" phx-value-show="<%= @show_info %>" phx-target="<%= @myself %>">
      ℹ️ <%= @longest_rush %> T
        <span class="popuptext <%= if @show_info == true, do: "show" %>">
             T is for when a touchdown happens during the longest rush
        </span>
      </div>
      <% else %>
      <span><%= @longest_rush %></span>
      <% end %>
    """
  end

  def handle_event("touchdown", %{"show" => show} = a, socket) do
    IO.inspect(a)
    switched_show = not to_boolean(show)

    {:noreply, assign(socket, show_info: switched_show)}
  end

  defp to_boolean(b) when is_boolean(b), do: b

  defp to_boolean(b) when is_binary(b) do
    case String.downcase(b) do
      "true" -> true
      "false" -> false
    end
  end
end
