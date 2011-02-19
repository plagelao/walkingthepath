Feature:
  In order to improve the user experience
  As a developer
  I want to identify the users in the system

  Scenario: Can sign in
    When I ask for the next events
    And I identify myself as "Alberto"
    Then I get a personal message for "Alberto"

