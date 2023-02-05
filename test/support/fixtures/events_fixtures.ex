defmodule CastanhalFestAPI.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CastanhalFestAPI.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name"
      })
      |> CastanhalFestAPI.Events.create_event()

    event
  end
end
