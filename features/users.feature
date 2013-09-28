Feature: Users
	Scenario: Signing up
	  Given the user is visiting the signup page
	  When the user enters their information and clicks submit
	  Then they should be redirected to the index page
	  And there should be a welcome message

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
