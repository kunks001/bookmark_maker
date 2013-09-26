Feature: Users
	Scenario: Signing up
	  Given the user is visiting the signup page
	  When the user enters their information and clicks submit
	  Then they should be redirected to the index page
	  And there should be a welcome message

	Scenario: Signing out
		Given the user is signed in
		When the user clicks sign out
		Then they should be redirected to the index page
		And there should be a goodbye message

	Scenario: Signing in
		Given the user is signed out
		When the user signs in
		Then they should be redirected to the index page
		And there should be a welcome message