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

	def transfer
		@account_a = Account.where(user_id: current_user.id)

		@users = User.all
		if params[:search]
    	@users = User.search(params[:search])
    	y = @users.first
    	@account_b = Account.where(user_id: y.id)

    	ActiveRecord::Base.transaction do
		@account_a.sum(:amount) - 100
		@account_a.save!
		@account_b.sum(:amount) + 100
		@account_b.save!
			
  			raise "Transaction Failed" unless @account_a.save && @account_b.save
			end
	end
	redirect_to root_path
	end
	private

	def search
		@account = Account.find[params[:id]]
	end

	def account_params
		params.require(:account).permit(:title, :amount)
	end

end
