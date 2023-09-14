defmodule CastanhalFestApi.Categories do
  @moduledoc """
  The Categories context.
  """

  import Ecto.Query, warn: false
  alias CastanhalFestApi.Repo

  alias CastanhalFestApi.Categories.Category

  def list_categories() do
    base_query() |> Repo.all()
  end

  defp base_query() do
    from(category in Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}, file) do
    file_url = upload_images(file)

    case file_url do
      {:ok, file_url} -> do_create(file_url, attrs)
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_create(file_url, attrs) do
    category = Map.merge(attrs, %{"icon" => file_url})

    %Category{}
    |> Category.changeset(category)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs, file) do
    case file do
      "" ->
        do_update(category, attrs)

      nil ->
        do_update(category, attrs)

      _ ->
        file_url = upload_images(file)

        case file_url do
          {:ok, file_url} -> do_update(category, attrs, file_url)
          {:error, reason} -> {:error, reason}
        end
    end
  end

  defp do_update(%Category{} = category, attrs) do
    action_update(category, attrs)
  end

  defp do_update(%Category{} = category, attrs, file_url) do
    attrs = Map.merge(attrs, %{"icon" => file_url})
    action_update(category, attrs)
  end

  defp action_update(category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def upload_images(file) do
    CastanhalFestApi.Uploader.upload("images", file)
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end
end
