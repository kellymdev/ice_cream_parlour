Given("I am on the Games List") do
  visit('/games')
end

Given("a game exists") do
  @game = CreateGame.new(name: 'Amazing Ice Creams').call
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
