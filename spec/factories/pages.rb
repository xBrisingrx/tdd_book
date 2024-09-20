FactoryBot.define do
  factory :page do
    user { create(:user) }
    title { "MyString" }
    slug { "MyString" }
    summary { "MyText" }
    content { "MyText" }
    published { false }
  end
end
