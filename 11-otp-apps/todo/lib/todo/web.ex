defmodule ToDo.Web do
  use Plug.Router

  plug :match
  plug :dispatch


  get "/all" do
    conn = Plug.Conn.fetch_query_params(conn)
    list_name = Map.fetch!(conn.params, "list")

    entries =
      list_name
      |> ToDo.CacheSupervisor.server_process()
      |> ToDo.Server.all()


    formatted_entries =
      entries
      |> Enum.map(&"#{&1.date} #{&1.title}")
      |> Enum.join("\n")

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, formatted_entries)
  end

  # curl 'http://localhost:5454/by_date?list=bob&date=2018-12-19'
  get "/by_date" do
    conn = Plug.Conn.fetch_query_params(conn)
    list_name = Map.fetch!(conn.params, "list")
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))

    entries =
      list_name
      |> ToDo.CacheSupervisor.server_process()
      |> ToDo.Server.by_date(date)


    formatted_entries =
      entries
      |> Enum.map(&"#{&1.date} #{&1.title}")
      |> Enum.join("\n")

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, formatted_entries)
  end

  post "/add_entry" do
    conn = Plug.Conn.fetch_query_params(conn)
    list_name = Map.fetch!(conn.params, "list")
    title = Map.fetch!(conn.params, "title")
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))

    list_name
    |> ToDo.CacheSupervisor.server_process()
    |> ToDo.Server.add_entry( %{date: date, title: title} )
#         %{title: title, date: date})

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end


  match _ do
    Plug.Conn.send_resp(conn, 404, "not found")
  end

  def child_spec(_) do
    IO.puts("Starting ToDo.Web")
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      options: [port: Application.fetch_env![:todo, :http_port]],
      plug: __MODULE__
    )
  end




end