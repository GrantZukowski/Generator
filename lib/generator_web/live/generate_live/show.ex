defmodule GeneratorWeb.GenerateLive.Show do
  use GeneratorWeb, :live_view

  alias Generator.Password

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:generate, Password.get_generate!(id))}
  end

  defp page_title(:show), do: "Show Generate"
  defp page_title(:edit), do: "Edit Generate"
end
