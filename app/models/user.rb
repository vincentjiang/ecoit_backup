class User < ActiveRecord::Base
	has_many :network_devices
	has_many :servers
	has_many :softwares
	has_many :systems
	
	attr_reader :password, :password_confirmation

	validates :name, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :password, confirmation: true, length: 6..20, on: :create #只在创建用户时需要对密码进行验证

	before_validation :name_downcase

	def User.authenticate(name, password)
		if user = find_by_name(name)
			if user.password_encrypt == encrypt_password(password)
				user
			end
		end
	end

	def User.encrypt_password(password)
		Digest::SHA2.hexdigest(password + "VincentJiang")
	end

	# 'password' is a virtual attribute
	def password=(password)
		@password = password
		if password.present?
			self.password_encrypt = self.class.encrypt_password(password)
		end
	end

	private
		def name_downcase
			self.name = name.downcase
		end
end
