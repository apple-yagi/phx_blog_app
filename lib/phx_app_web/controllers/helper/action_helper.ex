defmodule PhxAppWeb.Helper.ActionHelper do
  def get_apply_args(conn) do
    case Map.has_key?(conn.assigns, :current_user) do
      true ->
        [
          conn,
          conn.params,
          elem(conn.assigns.current_user, 1)
        ]

      false ->
        [conn, conn.params]
    end
  end
end
