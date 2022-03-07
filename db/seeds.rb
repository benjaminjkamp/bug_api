Location.create!([
  {name: "Abel Dungeon", zone: 1}
])
App.create!([
  {name: "Age of Chaos"}
])
User.create!([
  {char_name: "aocAdmin", email: "admin@aoclegends.com", password_digest: "$2a$12$ft5lZoAdrkUmNTMFYs5/w.jdJVgTIyJbyujUuN9bW1lk6aZgKc5rq", admin: true},
  {char_name: "Gramail", email: "gramail@aoclegends.com", password_digest: "$2a$12$wYhuhMyJgXHaxgWsG5nIeO2WbZ40Rs2qIxrXJYjcMQwqdQWG4hEMm", admin: true}
])

