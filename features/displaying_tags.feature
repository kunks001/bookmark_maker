Feature: displaying tags
  @sign_up 
  @sign_in
	Scenario: When signed in and on the home page
	    Given there are the following links in the system:
	    | url                           | title          | tags      |
	    | http://www.makersacademy.com  | Makers Academy | education |
	    | http://www.google.com         | Google         | search    |
	    | http://www.bing.com           | Bing           | search    |
	    | http://www.code.org           | Code.org       | education |
			When the user is on the home page
			Then they should see a list of available tags