defmodule ElixirApiWeb.TweetView do
  use ElixirApiWeb, :view
  alias ElixirApiWeb.TweetView

  def render("index.json", %{tweets: tweets}) do
    %{data: render_many(tweets, TweetView, "tweet.json")}
  end

  def render("show.json", %{tweet: tweet}) do
    %{data: render_one(tweet, TweetView, "tweet.json")}
  end

  def render("tweet.json", %{tweet: tweet}) do
    %{id: tweet.id,
      retweet_cnt: tweet.retweet_cnt,
      content: tweet.content}
  end
end
