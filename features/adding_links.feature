Feature: Adding links
  @sign_up
	Scenario: User adds a link
    Given the user is signed in
    When the user enters a new link and clicks Add link
    Then the link should be displayed
    And should go to the correct website