# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  before_action do
    title :base
  end

  def new
    @sign_in_form = SignInForm.new(User.new)
  end

  def create
    @sign_in_form = SignInForm.new(User.new)

    if @sign_in_form.validate(sign_in_params)
      sign_in @sign_in_form.user
      f(:success)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end
end
