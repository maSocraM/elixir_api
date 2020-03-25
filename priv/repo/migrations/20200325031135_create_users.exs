defmodule ElixirApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :varchar, size: 100, null: false
      add :lastname, :varchar, size: 100, null: false
      add :username, :varchar, size: 191, null: false
      add :email, :varchar, size: 191, null: false
      add :password, :string
      # add :name, :string
      # add :lastname, :string
      # add :username, :string
      # add :email, :string
      # add :password, :string

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
