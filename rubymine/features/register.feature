Feature: Register Feature

  Background: I am on Start Page
    Given I am on Start  Page
    When I click register link
    Then I am on Registration Page


  Scenario Outline: Positive Registration
    When I am want to fill registration form
    #And I register
    And I enter "<login>" in the login field
    And I enter "<password>" in the password field
    And I enter "<password_conf>" in the password_conf field
    And I enter "<firstname>" in the firstname field
    And I enter "<lastname>" in the lastname field
    And I enter "<mail>" in the mail field
    #And I choose "<language>" for interface
    And I click button submit
    Then I logged in as "<login>"

  Examples:
    | login  | password | password_conf | firstname | lastname| mail   | language  |
    | tester8 | tester   | tester        | tester8    | tester8  | tester8@i.ua |   en |




