class AccountsController < ApplicationController

	def index
		@users = User.all.order(created_at: :desc)
	end
end
