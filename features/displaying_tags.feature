Feature: displaying tags
  @sign_up 
  @sign_in
	Scenario: When signed in and on the home page
	    Given there are the following links in the system:
	    | url                           | title          | tags      |user_id    |
	    | http://www.makersacademy.com  | Makers Academy | education |1          |
	    | http://www.google.com         | Google         | search    |1          |
	    | http://www.bing.com           | Bing           | search    |1          |
	    | http://www.code.org           | Code.org       | education |1          |
			When the user is on the home page
			Then they should see a list of available tags

  #ADD FUNCTIONALITY: LIST OF TAGS AS LINKS