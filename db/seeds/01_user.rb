progressbar = ProgressBar.create(
  title: 'Creating Users',
  total: USERS_TO_CREATE
)

USERS_TO_CREATE.times do
  User.create! username: Faker::Internet.username,
              email: Faker::Internet.email,
              password: '12345678',
              password_confirmation: '12345678',
              role: 'user'
  progressbar.increment
end
