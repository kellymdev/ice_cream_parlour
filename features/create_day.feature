Feature: Create Day

Scenario: A user can create a new day
  Given a game exists
    And I am on the game details screen for the game
   When I click the "New Day" link
   Then I should see "New Day for: Amazing Ice Creams"
    And I should see "Today's milk price is"
    And I should see "Today's sugar price is"

   When I enter "1" into the "How much milk do you need?" field
    And I enter "1" into the "How much sugar do you need?" field
    And I enter "1" into the "How many ice creams will you make?" field
    And I enter "1.00" into the "What price will you sell your ice creams for?" field
    And I click the "Make Ice Creams" button
   Then I should see "You made 1 ice cream."
    And I should see "You made a profit of"