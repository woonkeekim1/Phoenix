defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller

  def new(conn, _param) do
    case conn.assigns.current_user do
      %Rumbl.User{} = user ->
        conn
        |> redirect(to: user_path(conn, :index))
      _ ->
        render conn, "new.html"
    end
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "welcome back!")
        |> redirect(to: user_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _param) do
    conn
    |> Rumbl.Auth.logout
    |> redirect(to: page_path(conn, :index))
  end
end
