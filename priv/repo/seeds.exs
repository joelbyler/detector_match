# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DetectorMatch.Repo.insert!(%DetectorMatch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias DetectorMatch.Repo
alias DetectorMatch.Accounts.User

Repo.insert! %User{
  name: "Administrator",
  email: "admin@example.com",
  password: Comeonin.Bcrypt.hashpwsalt("admin")
}
