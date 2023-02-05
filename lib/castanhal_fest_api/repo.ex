defmodule CastanhalFestAPI.Repo do
  use Ecto.Repo,
    otp_app: :castanhal_fest_api,
    adapter: Ecto.Adapters.Postgres
end
