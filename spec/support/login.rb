module Login

	def log_in(fabricator=nil)
		user = create(fabricator || :registered_user)
		log_in_user(user)
		user
	end

	def log_in_user(user)
		session[:id] = user.id
	end

end