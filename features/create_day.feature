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

Scenario: A user can't create a new day if they don't have enough ingredients to make ice creams
  Given a game exists
    And I am on the game details screen for the game
   When I click the "New Day" link
   Then I should see "New Day for: Amazing Ice Creams"

   When I enter "1" into the "How much milk do you need?" field
    And I enter "1" into the "How much sugar do you need?" field
    And I enter "5" into the "How many ice creams will you make?" field
    And I enter "1.00" into the "What price will you sell your ice creams for?" field
    And I click the "Make Ice Creams" button
   Then I should see "You don't have enough ingredients to make that many ice creams"
    And I should see a balance of "5.00"
    And I should see a milk inventory of "0"
    And I should see a sugar inventory of "0"
