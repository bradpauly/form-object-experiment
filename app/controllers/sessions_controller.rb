class SessionsController < ApplicationController
  def new
    @login_form = LoginForm.new
  end

  def create
    @login_form = LoginForm.new(params[:login_form])
    if user = @login_form.authenticate
      # Session.create_for_user(user)
      # start_session_for_user(user)
      redirect_to registrations_path
    else
      flash.now[:notice] = "Sorry, that email & password combination didn't work."
      render :new
    end
  end
end
