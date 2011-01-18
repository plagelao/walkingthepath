Feature:
  In order to learn from other people
  As a developer
  I want to be able to see the future events

  Scenario: No events
    When I ask for the next events
    Then I should not see any event at all

  Scenario: Events in a determined date
    Given "a pair programming session" event the next week at 10:00
    When I ask for the next events
    Then I must see "a pair programming session" event at 10:00 the next week

  Scenario: Events in the past do not show up
    Given "a pair programming session" event the past week at 10:00
    When I ask for the next events
    Then I should not see any event at all

  Scenario: Events are linked to the event pages
    Given "a pair programming session" event the next week at 10:00 linked to "http://www.google.es"
    When I ask for the next events
    Then the information associated to the "a pair programming session" event must be "http://www.google.es"

  Scenario: Events are ordered by date (first the closer date)
    Given "an open space" event the next week at 12:00
    Given "a pair programming session" event the next week at 10:00
    When I ask for the next events
    Then I must see "a pair programming session" event before "an open space" event
