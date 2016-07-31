class DashboardController < ApplicationController
  def index
    render :partial => 'dashboard/dashboard'
  end
end