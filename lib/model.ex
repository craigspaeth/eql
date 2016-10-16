defmodule Model do

  def fields_to_schema(attrs) do
    inspect attrs
    %GraphQL.Schema{
      query: %GraphQL.Type.ObjectType{
        name: "RootQueryType",
        fields: %{
          greeting: %{
            type: %GraphQL.Type.String{},
            resolve: &Model.greeting/3,
            description: "Greeting",
            args: %{
              name: %{
                type: %GraphQL.Type.String{},
                description: "The name of who you'd like to greet."
              },
            }
          }
        }
      }
    }
  end

  def greeting(_, %{name: name}, _), do: "Hello, #{name}!"
  def greeting(_, _, _), do: "Hello, world!"

  def string(opts) do
    inspect opts
  end
end