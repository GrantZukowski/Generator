defmodule Generator.Password.Generate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passwords" do
    field :length, :integer
    field :numbers?, :boolean, default: false
    field :result, :string
    field :special_characters?, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(generate, attrs) do
    generate
    |> cast(attrs, [:length, :numbers?, :special_characters?, :result])
    |> validate_required([:length, :numbers?, :special_characters?, :result])
  end
end
