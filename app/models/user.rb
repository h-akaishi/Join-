class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :user_name, presence: true, length: { maximun: 16, minimum: 3}, format: { with: /\A[a-z0-9]+\z/i}
end
