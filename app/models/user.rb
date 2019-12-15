class User < ActiveRecord::Base
    validates :username, :presence => true, :uniqueness => true
    validates :email,    :presence => true, :uniqueness => true
    has_secure_password
    has_many :projects
    has_many :settings, through: :projects
    has_many :characters, through: :projects
    has_many :scenes, through: :projects
end 