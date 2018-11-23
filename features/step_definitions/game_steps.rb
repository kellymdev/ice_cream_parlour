Given("I am on the Games List") do
  visit('/games')
end

Given("a game exists") do
  @game = CreateGame.new(name: 'Amazing Ice Creams').call
end

Given("there is a day with milk of {string} and sugar of {string}") do |milk_quantity, sugar_quantity|
  day_params = {
    milk_price: 0.50,
    sugar_price: 0.02,
    milk: milk_quantity,
    sugar: sugar_quantity,
    ice_creams_to_make: 0,
    ice_cream_price: 0.60
  }

  @day = ProcessDay.new(@game, day_params).call
end


Given("I am on the game details screen for the game") do
  visit(game_path(@game))
end

Then("I should see a balance of {string}") do |balance|
  within('.current-balance') do
    expect(page).to have_content(balance)
  end
end

Then("I should see a milk inventory of {string}") do |count|
  within('.milk-inventory') do
    expect(page).to have_content(count)
  end
end

Then("I should see a sugar inventory of {string}") do |count|
  within('.sugar-inventory') do
    expect(page).to have_content(count)
  end
end
