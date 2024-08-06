class TechniciansController < ApplicationController
  def index
    @technicians = Technician.all
  end
end
