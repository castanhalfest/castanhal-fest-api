defmodule CastanhalFestApiWeb.CategoryView do
  use CastanhalFestApiWeb, :view
  alias CastanhalFestApiWeb.CategoryView
  use Phoenix.HTML

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      icon: image_url_unsigned(category.icon),
      name: category.name
    }
  end
end
