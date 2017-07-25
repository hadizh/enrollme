Feature: Manage requests for joining teams
  As a user not currently in a team
  In order to join a team
  I want to be able to send requests to teams, and know their decisions

  Background: There is a team to join
    Given the following teams exist:
      |approved | passcode | submission_id | submitted | declared | pending_requests  |
      |“no”     | “bears1" | 0             | "no"      | "yes"    | 0                 |
      |“no”     | “bears2" | 1             | "no"      | "yes"    | 0                 |
      |“no”     | “bears2" | 2             | "no"      | "yes"    | 0                 |

    And the following users exist
    
      |   name    |       email                       | team      | major             |       sid         |  waitlisted |
      | Tony      |     tony@berkeley.edu             | nil       | Slavic Studies    | 823               | true |
      | An        |    bobjones0@berkeley.edu         | passcode0 | Slavic Studies    | 824               | true |
      | Hezheng   |    bobjones1@berkeley.edu         | passcode1 | Slavic Studies    | 825               | true |
      | George    |    bobjones2@berkeley.edu         | passcode1 | Slavic Studies    | 826               | true |
      | Karl      |    bobjones3@berkeley.edu         | passcode1 | Slavic Studies    | 827               | true |
      | Ken       |    bobjones4@berkeley.edu         | passcode1 | Slavic Studies    | 828               | true |
      | Hadi      |    xxx@berkeley.edu               | passcode1 | Slav1c Studies    | 830               | true |
      | Brandon   |    xx2@berkeley.edu               | passcode1 | Slav1c Studies    | 831               | true |
      | Sahai     |     sahai@berkeley.edu            | passcode2 | Slavic Studies    | 832               | true |
      | Hilfinger |     hilf@berkeley.edu             | passcode2 | Slavic Studies    | 833               | true |
      | Papadimitriou |     papa@berkeley.edu         | passcode2 | Slavic Studies    | 834               | true |
      | Fox       |     fox@berkeley.edu              | passcode2 | Slavic Studies    | 835               | true |
      | Patterson |     pat@berkeley.edu              | passcode2 | Slavic Studies    | 836               | true |


    And I am on the new_user page
    And I fill in "Name" with "Derek Chen"
    And I fill in "Email" with "derekchen@berkeley.edu"
    And I fill in "Sid" with "12345678"
    And I select "DECLARED CS/EECS Major" from "major"
    And I choose "user_waitlisted_true"
    And I press "Sign Up"
    And I follow "Team List"

    Scenario: I send a join request to a team that is not full
      Given I press the "Join" button on the same row as "An"
      Then I should see "request sent"
      Given I follow "Requests"
      Then I should see "An"

    Scenario: I send a join request to a team that is full
      Given I press the "Join" button on the same row as "Hezheng"
      Then I should see "Team is Full"

    Scenario: I want to cancel an active join request
      Given I press the "Join" button on the same row as "An"
      Given I press "Requests"
      Given I press the "Cancel" button on the same row as "An"
      Then I should not see "An"

    Scenario: My request was accepted
      Given I press the "Join" button on the same row as "An"
      Given I login as "An"
      Given I press "Requests"
      Given I press the "Accept" button on the same row as "Derek"
      Then I should see "Request Approved"
      Then I should not see "Derek"
      Given I login as "Derek"
      Then I should see "An"

    Scenario: My request was denied
      Given I press the "Join" button on the same row as "An"
      Given I login as "An"
      Given I press "Requests"
      Given I press the "Reject" button on the same row as "Derek"
      Then I should see "Request Approved"
      Then I should not see "Derek"
      Given I login as "Derek"
      Then I should not see "An"

    Scenario: My request was to a team that is full
      Given I create the user:
        |Name   | team_id |
        |Denero | 2       |
      Given I press the "Join" button on the same row as "An"
      Then I should see "Team is now full"