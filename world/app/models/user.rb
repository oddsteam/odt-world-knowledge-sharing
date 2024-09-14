class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable, :recoverable,
  devise :database_authenticatable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [ :google_oauth2 ]

  has_and_belongs_to_many :skills

  def fullname
    (self.firstname + " " + self.lastname).strip
  end

  def abbrevname
    (self.firstname[0] + self.lastname[0]).strip
  end

  def large_profile_picture
    if self.profile_picture
      self.profile_picture.gsub("=s96-c", "=s480-c")
    end
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.profile_picture = provider_data.info.image
      user.firstname = provider_data.info.first_name
      user.lastname = provider_data.info.last_name
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
