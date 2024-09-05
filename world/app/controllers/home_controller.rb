class HomeController < ApplicationController
  include AuthenticationConcern
  before_action :require_login

  def index
  end
end
