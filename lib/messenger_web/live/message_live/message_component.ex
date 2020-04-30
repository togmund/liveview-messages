defmodule MessengerWeb.MessageLive.MessageComponent do
  use MessengerWeb, :live_component

  def render(assigns) do
    ~L"""
      <tr id="message-<%= @message.id %>">
      <td><%= @message.username %></td>
      <td><%= @message.text %></td>
      <td>
        <%=  live_redirect "https://url.com/messages/#{@message.id}", to: Routes.message_show_path(@socket, :show, @message)%>
      </td>

      <td>
      <%= @message.inserted_at %>
      </td>

      <td>
        <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @message.id, data: [confirm: "Are you sure?"] %></span>
      </td>
    </tr>
    """
  end
end
