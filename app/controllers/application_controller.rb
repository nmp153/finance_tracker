class ApplicationController < ActionController::Base
  #part of devise gem, will redirect to sign_in 
  before_action :authenticate_user!
end
