defmodule MessengerWeb.MessageLive.Index do
  use MessengerWeb, :live_view

  alias Messenger.Feed
  alias Messenger.Feed.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :messages, fetch_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Feed.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Feed.get_message!(id)
    {:ok, _} = Feed.delete_message(message)

    {:noreply, assign(socket, :messages, fetch_messages())}
  end

  defp fetch_messages do
    Feed.list_messages()
  end
end
