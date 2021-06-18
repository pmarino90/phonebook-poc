defmodule PhonebookWeb.PhoneBookLive do
  use PhonebookWeb, :live_view

  alias Phonebook.Contacts
  alias Phonebook.Contacts.Contact
  alias PhonebookWeb.ContactFormComponent
  alias PhonebookWeb.ContactListComponent

  def mount(_params, _session, socket) do
    contacts = Contacts.list_contacts()

    socket =
      socket
      |> assign(:contacts, contacts)
      |> assign(:selected_contact, Enum.at(contacts, 0))
      |> assign(:changeset, nil)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <aside class="w-1/4 h-full border flex flex-col">
      <div class="flex">
        <input type="text" placeholder="Search contact..." class="w-full p-2 border flex-1" phx-keyup="filter_contacts" phx-debounce="100" />
        <button phx-click="create_contact" class="p-2 border">+</button>
      </div>
      <div class="flex-1 overflow-scroll">
        <%= live_component ContactListComponent, contacts: @contacts, selected_contact: @selected_contact %>
      </div>
    </aside>
    <section class="w-3/4 h-full p-5">
      <%= if is_nil @changeset do %>
        <h2 class="text-xl"><%= "#{@selected_contact.first_name} #{@selected_contact.last_name}" %></h2>
        <p class="text-sm"><span class="text-gray-400">Email: </span><%= @selected_contact.email %></p>

      <% else %>
       <%= live_component ContactFormComponent, changeset: @changeset %>
      <% end %>
    </section>
    """
  end

  def handle_params(params, _url, socket) do
    socket =
      case params["contact_id"] do
        contact_id when is_binary(contact_id) ->
          assign(socket, :selected_contact, Contacts.get_contact!(contact_id))

        _ ->
          socket
      end

    {:noreply, socket}
  end

  def handle_event("filter_contacts", %{"value" => ""}, socket) do
    {:noreply, assign(socket, :contacts, Contacts.list_contacts())}
  end

  def handle_event("filter_contacts", %{"value" => value}, socket) do
    {:noreply, assign(socket, :contacts, Contacts.find_contacts(value))}
  end

  def handle_event("create_contact", _value, socket) do
    socket = socket |> assign(:changeset, Contacts.change_contact(%Contact{}))

    {:noreply, socket}
  end

  def handle_event("cancel_form", _value, socket) do
    {:noreply, assign(socket, :changeset, nil)}
  end

  def handle_event("validate", %{"contact" => params}, socket) do
    changeset =
      %Contact{}
      |> Contacts.change_contact(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"contact" => params}, socket) do
    case Contacts.create_contact(params) do
      {:ok, contact} ->
        contacts = Contacts.list_contacts()

        socket =
          socket
          |> assign(:contacts, contacts)
          |> assign(:changeset, nil)
          |> push_patch(to: Routes.phone_book_path(socket, :show, contact.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
