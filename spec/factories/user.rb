# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    email { Faker::Internet.email }
    password { 'Aa@123456' }
    username { 'admin' }
    role { 'admin' }
  end
end
