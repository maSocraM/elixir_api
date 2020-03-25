defmodule ElixirApi.Directory.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :content, :string
    field :retweet_cnt, :integer
    field :user_id, :id
    field :parent_id, :id

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:retweet_cnt, :content])
    |> validate_required([:content])
  end
end
