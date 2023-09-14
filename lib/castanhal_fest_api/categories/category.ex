defmodule CastanhalFestApi.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :icon, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
    :name,
    :icon])
    |> validate_required([:name, :icon])
  end
end
