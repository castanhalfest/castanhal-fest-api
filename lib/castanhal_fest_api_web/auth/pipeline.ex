defmodule CastanhalFestApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :castanhal_fest_api,
    module: CastanhalFestApiWeb.Auth.Guardian,
    error_handler: CastanhalFestApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
