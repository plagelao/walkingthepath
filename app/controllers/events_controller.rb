class EventsController < ApplicationController
  def index
    @events = Event.all(:conditions => ["date > #{DateTime.now.strftime('%Y%m%d%H%M')}"], :order => :date)
    respond_to do |format|
      format.html
      format.atom{render :action=>'index',:layout=>false}
      format.xml { render :xml => @events }
    end
  end

  def show
    redirect_to Event.find(params[:id]).link
  end
end
