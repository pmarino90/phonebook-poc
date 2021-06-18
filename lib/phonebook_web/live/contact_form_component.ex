defmodule PhonebookWeb.ContactFormComponent do
  use PhonebookWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= form_for @changeset, "#", [phx_change: :validate, phx_submit: :save, phx_debounce: 300, class: "flex flex-col"], fn f -> %>
      <div class="flex flex-col space-y-1">
        <%= label f, :first_name %>
        <%= text_input f, :first_name, require: true, class: "border shadow px-4 py-2" %>
        <%= error_tag f, :first_name %>
      </div>

     <div class="flex flex-col space-y-1">
        <%= label f, :last_name %>
        <%= text_input f, :last_name, require: true, class: "border shadow  px-4 py-2" %>
        <%= error_tag f, :last_name %>
      </div>

      <div class="flex flex-col space-y-1">
        <%= label f, :email %>
        <%= text_input f, :email, require: true, class: "border shadow px-4 py-2" %>
        <%= error_tag f, :email %>
      </div>

      <div class="mt-10 flex justify-end space-x-2">
      <button phx-click="cancel_form" type="button" class="rounded border border-indigo-400 py-2 px-4">Cancel</button>
      <%= submit "Create contact", class: "rounded border bg-indigo-600 text-white py-2 px-4" %>
      </div>
    <% end %>
    """
  end
end
