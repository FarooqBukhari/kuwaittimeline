class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  validates_presence_of :name, :email, :role
  validates_uniqueness_of :name, :email
  enum role: ["Admin", "Super Admin"]

	class << self
	def current_user=(user)
		Thread.current[:current_user] = user
	end

	def current_user
		Thread.current[:current_user]
	end
	end

end
