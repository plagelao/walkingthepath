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
    flash[:notice] << @event.errors[:date].first unless @event.errors[:date].empty?
    render :new
  end

  private

  def create_event_from(event_data, transformed_event_data = {})
    Event.new event_data
  end

  def user_logged_in?
    not session[:user_id].blank?
  end

  def assert_user_is_authenticated
    redirect_to events_path unless user_logged_in?
  end
end
