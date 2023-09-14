defmodule CastanhalFestApiWeb.CategoryController do
  use CastanhalFestApiWeb, :controller

  alias CastanhalFestApi.Categories
  alias CastanhalFestApi.Categories.Category

  action_fallback CastanhalFestApiWeb.FallbackController

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, category_params) do
    with {:ok, %Category{} = category} <-
           Categories.create_category(category_params, Map.get(category_params, "icon", "")) do
      conn
      |> put_status(:created)
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id} = category_params) do
    category = Categories.get_category!(id)

    with {:ok, %Category{} = category} <-
           Categories.update_category(category, category_params, Map.get(category_params, "image_url", "")) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)

    with {:ok, %Category{}} <- Categories.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
