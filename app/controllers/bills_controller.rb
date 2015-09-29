class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = current_user.bills.new(params[:bill])
    
  end
end
