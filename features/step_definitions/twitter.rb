When /^I tweet today events$/ do
  WalkingOnTwitter.update
end

Then /^I see a tweet about "([^"]*)" for today at ([^"]*)$/ do |title, time|
  Twitter.last_update.should =~ Regexp.new(title)
  Twitter.last_update.should =~ Regexp.new(time)
end
