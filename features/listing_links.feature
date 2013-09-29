Feature: Listing links
  @sign_up
  Scenario: Listing by tags
    Given there are the following links in the system:
	    | url                           | title          | tags      |user_id    |
	    | http://www.makersacademy.com  | Makers Academy | education |1          |
	    | http://www.google.com         | Google         | search    |1          |
	    | http://www.bing.com           | Bing           | search    |1          |
	    | http://www.code.org           | Code.org       | education |1          |
      When the user visits the search tag page
      Then the user will not find the tags "Makers Academy"
      And the user will not find the url "Code.org"
      And the user will find the title "Google"
      And the user will find the title "Bing"

  # Scenario Outline: Tags
 #    Given there is a link "<title>" pointing to "<url>" with the tag "<tag>"
 #    When the uses visits the "<tag>" page
 #    Then the user should see "<title>"

 #    Examples:
 #      | url                           | title          | tag       |
 #      | http://www.makersacademy.com  | Makers Academy | education |
 #      | http://www.google.com         | Google         | search    |
 #      | http://www.bing.com           | Bing           | search    |
 #      | http://www.code.org           | Code.org       | education |