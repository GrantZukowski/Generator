defmodule GeneratorWeb.GenerateLive.Index do
  use GeneratorWeb, :live_view

  alias Generator.Password
  alias Generator.Password.Generate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :passwords, list_passwords())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Generate")
    |> assign(:generate, Password.get_generate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Generate")
    |> assign(:generate, %Generate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Passwords")
    |> assign(:generate, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    generate = Password.get_generate!(id)
    {:ok, _} = Password.delete_generate(generate)

    {:noreply, assign(socket, :passwords, list_passwords())}
  end

  defp list_passwords do
    Password.list_passwords()
  end
end
