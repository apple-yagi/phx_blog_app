defmodule PhxAppWeb.Api.Error.ErrorView do
  use PhxAppWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(_template, _assigns) do
    %{
      statusCode: 404,
      message: "Not found😳"
    }
  end

  def template_internal_server_error(_template, _assigns) do
    %{
      statusCode: 500,
      message: "Internal server error😇"
    }
  end
end
