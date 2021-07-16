defmodule Generator.Repo.Migrations.CreatePasswords do
  use Ecto.Migration

  def change do
    create table(:passwords) do
      add :length, :integer
      add :numbers?, :boolean, default: false, null: false
      add :special_characters?, :boolean, default: false, null: false
      add :result, :string

      timestamps()
    end
  end
end
