defmodule Messenger.FeedTest do
  use Messenger.DataCase

  alias Messenger.Feed

  describe "messages" do
    alias Messenger.Feed.Message

    @valid_attrs %{text: "some text", url: "some url", username: "some username"}
    @update_attrs %{text: "some updated text", url: "some updated url", username: "some updated username"}
    @invalid_attrs %{text: nil, url: nil, username: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feed.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Feed.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Feed.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Feed.create_message(@valid_attrs)
      assert message.text == "some text"
      assert message.url == "some url"
      assert message.username == "some username"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Feed.update_message(message, @update_attrs)
      assert message.text == "some updated text"
      assert message.url == "some updated url"
      assert message.username == "some updated username"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Feed.update_message(message, @invalid_attrs)
      assert message == Feed.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Feed.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Feed.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Feed.change_message(message)
    end
  end
end
