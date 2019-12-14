require_relative 'config/environment'

use Rack::MethodOverride
use ProjectsController
use CharactersController
use SettingsController
use ScenesController
use SessionsController
run ApplicationController
