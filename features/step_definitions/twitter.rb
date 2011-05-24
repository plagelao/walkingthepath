When /^I tweet today events$/ do
  WalkingOnTwitter.tweet_today_events
end

When /^I tweet tomorrow events$/ do
  WalkingOnTwitter.tweet_tomorrow_events
end

Then /^I see a tweet about "([^"]*)" for (today|tomorrow) at ([^"]*)$/ do |title, day, time|
  day = day == 'today' ? 'Hoy' : 'Mañana'
  Twitter.last_update.should =~ Regexp.new(title)
  Twitter.last_update.should =~ Regexp.new(time)
  Twitter.last_update.should =~ Regexp.new(day)
end
