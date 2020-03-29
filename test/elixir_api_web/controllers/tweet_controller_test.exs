defmodule ElixirApiWeb.TweetControllerTest do
  use ElixirApiWeb.ConnCase

  alias ElixirApi.Directory
  alias ElixirApi.Directory.Tweet

  @create_attrs %{
    content: "some content",
    retweet_cnt: 42
  }
  @update_attrs %{
    content: "some updated content",
    retweet_cnt: 43
  }
  @invalid_attrs %{content: nil, retweet_cnt: nil}

  def fixture(:tweet) do
    {:ok, tweet} = Directory.create_tweet(@create_attrs)
    tweet
  end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  setup %{conn: conn} do
    conn = conn
       |> put_req_header("accept", "application/json")
       |> put_req_header("authorization", "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJlbGl4aXJfYXBpIiwiZXhwIjoxNTg3NTgyMjAxLCJpYXQiOjE1ODUxNjMwMDEsImlzcyI6ImVsaXhpcl9hcGkiLCJqdGkiOiIwYmY5OGViYi0yMjBhLTRiODgtODdiMC05NzZjZGU5YjNlZmIiLCJuYmYiOjE1ODUxNjMwMDAsInN1YiI6IjEwIiwidHlwIjoiYWNjZXNzIn0.L5TEvAengdi4cB0STLeElUS1DdLZ1DbyEHV8jKy6pkdU8I1cXhgmqfB8vuL35dfnHVQUeXTxLSBcmd0sMf0kAw")
       # |> put_req_header("Bearer ", Phoenix.Token.sign(ElixirApiWeb.Router, "user", 1))
    {:ok, conn: conn}
 end


#  build_conn
#  |> bypass_through(YourApp.Router, [:browser, :browser_authenticated_session])
#  |> get("/")
#  |> Guardian.Plug.sign_in(user, token, opts)
#  |> send_resp(200, "Flush the session")
#  |> recycle

  describe "index" do
    test "lists all tweets", %{conn: conn} do
      conn = get(conn, Routes.tweet_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tweet" do
    test "renders tweet when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tweet_path(conn, :create), tweet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tweet_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some content",
               "retweet_cnt" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tweet_path(conn, :create), tweet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tweet" do
    setup [:create_tweet]

    test "renders tweet when data is valid", %{conn: conn, tweet: %Tweet{id: id} = tweet} do
      conn = put(conn, Routes.tweet_path(conn, :update, tweet), tweet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tweet_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some updated content",
               "retweet_cnt" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tweet: tweet} do
      conn = put(conn, Routes.tweet_path(conn, :update, tweet), tweet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tweet" do
    setup [:create_tweet]

    test "deletes chosen tweet", %{conn: conn, tweet: tweet} do
      conn = delete(conn, Routes.tweet_path(conn, :delete, tweet))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tweet_path(conn, :show, tweet))
      end
    end
  end

  defp create_tweet(_) do
    tweet = fixture(:tweet)
    {:ok, tweet: tweet}
  end
end
