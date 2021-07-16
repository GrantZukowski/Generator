defmodule Generator.PasswordTest do
  use Generator.DataCase

  alias Generator.Password

  describe "passwords" do
    alias Generator.Password.Generate

    @valid_attrs %{length: 42, numbers?: true, result: "some result", special_characters?: true}
    @update_attrs %{
      length: 43,
      numbers?: false,
      result: "some updated result",
      special_characters?: false
    }
    @invalid_attrs %{length: nil, numbers?: nil, result: nil, special_characters?: nil}

    def generate_fixture(attrs \\ %{}) do
      {:ok, generate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Password.create_generate()

      generate
    end

    test "list_passwords/0 returns all passwords" do
      generate = generate_fixture()
      assert Password.list_passwords() == [generate]
    end

    test "get_generate!/1 returns the generate with given id" do
      generate = generate_fixture()
      assert Password.get_generate!(generate.id) == generate
    end

    test "create_generate/1 with valid data creates a generate" do
      assert {:ok, %Generate{} = generate} = Password.create_generate(@valid_attrs)
      assert generate.length == 42
      assert generate.numbers? == true
      assert generate.result == "some result"
      assert generate.special_characters? == true
    end

    test "create_generate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Password.create_generate(@invalid_attrs)
    end

    test "update_generate/2 with valid data updates the generate" do
      generate = generate_fixture()
      assert {:ok, %Generate{} = generate} = Password.update_generate(generate, @update_attrs)
      assert generate.length == 43
      assert generate.numbers? == false
      assert generate.result == "some updated result"
      assert generate.special_characters? == false
    end

    test "update_generate/2 with invalid data returns error changeset" do
      generate = generate_fixture()
      assert {:error, %Ecto.Changeset{}} = Password.update_generate(generate, @invalid_attrs)
      assert generate == Password.get_generate!(generate.id)
    end

    test "delete_generate/1 deletes the generate" do
      generate = generate_fixture()
      assert {:ok, %Generate{}} = Password.delete_generate(generate)
      assert_raise Ecto.NoResultsError, fn -> Password.get_generate!(generate.id) end
    end

    test "change_generate/1 returns a generate changeset" do
      generate = generate_fixture()
      assert %Ecto.Changeset{} = Password.change_generate(generate)
    end
  end
end
