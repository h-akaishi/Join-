class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates :user_name, presence: true, length: { maximun: 30, minimum: 3}, format: { with: /\A[a-z0-9]+\z/i}, uniqueness: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", header_icon: "30x30>", user_icon: "128x128>"}
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png","image/gif"]

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        user_name: "#{auth.uid}#{auth.provider}",
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.get_email(auth),
        password: Devise.friendly_token[6, 128],
        sns_photo: auth.info.image
      )
    end
    user
  end

  private
  def self.get_email(auth)
    email = auth.info.email #ユーザメールアドレスの取得
    email = "#{auth.uid}-#{auth.provider}@example.com" if email.blank? #取得できなかった場合ダミーメールを生成
    return email
  end

end
