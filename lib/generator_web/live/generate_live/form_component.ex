defmodule GeneratorWeb.GenerateLive.FormComponent do
  use GeneratorWeb, :live_component

  alias Generator
  alias Generator.Password

  @impl true
  def update(%{generate: generate} = assigns, socket) do
    changeset = Password.change_generate(generate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"generate" => generate_params}, socket) do
    changeset =
      socket.assigns.generate
      |> Password.change_generate(generate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"generate" => generate_params}, socket) do
    generate_params = generate_params |> Generator.include_password()
    IO.inspect(generate_params)
    save_generate(socket, socket.assigns.action, generate_params)
  end

  defp save_generate(socket, :edit, generate_params) do
    case Password.update_generate(socket.assigns.generate, generate_params) do
      {:ok, _generate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Generate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_generate(socket, :new, generate_params) do
    case Password.create_generate(generate_params) do
      {:ok, _generate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Generate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
