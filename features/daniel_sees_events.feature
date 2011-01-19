Feature:
  In order to learn from other people
  As a developer
  I want to be able to see the future events as a feed

  Scenario: Events in a determined date
    Given "a pair programming session" event the next week at 10:00
    When I ask for the next events as atom feed
    Then I must see "a pair programming session" event at 10:00 the next week in the feed

