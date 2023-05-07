# frozen_string_literal: true

FactoryBot.define do
  factory :service, class: 'Service' do
    name { Faker::Name.name }
    url { Faker::Internet.url }
    token { SecureRandom.hex }
  end
end
