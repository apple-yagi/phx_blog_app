defmodule PhxApp.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :phx_app,
    error_handler: PhxApp.Accounts.ErrorHandler,
    module: PhxApp.Accounts.Guardian

  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end
