defmodule ElixirApiWeb.UserView do
  use ElixirApiWeb, :view
  alias ElixirApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{id: user.id,
      # name: user.name,
      # lastname: user.lastname,
      username: user.username,
      email: user.email,
      #password: user.password}
      token: token}
  end
end
