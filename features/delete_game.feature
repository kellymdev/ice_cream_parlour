Feature: Delete Game

Scenario: A user can delete a Game from the Games List
  Given a game exists
    And I am on the Games List
   When I click the "Delete" link
   Then I should see "Game successfully deleted"
    And I should not see "Amazing Ice Creams"

Scenario: A user can delete a Game from the Game Details screen
  Given a game exists
    And I am on the game details screen for the game
   When I click the "Delete" link
   Then I should see "Game successfully deleted"
    And I should not see "Amazing Ice Creams"