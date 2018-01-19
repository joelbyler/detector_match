defmodule DetectorMatchWeb.SessionController do
  use DetectorMatchWeb, :controller

  alias DetectorMatch.Accounts.User
  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  def new(conn, _params) do
    render conn, "new.html", callback_url: Helpers.callback_url(conn)
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _) do
    conn
    |> authenticated(User.authenticate auth)
  end


  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> Plug.Conn.put_session(:current_user, user)
    |> redirect(to: "/")
  end

  defp authenticated(conn, {:error, error}) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/session/new")
  end
end
