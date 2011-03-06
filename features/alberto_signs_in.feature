Feature:
  In order to improve the user experience
  As a developer
  I want to identify the users in the system

  Scenario: Can sign in as an already exisiting user
    Given a user named "Alberto"
    When I ask for the next events
    And I identify myself as "Alberto"
    Then I get a personal message for "Alberto"

  Scenario: Can sign in as a new user
    When I ask for the next events
    And I identify myself as "Alberto"
    Then I get a personal message for "Alberto"

  Scenario: Can not sign again if already signed in
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I ask for the next events
    Then I am not able to sign in again

  @wip
  Scenario: Can sign out if signed in
    Given I ask for the next events
    And I identify myself as "Alberto"
    When I ask for the next events
    And I sign out
    Then I see an option to sign in
