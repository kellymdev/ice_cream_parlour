Given("a user is on the Games List") do
  visit('/games')
end

Given("I enter {string} as the name") do |string|
  fill_in('Name', with: string)
end