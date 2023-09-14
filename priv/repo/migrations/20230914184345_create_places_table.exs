defmodule CastanhalFestApi.Repo.Migrations.CreatePlacesTable do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :latitude, :string
      add :longitude, :string
      add :icon, :string
      add :title, :string
      add :price, :integer
      add :phone, :string
      add :address, :string
      add :image_url, :string

      add :category_id, references(:categories, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
