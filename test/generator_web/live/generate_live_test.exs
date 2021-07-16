defmodule GeneratorWeb.GenerateLiveTest do
  use GeneratorWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Generator.Password

  @create_attrs %{length: 42, numbers?: true, result: "some result", special_characters?: true}
  @update_attrs %{
    length: 43,
    numbers?: false,
    result: "some updated result",
    special_characters?: false
  }
  @invalid_attrs %{length: nil, numbers?: nil, result: nil, special_characters?: nil}

  defp fixture(:generate) do
    {:ok, generate} = Password.create_generate(@create_attrs)
    generate
  end

  defp create_generate(_) do
    generate = fixture(:generate)
    %{generate: generate}
  end

  describe "Index" do
    setup [:create_generate]

    test "lists all passwords", %{conn: conn, generate: generate} do
      {:ok, _index_live, html} = live(conn, Routes.generate_index_path(conn, :index))

      assert html =~ "Listing Passwords"
      assert html =~ generate.result
    end

    test "saves new generate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.generate_index_path(conn, :index))

      assert index_live |> element("a", "New Generate") |> render_click() =~
               "New Generate"

      assert_patch(index_live, Routes.generate_index_path(conn, :new))

      assert index_live
             |> form("#generate-form", generate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#generate-form", generate: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.generate_index_path(conn, :index))

      assert html =~ "Generate created successfully"
      assert html =~ "some result"
    end

    test "updates generate in listing", %{conn: conn, generate: generate} do
      {:ok, index_live, _html} = live(conn, Routes.generate_index_path(conn, :index))

      assert index_live |> element("#generate-#{generate.id} a", "Edit") |> render_click() =~
               "Edit Generate"

      assert_patch(index_live, Routes.generate_index_path(conn, :edit, generate))

      assert index_live
             |> form("#generate-form", generate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#generate-form", generate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.generate_index_path(conn, :index))

      assert html =~ "Generate updated successfully"
      assert html =~ "some updated result"
    end

    test "deletes generate in listing", %{conn: conn, generate: generate} do
      {:ok, index_live, _html} = live(conn, Routes.generate_index_path(conn, :index))

      assert index_live |> element("#generate-#{generate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#generate-#{generate.id}")
    end
  end

  describe "Show" do
    setup [:create_generate]

    test "displays generate", %{conn: conn, generate: generate} do
      {:ok, _show_live, html} = live(conn, Routes.generate_show_path(conn, :show, generate))

      assert html =~ "Show Generate"
      assert html =~ generate.result
    end

    test "updates generate within modal", %{conn: conn, generate: generate} do
      {:ok, show_live, _html} = live(conn, Routes.generate_show_path(conn, :show, generate))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Generate"

      assert_patch(show_live, Routes.generate_show_path(conn, :edit, generate))

      assert show_live
             |> form("#generate-form", generate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#generate-form", generate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.generate_show_path(conn, :show, generate))

      assert html =~ "Generate updated successfully"
      assert html =~ "some updated result"
    end
  end
end
