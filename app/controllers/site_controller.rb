class SiteController < ApplicationController
  def events
    @events = Event.find(:all, :conditions => ["date > #{DateTime.now.strftime('%Y%m%d%H%M')}"], :order => 'date')
  end
end
