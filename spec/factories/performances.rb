# frozen_string_literal: true

FactoryBot.define do
  factory :performance do
    title { Faker::Lorem.word }
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1.day }
  end
end
