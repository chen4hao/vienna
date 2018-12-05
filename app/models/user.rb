class User < ApplicationRecord
  validates_presence_of :name, :title

  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  def admin?
    is_admin
  end
end
