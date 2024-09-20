FactoryBot.define do
  factory :page do
    user { nil }
    title { "MyString" }
    slug { "MyString" }
    summary { "MyText" }
    content { "MyText" }
    published { false }
  end
end
