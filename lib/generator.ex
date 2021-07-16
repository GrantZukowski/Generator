defmodule Generator do
  @moduledoc """
  Generator keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def include_password(params) do
    %{
      "length" => params["length"],
      "numbers?" => params["numbers?"],
      "result" =>
        generate_password(params["length"], params["numbers?"], params["special_characters?"]),
      "special_characters?" => params["special_characters?"]
    }
  end

  defp generate_password(length, numbers?, special_characters?) do
    "changeit"
  end
end
