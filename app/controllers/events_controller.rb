#encoding: utf-8
class EventsController < ApplicationController

  before_filter :assert_user_is_authenticated, :only => [:new, :create]

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
    @event = create_event_from params[:event]
    return redirect_to events_path if @event.save
    flash[:notice] = []
    flash[:notice] << @event.errors[:title].first unless @event.errors[:title].empty?
    flash[:notice] << @event.errors[:link].first unless @event.errors[:link].empty?
    redirect_to new_event_path
  end

  private

  def create_event_from(event_data, transformed_event_data = {})
    transformed_event_data[:title] = event_data['title']
    transformed_event_data[:link] = event_data['link']
    transformed_event_data[:date] = to_event_date event_data
    Event.new transformed_event_data
  end

  def to_event_date(datetime_from_select, date = '')
    5.times do |index|
      number = datetime_from_select["date(#{index+1}i)"]
      number = '0'+number if number.length == 1
      date += number
    end
    date.to_i
  end

  def user_logged_in?
    not session[:user_id].blank?
  end

  def assert_user_is_authenticated
    redirect_to events_path unless user_logged_in?
  end
end
