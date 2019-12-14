class Project < ActiveRecord::Base
    belongs_to :user
    has_many :characters
    has_many :settings
    has_many :scenes
end