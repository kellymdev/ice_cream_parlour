Feature: Game Creation

Scenario: A user can create a new game
  Given a user is on the Games List
   When I click the "New Game" link
   Then I should see "New Game"
   Then I should see "Back to Games List"

   When I enter "Amazing Ice Creams" into the "Name" field
    And I click the "Create Game" button
   Then I should see "Amazing Ice Creams"
    And I should see "Balance"
    And I should see "$5.00"