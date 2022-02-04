use Mix.Config

config :todo, :database, pool_size: 3, folder: "./db"
config :todo, http_port: 5454
config :todo, todo_item_expiry: :timer.minutes(1)

import_config "#{ Mix.env()}.exs"

