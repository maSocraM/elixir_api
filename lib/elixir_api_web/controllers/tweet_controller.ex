defmodule ElixirApiWeb.TweetController do
  use ElixirApiWeb, :controller

  # require Logger

  alias ElixirApi.Directory
  alias ElixirApi.Directory.Tweet

  action_fallback ElixirApiWeb.FallbackController

  def index(conn, _params) do
    tweets = Directory.list_tweets()
    render(conn, "index.json", tweets: tweets)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    with {:ok, %Tweet{} = tweet} <- Directory.create_tweet(tweet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tweet_path(conn, :show, tweet))
      |> render("show.json", tweet: tweet)
    end
  end

  def show(conn, %{"id" => id}) do
    tweet = Directory.get_tweet!(id)
    render(conn, "show.json", tweet: tweet)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Directory.get_tweet!(id)

    with {:ok, %Tweet{} = tweet} <- Directory.update_tweet(tweet, tweet_params) do
      render(conn, "show.json", tweet: tweet)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Directory.get_tweet!(id)

    with {:ok, %Tweet{}} <- Directory.delete_tweet(tweet) do
      send_resp(conn, :no_content, "")
    end
  end
end
