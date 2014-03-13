module SessionsHelper
	def sign_in(user)
		remember_token = SecureRandom.urlsafe_base64
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, remember_token)
		self.current_user = user
	end

	def signed_in?
		# binding.pry
		!current_user.nil?
	end
	def current_user=(user)
		@current_user = user
	end
	# def current_user
	# 	@current_user #vo dung, khong su dung dong nay :D
	# end

	# finding the currentnuser using the remember_token
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end


end
