defmodule Db do

  def init do
    db = Mongo.connect! |> Mongo.db("eql")
    Agent.start_link fn -> [db] end, name: __MODULE__
  end

  def db do
    Agent.get(__MODULE__, fn list -> List.first list end)
  end

  def find_one(col, query) do
    db
    |> Mongo.Db.collection(Atom.to_string col)
    |> Mongo.Collection.find(query)
    |> Enum.to_list
    |> List.first
  end

  def find(col, query) do
    db
    |> Mongo.Db.collection(Atom.to_string col)
    |> Mongo.Collection.find(query)
    |> Enum.to_list
  end

  def save(col, data) do
    if data[:_id] && length(find_one col, %{_id: data[:_id]}) > 0 do
      db
      |> Mongo.Db.collection(Atom.to_string col)
      |> Mongo.Collection.update(%{_id: data[:_id]}, data)
      find_one col, %{_id: data[:_id]}
    else
      collection = db |> Mongo.Db.collection(Atom.to_string col)
      Mongo.Collection.insert_one data, collection
      find_one col, %{}
    end
  end
end
