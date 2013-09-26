Feature: Signing up
	Scenario: User signs up to the website
    Given the user is visiting the signup page
    When the user enters their information and clicks submit
    Then they should be redirected to the index page
    And there should be a welcome message