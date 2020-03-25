defmodule ElixirApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :username, :email, :password])
    |> validate_required([:name, :lastname, :username, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end

end
