defmodule CastanhalFestApiWeb.EventView do
  use CastanhalFestApiWeb, :view
  alias CastanhalFestApiWeb.EventView
  use Phoenix.HTML

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      image_url: image_url_unsigned(event.image_url),
      name: event.name,
      description: event.description,
      start_date: event.start_date,
      category: event.category
    }
  end
end
