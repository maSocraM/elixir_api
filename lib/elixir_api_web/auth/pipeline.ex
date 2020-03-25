defmodule ElixirApiWeb.Auth.Pipeline do
    use Guardian.Plug.Pipeline, otp_app: :elixir_api,
        module: ElixirApiWeb.Auth.Guardian,
        error_handler: ElixirApiWeb.Auth.ErrorHandler
        # error_handler: ElixirApiWeb.ErrorHandler

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end