defmodule Messenger.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :username, :string
      add :text, :string
      add :url, :string

      timestamps()
    end

  end
end
