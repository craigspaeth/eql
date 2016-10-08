defmodule MyRouter do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  plug :match
  plug :dispatch
  forward "/graphiql", to: Absinthe.Plug.GraphiQL, schema: MyApp.Schema
  plug Absinthe.Plug, schema: MyApp.Schema

  match _ do
    send_resp(conn, 404, "oops")
  end
end

defmodule Eql do
  use Application

  def start(_type, _args) do
    {:ok, _} = Plug.Adapters.Cowboy.http MyRouter, []
  end
end
