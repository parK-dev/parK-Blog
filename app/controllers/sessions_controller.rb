# frozen_string_literal: true

before_action :set_user_session, only: %i[create]

class SessionsController < ApplicationController
  def new; end

  def create
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "You're in!"
      redirect_to user
    else
      flash.now[:alert] = 'Wrong credentials.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end
end

private

def set_session_user
  user = User.find_by(email: params[:session][:email].downcase)
end
