defmodule CastanhalFestAPIWeb.ImageHelpers do
  @moduledoc false

  use Phoenix.HTML

  def image_url_signed(nil), do: "#"
  def image_url_signed(""), do: "#"

  def image_url_signed(path) do
    with {:ok, url} <- CastanhalFestAPI.Uploader.get_presigned_url(path), do: url
  end

  def image_url_unsigned(path), do: CastanhalFestAPI.Uploader.get_url(path)

  def image_path(path), do: image_path(CastanhalFestAPIWeb.Endpoint, path)

  def image_path(endpoint, path) do
    CastanhalFestAPIWeb.Router.Helpers.static_path(endpoint, path)
  end

  def image_url(path), do: image_url(CastanhalFestAPIWeb.Endpoint, path)

  def image_url(endpoint, path) do
    CastanhalFestAPIWeb.Endpoint.config(:app_url) <> image_path(endpoint, path)
  end

  def logo_url(nil), do: ""

  def logo_url(logo), do: image_url_unsigned(logo)
end
