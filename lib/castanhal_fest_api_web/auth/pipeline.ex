defmodule CastanhalFestAPIWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :castanhal_fest_api,
    module: CastanhalFestAPIWeb.Auth.Guardian,
    error_handler: CastanhalFestAPIWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
