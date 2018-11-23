Feature: View Purchases

Scenario: A user can view a list of purchases for a day
  Given a game exists
    And there is a day with milk of "2" and sugar of "2"
   When I am on the game details screen for the game
   Then I should see "View Purchases"

   When I click the "View Purchases" link
   Then I should see "Daily Purchases"
    And I should see "Ingredient"
    And I should see "Quantity"
    And I should see "Purchase Price"
    And I should see "Total Cost"
    And I should see "2" for the milk quantity
    And I should see "0.50" for the milk price
    And I should see "1.00" for the milk total cost

    And I should see "2" for the sugar quantity
    And I should see "0.02" for the sugar price
    And I should see "0.04" for the sugar total cost

Scenario: The View Purchases link is not shown when there are no purchases
  Given a game exists
    And there is a day with milk of "0" and sugar of "0"
   When I am on the game details screen for the game
   Then I should not see "View Purchases"