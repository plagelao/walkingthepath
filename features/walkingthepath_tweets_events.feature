Feature: The application tweet the upcoming events

  Scenario: walkingthepath_ tweets today events
    Given "a pair programming session" event today at 23:59
    When I tweet today events
    Then I see a tweet about "a pair programming session" for today at 23:59

  Scenario: walkingthepath_ tweets tomorrow events
    Given "a pair programming session" event tomorrow at 23:59
    When I tweet tomorrow events
    Then I see a tweet about "a pair programming session" for tomorrow at 23:59
