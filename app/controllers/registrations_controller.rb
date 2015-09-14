class RegistrationsController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @registration_form = RegistrationForm.new
  end

  def create
    @registration_form = RegistrationForm.new(params[:registration_form])
    if @registration_form.save
      redirect_to registrations_path
    else
      render :new
    end
  end
end
