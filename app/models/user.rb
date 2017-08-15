class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :user_name, presence: true, length: { maximun: 16, minimum: 3}, format: { with: /\A[a-z0-9]+\z/i}, uniqueness: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", header_icon: "30x30>", user_icon: "128x128>"}
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png","image/gif"]
end
