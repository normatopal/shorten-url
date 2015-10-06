# user class
class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_paranoid

  has_many :links, :dependent => :destroy
end
