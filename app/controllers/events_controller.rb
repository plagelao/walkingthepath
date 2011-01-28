class EventsController < ApplicationController
  def index
    @events = Event.in_the_future
    respond_to do |format|
      format.html
      format.atom{render :action => 'index', :layout => false}
    end
  end

  def show
    redirect_to Event.find(params[:id]).link
  end
end
