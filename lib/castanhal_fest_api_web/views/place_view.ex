defmodule CastanhalFestApiWeb.PlaceView do
  use CastanhalFestApiWeb, :view
  alias CastanhalFestApiWeb.PlaceView
  use Phoenix.HTML

  def render("index.json", %{places: events}) do
    %{data: render_many(events, PlaceView, "place.json")}
  end

  def render("show.json", %{place: place}) do
    %{data: render_one(place, PlaceView, "place.json")}
  end

  def render("place.json", %{place: place}) do
    %{
      id: place.id,
      image_url: image_url_unsigned(place.image_url),
      title: place.title,
      latitude: place.latitude,
      longitude: place.longitude,
      price: place.price,
      phone: place.phone,
      address: place.address,
      category: place.category.name
    }
  end
end
