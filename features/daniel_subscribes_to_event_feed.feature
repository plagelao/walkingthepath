Feature:
  In order to learn from other people
  As a developer
  I want to be able to subscribe to the events update

  Scenario: Can ask for the feed from the event list
    When I ask for the next events
    Then I must see an ask for the feed option

  Scenario: New event created
    Given "a pair programming session" event the next week at 10:00
    When I subscribe to the events update
    Then I must receive a notification of "a pair programming session" event at 10:00 the next week
