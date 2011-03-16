Feature:
  In order to learn from other people
  As a developer
  I want to be able to see the future events

  Scenario: Can not create events if not signed in
    When I ask for the next events
    Then I am not able to create new events

  Scenario: create an event
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I create "a pair programming session" event for the next week at 10:00
    And I ask for the next events
    Then I must see "a pair programming session" event at 10:00 the next week

  Scenario: create an event without an event name
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I create an event without title
    Then I get notified about the need to fill the event title

  Scenario: create an event without an event link
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I create an event without link
    Then I get notified about the need to fill the event link

  @wip
  Scenario: create an event with a date in the past
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I create an event with a date in the past
    Then I get notified about the need to set only future dates
