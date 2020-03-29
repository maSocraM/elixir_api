# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirApi.Repo.insert!(%ElixirApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ElixirApi.Repo
alias ElixirApi.Accounts.User
alias ElixirApi.Directory.Tweet

Repo.insert! %User{"name": "User_1", "lastname": "Test_1", "username": "username_1", "email": "username_1@byopmail.com", "password": "password"}}

Repo.insert! %Tweet{content: "Test content 1", user_id: 1}
Repo.insert! %Tweet{content: "Test content 2", user_id: 1}
Repo.insert! %Tweet{content: "Test content 3", user_id: 1}