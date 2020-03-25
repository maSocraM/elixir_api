defmodule ElixirApi.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :retweet_cnt, :integer
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :parent_id, references(:tweets, on_delete: :nothing)

      timestamps()
    end

    create index(:tweets, [:user_id])
    create index(:tweets, [:parent_id])
  end
end
