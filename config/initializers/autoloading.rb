# The namespace has to exist.
#
# In this example we define the module on the spot. Could also be created
# elsewhere and its definition loaded here with an ordinary `require`. In
# any case, `push_dir` expects a class or module object.
module Operations; end
module Contracts; end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/operations", namespace: Operations)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/contracts", namespace: Contracts)

app_operations_dir = "#{Rails.root}/app/operations" # has to be a string
ActiveSupport::Dependencies.autoload_paths.delete(app_operations_dir)
Rails.application.config.watchable_dirs[app_operations_dir] = [:rb]

app_contracts_dir = "#{Rails.root}/app/contracts" # has to be a string
ActiveSupport::Dependencies.autoload_paths.delete(app_contracts_dir)
Rails.application.config.watchable_dirs[app_contracts_dir] = [:rb]
