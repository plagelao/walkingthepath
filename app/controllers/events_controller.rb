#encoding: utf-8
class EventsController < ApplicationController
  include EventsHelper

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
    @event = Event.new params[:event]
    slot = @event.build_slot params[:slot]
    if @event.save
      redirect_to events_path
    else
      flash[:notice] = []
      flash[:notice] << @event.errors[:title].first unless @event.errors[:title].empty?
      flash[:notice] << @event.errors[:link].first unless @event.errors[:link].empty?
      unless slot.valid?
        flash[:notice] << slot.errors[:datetime].first unless slot.errors[:datetime].empty?
      end
      render :new
    end
  end

  private

  def assert_user_is_authenticated
    redirect_to events_path unless user_identified?
  end

end
