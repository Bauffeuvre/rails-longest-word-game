class LoginsController < ApplicationController
  # "Create" a login, aka "log the user in"
  def create
    if user = User.authenticate(params[:username], params[:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      session[:current_user_score] = user.score

      redirect_to root_url
    end
  end
  
  def destroy
    # Remove the user id from the session
    session.delete(:current_user_id)
    # Clear the memorized current user
    @_current_user = nil
    redirect_to root_url
  end
end