defmodule PhxApp.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :phx_app,
    error_handler: PhxApp.Auth.ErrorHandler,
    module: PhxApp.Auth.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug PhxApp.Auth.CurrentUser
end
