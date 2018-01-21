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
alias DetectorMatch.Locations.Address

Repo.insert! %User{
  name: "Administrator",
  email: "admin@example.com",
  password: Comeonin.Bcrypt.hashpwsalt("admin")
}

Repo.insert! %Address{label: "Alem Ethiopian Village", point: %Geo.Point{coordinates: {-87.9074701, 43.0387105}, srid: 4326}}
Repo.insert! %Address{label: "Swingin' Door Exchange", point: %Geo.Point{coordinates: {-87.9082446, 43.0372896}, srid: 4326}}
Repo.insert! %Address{label: "Milwaukee Public Market", point: %Geo.Point{coordinates: {-87.9091676, 43.035253}, srid: 4326}}
Repo.insert! %Address{label: "Odd Duck", point: %Geo.Point{coordinates: {-87.9033059, 43.0020021}, srid: 4326}}

# alias DetectorMatch.Repo
# alias DetectorMatch.Accounts.User
# alias DetectorMatch.Locations.Address
# point = %Geo.Point{coordinates: {-87.9079503, 43.0384303}, srid: 4326}
# Address.within(Address, point, 400) |> Address.order_by_nearest(point) |> Address.select_with_distance(point) |> Repo.all
# Address.within(Address, point, 5000) |> Address.order_by_nearest(point) |> Address.select_with_distance(point) |> Repo.all
