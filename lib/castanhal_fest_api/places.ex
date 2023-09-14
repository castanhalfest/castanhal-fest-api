defmodule CastanhalFestApi.Places do
  @moduledoc """
  The Places context.
  """

  import Ecto.Query, warn: false
  alias CastanhalFestApi.Repo

  alias CastanhalFestApi.Places.Place

  def list_places(filters \\ %{}) do
    build_query(filters)
    |> Repo.all()
    |> Repo.preload(:category)
  end

  defp base_query() do
    from(places in Place)
  end

  defp build_query(filters) do
    query = base_query()

    query
    |> maybe_filter_by_category(filters[:category])
  end

  defp maybe_filter_by_category(query, nil), do: query

  defp maybe_filter_by_category(query, category_name) do
    from(places in query,
      join: category in assoc(places, :category),
      where: category.name == ^category_name
    )
  end

  defp filter_future_places(query) do
    from(places in query,
      where: fragment("?::date", places.start_date) >= ^Timex.today(),
      order_by: [asc: places.start_date]
    )
  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(id), do: Repo.get!(Place, id)

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}, file) do
    file_url = upload_images(file)

    case file_url do
      {:ok, file_url} -> do_create(file_url, attrs)
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_create(file_url, attrs) do
    place = Map.merge(attrs, %{"image_url" => file_url})

    %Place{}
    |> Place.changeset(place)
    |> Repo.insert()
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs, file) do
    case file do
      "" ->
        do_update(place, attrs)

      nil ->
        do_update(place, attrs)

      _ ->
        file_url = upload_images(file)

        case file_url do
          {:ok, file_url} -> do_update(place, attrs, file_url)
          {:error, reason} -> {:error, reason}
        end
    end
  end

  defp do_update(%Place{} = place, attrs) do
    action_update(place, attrs)
  end

  defp do_update(%Place{} = place, attrs, file_url) do
    attrs = Map.merge(attrs, %{"image_url" => file_url})
    action_update(place, attrs)
  end

  defp action_update(place, attrs) do
    place
    |> Place.changeset(attrs)
    |> Repo.update()
  end

  def upload_images(file) do
    CastanhalFestApi.Uploader.upload("images", file)
  end

  @doc """
  Deletes a place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{data: %Place{}}

  """
  def change_place(%Place{} = place, attrs \\ %{}) do
    Place.changeset(place, attrs)
  end
end
