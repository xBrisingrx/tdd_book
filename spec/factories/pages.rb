FactoryBot.define do
  factory :page do
    user { association :user }
    sequence(:title) { |n| "Page Title #{n}" }
    sequence(:slug) { |n| "page-title-#{n}" }
    sequence(:summary) { |n| "<p>Page summary goes here #{n}</p>" }
    sequence(:content) { |n| "<p>Page content goes here #{n}</p>" }
    created_at { Time.zone.now }
    published { false }
  end

  trait :published do
    published { true }
  end
end
