class TechniciansController < ApplicationController
  def index
    @technicians = Technician.all
    @orders = Order.all 
    @locations = Location.all
    @times = ["6:00","7:00","8:00", "9:00","10:00","11:00","12:00","13:00","14:00","15:00"]
  end
end
