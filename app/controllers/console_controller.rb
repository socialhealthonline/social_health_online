class ConsoleController < ApplicationController
  before_action :require_authentication
  before_action :require_admin

  def index
  end

end
