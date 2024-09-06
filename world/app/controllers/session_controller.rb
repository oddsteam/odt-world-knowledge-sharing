class SessionController < ApplicationController
  def login
  end

  def create
    @member = Member.find_by(login: params[:login])

    if !!@member && @member.authenticate(params[:password])
      session[:user_id] = @member.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
