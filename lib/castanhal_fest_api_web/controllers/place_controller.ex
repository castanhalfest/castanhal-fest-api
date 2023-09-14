defmodule CastanhalFestApiWeb.PlaceController do
  use CastanhalFestApiWeb, :controller

  alias CastanhalFestApi.Places
  alias CastanhalFestApi.Places.Place

  action_fallback CastanhalFestApiWeb.FallbackController

  def index(conn, %{"category" => category} = _params) do
    places = Places.list_places(%{category: category})
    render(conn, "index.json", places: places)
  end

  def index(conn, _params) do
    places = Places.list_places()
    render(conn, "index.json", places: places)
  end

  def create(conn, place_params) do
    with {:ok, %Place{} = place} <-
           Places.create_place(place_params, Map.get(place_params, "image_url", "")) do
      %{"content_push" => content, "name" => subject} = place_params
      CastanhalFestApi.PushNotifications.send(subject, content, place.id)

      conn
      |> put_status(:created)
      |> render("show.json", place: place)
    end
  end

  def show(conn, %{"id" => id}) do
    place = Places.get_place!(id)
    render(conn, "show.json", place: place)
  end

  def update(conn, %{"id" => id} = place_params) do
    place = Places.get_place!(id)

    with {:ok, %Place{} = place} <-
           Places.update_place(place, place_params, Map.get(place_params, "image_url", "")) do
      render(conn, "show.json", place: place)
    end
  end

  def delete(conn, %{"id" => id}) do
    place = Places.get_place!(id)

    with {:ok, %Place{}} <- Places.delete_place(place) do
      send_resp(conn, :no_content, "")
    end
  end
end
