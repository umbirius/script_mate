class User < ActiveRecord::Base
    has_secure_password
    has_many :projects
    has_many :settings, through: :projects
    has_many :characters, through: :projects
    has_many :scenes, through: :projects
end 