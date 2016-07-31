class DashboardController < ApplicationController
  def index
    render :partial => 'layouts/dashboard'
  end
end