# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
  end
end
