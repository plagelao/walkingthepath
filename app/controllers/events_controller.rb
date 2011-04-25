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
    @event.build_slot
  end

  def create
    invalid_event = announcer.announce_event(params[:event], params[:slot])
    return redirect_to events_path unless invalid_event
    @event = invalid_event
    render :new
  end

  private

  def user_logged_in?
    not session[:user_id].blank?
  end

  def assert_user_is_authenticated
    redirect_to events_path unless user_logged_in?
  end

  def announcer
    User.find(session[:user_id])
    Announcer.new(flash)
  end
end
