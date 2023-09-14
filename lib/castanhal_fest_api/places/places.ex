defmodule CastanhalFestApi.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :latitude, :string
    field :longitude, :string
    field :icon, :string
    field :title, :string
    field :price, :integer
    field :phone, :string
    field :address, :string
    field :image_url, :string

    belongs_to :category, CastanhalFestApi.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:latitude,
    :longitude,
    :icon,
    :title,
    :price,
    :phone,
    :address,
    :image_url,
    :category_id])
    |> validate_required([:image_url, :title, :address, :category_id, :latitude, :longitude])
  end
end
