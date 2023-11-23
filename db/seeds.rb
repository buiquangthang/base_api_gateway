USERS_TO_CREATE = 5
SERVICES_TO_CREATE = 5
ROUTE_ON_EACH_SERVICE = 4

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |file|
  require file
end
