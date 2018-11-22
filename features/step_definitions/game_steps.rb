Given("I am on the Games List") do
  visit('/games')
end

Given("a game exists") do
  @game = CreateGame.new(name: 'Amazing Ice Creams').call
end

Given("I am on the game details screen for the game") do
  visit(game_path(@game))
end
