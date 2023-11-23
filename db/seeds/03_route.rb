progressbar = ProgressBar.create(
  title: 'Creating Routes',
  total: Service.count * ROUTE_ON_EACH_SERVICE
)

Service.all.each do |service|
  ROUTE_ON_EACH_SERVICE.times do
    service.routes.create!(
      verb: ['GET', 'POST', 'PUT', 'PATCH'].sample,
      version: 'v1',
      url_pattern: Faker::Internet.domain_word
    )
    progressbar.increment
  end
end
