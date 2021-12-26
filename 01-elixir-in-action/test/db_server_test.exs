defmodule DbServer.Tests do
  use ExUnit.Case
  
  doctest DbServer
  
  test "Test that we can start the DbServer using start/0" do
    server_pid = DbServer.start()
    assert server_pid != nil
  end
  
  test "Test that we can query the DbServer" do
    server_pid = DbServer.start()
    DbServer.Client.query_async(server_pid, "query 1")
    DbServer.Client.get_result()
  end
  
  def request_response(pid, query) do
    DbServer.Client.query_async(pid, query)
    result = DbServer.Client.get_result()
    IO.inspect(result)
  end
  
  test "Test that we can spawn multiple queries concurrently" do
    server_pid = DbServer.start()
    Enum.map(1..2, &DbServer.Tests.request_response(server_pid, "Query #{&1}") )
  end
  
  
end