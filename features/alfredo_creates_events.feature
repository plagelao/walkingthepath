Feature:
  In order to learn from other people
  As a developer
  I want to be able to see the future events

  Scenario: create an event
    When I create "a pair programming session" event for the next week at 10:00
    And I ask for the next events
    Then I must see "a pair programming session" event at 10:00 the next week
