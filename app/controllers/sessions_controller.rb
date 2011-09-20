#encoding: UTF-8
class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to root_url, :notice => "Você está logado!"
  	else
  		flash.now.alert = "Email ou senha inválidos"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Você saiu do sistema!"
  end
end
