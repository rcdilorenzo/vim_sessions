defmodule Factory.Post do
  use Factory, model: Post

  factory :default do
    field :title,       String.capitalize(Faker.Lorem.word <> " " <> Faker.Lorem.word)
    field :description, Faker.Lorem.sentence
    field :content,     Faker.Lorem.sentences(20) |> Enum.join "\n"
    field :inserted_at, VimSessions.DateTime.local
    field :updated_at,  VimSessions.DateTime.local
  end

end
