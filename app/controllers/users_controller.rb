class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    @buyers = Buyer.all
    @sales = Sale.all
    @messages = Message.all



    @buyers.each do |buyer|
      buyer.update_attributes(:user_id => 1)
    end
    @sales.each do |buyer|
      buyer.update_attributes(:user_id => 1)
    end
    @messages.each do |buyer|
      buyer.update_attributes(:user_id => 1)
    end

    
  	if @user.save
  		redirect_to root_url, :notice => "Cadastro criado!"
  	else
  		render "new"
  	end
  end

end
