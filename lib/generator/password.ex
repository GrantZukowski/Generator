defmodule Generator.Password do
  @moduledoc """
  The Password context.
  """

  import Ecto.Query, warn: false
  alias Generator.Repo

  alias Generator.Password.Generate

  @doc """
  Returns the list of passwords.

  ## Examples

      iex> list_passwords()
      [%Generate{}, ...]

  """
  def list_passwords do
    Repo.all(Generate)
  end

  @doc """
  Gets a single generate.

  Raises `Ecto.NoResultsError` if the Generate does not exist.

  ## Examples

      iex> get_generate!(123)
      %Generate{}

      iex> get_generate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_generate!(id), do: Repo.get!(Generate, id)

  @doc """
  Creates a generate.

  ## Examples

      iex> create_generate(%{field: value})
      {:ok, %Generate{}}

      iex> create_generate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_generate(attrs \\ %{}) do
    %Generate{}
    |> Generate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a generate.

  ## Examples

      iex> update_generate(generate, %{field: new_value})
      {:ok, %Generate{}}

      iex> update_generate(generate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_generate(%Generate{} = generate, attrs) do
    generate
    |> Generate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a generate.

  ## Examples

      iex> delete_generate(generate)
      {:ok, %Generate{}}

      iex> delete_generate(generate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_generate(%Generate{} = generate) do
    Repo.delete(generate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking generate changes.

  ## Examples

      iex> change_generate(generate)
      %Ecto.Changeset{data: %Generate{}}

  """
  def change_generate(%Generate{} = generate, attrs \\ %{}) do
    Generate.changeset(generate, attrs)
  end
end
