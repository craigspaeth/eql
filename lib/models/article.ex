defmodule Models.Article do
  use Absinthe.Schema.Notation

  object :article do
    field :_id, :id
    field :title, :string
    field :body, :string
  end

  object :article_query do
    field :article, :article do
      arg :id, :id
      arg :title, :string
      resolve &find_one/2
    end
    field :articles, list_of(:article) do
      arg :title, :string
      resolve &find/2
    end
  end

  object :article_mutation do
    field :article, :article do
      arg :title, :string
      arg :body, :string
      resolve &save/2
    end
  end

  def find(args, _) do
    article = :articles |> Db.find(args)
    {:ok, article}
  end

  def find_one(args, _) do
    article = :articles |> Db.find_one(args)
    {:ok, article}
  end

  def save(args, _) do
    errors = Vex.errors args, title: [length: [min: 10]]
    if length(errors) == 0 do
      article = :articles |> Db.save(args)
      {:ok, article}
    else
      {:error, errors}
    end
  end
end
