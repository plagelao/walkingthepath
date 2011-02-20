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

  def new
    @event = Event.new
  end
  def create
    event_data = params[:event]
    transformed_event_data = {}
    transformed_event_data[:title] = event_data['title']
    transformed_event_data[:link] = event_data['link']
    transformed_event_data[:date] = to_event_date event_data
    event = Event.new transformed_event_data
    event.save
    redirect_to events_path
  end

  private

  def to_event_date(datetime_from_select)
    date = ''
    5.times do |index|
      number = datetime_from_select["date(#{index+1}i)"]
      number = '0'+number if number.length == 1
      date += number
    end
    date.to_i
  end
end
