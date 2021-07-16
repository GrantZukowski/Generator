defmodule Generator do
  @moduledoc """
  Generator keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @letters (Enum.to_list(?a..?z) ++ Enum.to_list(?A..?Z)) |> Enum.map(fn n -> <<n>> end)
  @numbers Enum.to_list(?0..?9) |> Enum.map(fn n -> <<n>> end)
  @special_characters Enum.to_list(?!..?.) |> Enum.map(fn n -> <<n>> end)

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
    {integer_length, ""} = Integer.parse(length)

    Stream.repeatedly(fn -> Enum.random(generate_value_list(numbers?, special_characters?)) end)
    |> Enum.take(integer_length)
    |> Enum.join()
  end

  defp generate_value_list(numbers?, special_characters?)
  defp generate_value_list("true", "true"), do: @letters ++ @numbers ++ @special_characters
  defp generate_value_list("true", "false"), do: @letters ++ @numbers
  defp generate_value_list("false", "true"), do: @letters ++ @special_characters
  defp generate_value_list("false", "false"), do: @letters
end
