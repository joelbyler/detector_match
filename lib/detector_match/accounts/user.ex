defmodule DetectorMatch.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DetectorMatch.Accounts.User

  import Comeonin.Bcrypt
  alias Ueberauth.Auth
  alias DetectorMatch.Repo

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  def authenticate(%Auth{provider: :identity} = auth) do
    Repo.get_by(__MODULE__, email: auth.uid)
    |> authorize(auth)
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end

  defp authorize(nil,_auth), do: {:error, "Invalid username or password"}
  defp authorize(user, auth) do
    checkpw(auth.credentials.other.password, user.password)
    |> resolve_authorization(user)
  end

  defp resolve_authorization(false, _user), do: {:error, "Invalid username or password"}
  defp resolve_authorization(true, user), do: {:ok, user}
end
