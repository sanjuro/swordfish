class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

	validates_presence_of :github_uid, :name, :email
	validates_uniqueness_of :github_uid, :display_name


	def self.find_or_create_by_github_uid(github_data)
		user = User.find_by(:github_uid => github_data[:uid]) 

		if user.nil?
			user = User.create(
				github_uid: github_data[:uid],
				name: github_data['extra']['raw_info']['name'],
				email: github_data['extra']['raw_info']['email'],
				display_name: github_data['extra']['raw_info']['login']
			) 
		else
			user.update_attributes!(
				github_uid: github_data[:uid],
				name: github_data['extra']['raw_info']['name'],
				email: github_data['extra']['raw_info']['email'],
				display_name: github_data['extra']['raw_info']['login']
			)
		end

		user
	end

  # def self.from_omniauth(auth)
  #     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #       user.provider = auth.provider
  #       user.uid = auth.uid
  #       user.email = auth.info.email
  #       user.password = Devise.friendly_token[0,20]
  #     end
  # end
  
end