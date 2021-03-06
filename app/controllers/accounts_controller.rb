class AccountsController < ApplicationController
	before_action :authenticate_user!
	before_action :search, only: [:show, :edit, :update]

	def index
		@user = Account.where(user_id: current_user.id)
		@account = @user.where(title: 'Ringgit Coin')
	end

	def show
	end

	def new
		@account = current_user.accounts.build
	end

	def create
		@account = current_user.accounts.build(account_params)
		if @account.save
			flash[:success] = 'You successfully top up'
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@account.update(account_params)
	end

	def destroy
		@account.destroy
		redirect_to root_path
	end

	def p2p
		
	end

	def exchange
		
	
	end

	def currency
		@exchange_user = Account.where(user_id: current_user.id)
		@exchange = @exchange_user.sum(:amount) * 4
		@exchange_custom = 100
		@exchange_user_custom = @exchange_custom * 4
		
		
	end


	def transfer
		@account_a = Account.find_by_user_id(current_user.id)
		@user = Account.where(user_id: current_user.id)
		@users = User.all
		if params[:search]
    	@users = User.search(params[:search])
    	y = @users.first
    	@account_b = Account.find_by_user_id(y.id)
    	
    	if @user.sum(:amount)-100 > 0
    	ActiveRecord::Base.transaction do
    	@account_a.lock!
    	@account_b.lock!
		@account_a.amount -= 100
		@account_a.save!
		@account_b.amount += 100
		@account_b.save!
		end

		flash[:warning] = 'Your account not enough money to do the transfer!'
		redirect_to root_path
	end
	end
	end

	private

	def search
		@account = Account.find[params[:id]]
	end

	def account_params
		params.require(:account).permit(:title, :amount)
	end

end
