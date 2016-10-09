defmodule Schema do
  use Absinthe.Schema
  import_types Models.Article

  query do
    import_fields :article_query
  end

  mutation do
    import_fields :article_mutation
  end
end

defmodule Router do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  plug :match
  plug :dispatch
  forward "/graphiql", to: Absinthe.Plug.GraphiQL, schema: Schema
  plug Absinthe.Plug, schema: Schema
end

defmodule App do
  use Application

  def start(_type, _args) do
    Db.init()
    Plug.Adapters.Cowboy.http Router, []
  end
end
