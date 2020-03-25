defmodule ElixirApi.DirectoryTest do
  use ElixirApi.DataCase

  alias ElixirApi.Directory

  describe "tweets" do
    alias ElixirApi.Directory.Tweet

    @valid_attrs %{content: "some content", retweet_cnt: 42}
    @update_attrs %{content: "some updated content", retweet_cnt: 43}
    @invalid_attrs %{content: nil, retweet_cnt: nil}

    def tweet_fixture(attrs \\ %{}) do
      {:ok, tweet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_tweet()

      tweet
    end

    test "list_tweets/0 returns all tweets" do
      tweet = tweet_fixture()
      assert Directory.list_tweets() == [tweet]
    end

    test "get_tweet!/1 returns the tweet with given id" do
      tweet = tweet_fixture()
      assert Directory.get_tweet!(tweet.id) == tweet
    end

    test "create_tweet/1 with valid data creates a tweet" do
      assert {:ok, %Tweet{} = tweet} = Directory.create_tweet(@valid_attrs)
      assert tweet.content == "some content"
      assert tweet.retweet_cnt == 42
    end

    test "create_tweet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_tweet(@invalid_attrs)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{} = tweet} = Directory.update_tweet(tweet, @update_attrs)
      assert tweet.content == "some updated content"
      assert tweet.retweet_cnt == 43
    end

    test "update_tweet/2 with invalid data returns error changeset" do
      tweet = tweet_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_tweet(tweet, @invalid_attrs)
      assert tweet == Directory.get_tweet!(tweet.id)
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{}} = Directory.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = tweet_fixture()
      assert %Ecto.Changeset{} = Directory.change_tweet(tweet)
    end
  end
end
