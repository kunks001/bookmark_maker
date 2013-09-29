Feature: Users
  Scenario: Signing up
    Given the user is visiting the signup page
    When the user enters their information and clicks submit
    Then they should be redirected to the index page
    And there should be a welcome message

  Scenario: Signing up with an incorrect email
    Given the user is visiting the signup page
    When the user enters an incorrect email and clicks submit
    Then they should be redirected to the signup page
    And there should be an error message

  Scenario: Signing up with an incorrect password
    Given the user is visiting the signup page
    When the user enters an incorrect password and clicks submit
    Then they should be redirected to the signup page
    And there should be an error message that the password is incorrect

  @sign_up
  Scenario: Signing up with an incorrect password
    Given the user is signed in
    When the user visits the signup page and tries to sign up
    Then they should be redirected to the index page
    And there should be an error message that they're already signed in

  @sign_up
  Scenario: Signing in with an incorrect password
    Given the user is signed in
    When the user visits the signin page and tries to sign in
    Then they should be redirected to the index page
    And there should be an error message that they're already signed in

  # Scenario: Signing up with a password of incorrect length
  #   Given the user is visiting the signup page
  #   When the user enters a password of incorrect length and clicks submit
  #   Then they should be redirected to the signup page
  #   And there should be an error message that the password is an incorrect length

  @sign_up
  Scenario: Signing out
    Given the user is signed in
    When the user clicks sign out
    Then they should be redirected to the index page
    And there should be a goodbye message

  @sign_up
  Scenario: Signing in
    Given the user is signed out
    When the user signs in
    Then they should be redirected to the index page
    And there should be a welcome message

  Scenario: Resetting forgotten password
    Given the user has forgotten their password
    When the user fills in the forgotten password form
    # Then "example@example.com" should receive an email with subject "reset your password"
