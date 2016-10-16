defmodule Post do
  import Model

  def fields do
    [
      title: string(valid: [create: [presence: true]])
    ]
    # blocks: list_of(either [
    #   object(name: "ImageBlock", fields:
    #     type: string(valid: [create_update: [includes: ["image"]]),
    #     url: string(valid: [create_update: [format: :uri]])
    #   ),
    #   object(name: "TOCBlock", fields: [
    #     type: string(valid: [create_update: [includes: ["toc_block"]]),
    #     links: list_of object(fields: [
    #       name: string default: "",
    #       value: string default: ""
    #     ])
    #   ])
    # ])
  end

  # blocks: list_of(either [
  #   object(
  #     type: string valid: [create_update: [includes: ["image"]],
  #     url: string valid: [create_update: [format: :uri]]
  #   ),
  #   object(
  #     type: string valid: [all: includes: ["toc"]],
  #     links: list_of object(
  #       name: string default: "",
  #       value: string default: ""
  #     )
  #   )
  # ]),

  # field :author_id, object_id!
  #   description: "ID of author",
  #   valid: [create: [presence: true]]

  # before_create :ensure_author
  # after_update :send_first_post_email

  # def ensure_author(req) do
  #   auth_token = %{user_id: 1}
  #   |> token
  #   |> with_validation("user_id", &(&1 == 1))
  #   |> with_signer(hs256("my_secret"))
  #   |> sign
  #   |> get_compact
  #   raise "Fail" if req.query.author_id == auth_token.author_id
  # end

  # def send_first_post_email(req) do
  #   Sailthru.send "Congrats on the first post!"
  # end
end
