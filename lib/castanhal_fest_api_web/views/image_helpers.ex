defmodule CastanhalFestApiWeb.ImageHelpers do
  @moduledoc false

  use Phoenix.HTML

  def image_url_signed(nil), do: "#"
  def image_url_signed(""), do: "#"

  def image_url_signed(path) do
    with {:ok, url} <- CastanhalFestApi.Uploader.get_presigned_url(path), do: url
  end

  def image_url_unsigned(path), do: CastanhalFestApi.Uploader.get_url(path)

  def image_path(path), do: image_path(CastanhalFestApiWeb.Endpoint, path)

  def image_path(endpoint, path) do
    CastanhalFestApiWeb.Router.Helpers.static_path(endpoint, path)
  end

  def image_url(path), do: image_url(CastanhalFestApiWeb.Endpoint, path)

  def image_url(endpoint, path) do
    CastanhalFestApiWeb.Endpoint.config(:app_url) <> image_path(endpoint, path)
  end

  def logo_url(nil), do: ""

  def logo_url(logo), do: image_url_unsigned(logo)
end
