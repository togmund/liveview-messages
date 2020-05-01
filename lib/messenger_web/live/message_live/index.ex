defmodule MessengerWeb.MessageLive.Index do
  use MessengerWeb, :live_view

  alias Messenger.Feed
  alias Messenger.Feed.Message

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Feed.subscribe()
    end

    {:ok, assign(socket, :messages, fetch_messages()), temporary_assigns: [posts: []]}
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

  @impl true
  def handle_info({:message_created, message}, socket) do
    {:noreply, update(socket, :messages, fn messages -> [message | messages] end)}
  end

  def handle_info({:message_updated, message}, socket) do
    {:noreply, update(socket, :messages, fn messages -> [message | messages] end)}
  end

  def handle_info({:message_deleted, _message}, socket) do
    {:noreply, update(socket, :messages, fetch_messages())}
  end

  defp fetch_messages do
    Feed.list_messages_ordered()
  end
end
