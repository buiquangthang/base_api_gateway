progressbar = ProgressBar.create(
  title: 'Creating Services',
  total: SERVICES_TO_CREATE
)

SERVICES_TO_CREATE.times do
  Service.create!(
    name: Faker::Lorem.sentence(word_count: 4),
    url: "https://#{Faker::Internet.domain_name}",
    token: Faker::Internet.password(min_length: 10, max_length: 20)
  )
  progressbar.increment
end
