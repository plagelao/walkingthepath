class EventsController < ApplicationController
  def index
    @events = Event.find(:all, :conditions => ["date > #{DateTime.now.strftime('%Y%m%d%H%M')}"], :order => 'date')
    respond_to do |format|
      format.html
      format.xml { render :xml => @events }
    end
  end
end
