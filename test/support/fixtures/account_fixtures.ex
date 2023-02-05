defmodule CastanhalFestAPI.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CastanhalFestAPI.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_admin: true,
        name: "some name",
        password_hash: "some password_hash",
        phone: "some phone"
      })
      |> CastanhalFestAPI.Account.create_user()

    user
  end
end