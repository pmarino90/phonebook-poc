defmodule PhonebookWeb.ContactListComponent do
  use PhonebookWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= if Enum.empty?(@contacts) do  %>
      <span>No contacts</span>
    <% end %>
    <div class="flex flex-col">
    <%= for contact <- @contacts do %>
      <%= live_patch "#{contact.first_name} #{contact.last_name}", to: Routes.phone_book_path(@socket, :show, contact.id), class: "p-5 text-md #{if @selected_contact.id === contact.id, do: "bg-gray-100 font-semibold"}" %>
    <% end %>
    </div>
    """
  end
end
