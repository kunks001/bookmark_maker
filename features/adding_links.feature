Feature: Adding links
	Scenario: User adds a link
	    Given the user is visiting the site
	    When the user enters a new link and clicks Add link
	    Then the link should be displayed
	    And should go to the correct website