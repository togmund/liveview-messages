defmodule Messenger.Feed.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :text, :string
    field :url, :string, default: nil
    field :username, :string, default: "togmund"

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> validate_length(:text, min: 2, max: 150)
  end
end
