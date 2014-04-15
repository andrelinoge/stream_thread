class User < ActiveRecord::Base
	validates_presence_of :password, :on => :create
	

  has_many :sessions

  def authenticate(password = nil)
    return false unless password
    self.password == password ? true : false
  end
end
