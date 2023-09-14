defmodule CastanhalFestApi.Repo.Migrations.CreateCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :icon, :string

      timestamps()
    end
  end
end
