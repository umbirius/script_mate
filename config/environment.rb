require 'bundler/setup'
Bundler.require

require_relative '../app/models/user.rb'
require_relative '../app/models/project.rb'
require_relative '../app/models/character.rb'
require_relative '../app/models/setting.rb'
require_relative '../app/models/scene.rb'
require_relative '../app/controllers/application_controller.rb'
require_relative '../app/controllers/projects_controller.rb'
require_relative '../app/controllers/characters_controller.rb'
require_relative '../app/controllers/settings_controller.rb'
require_relative '../app/controllers/scenes_controller.rb'
require_relative '../app/controllers/sessions_controller.rb'