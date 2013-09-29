@sign_up
Feature: Adding links
  Scenario: User adds a link
    Given the user is signed in
    When the user enters a new link and clicks Add link
    Then the link should be displayed
    And should go to the correct website

  Scenario: User adds a link without a title
    Given the user is signed in
    When the user enters a new link without a title and clicks Add link
    Then there should be an error message to include a title