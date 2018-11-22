When("the {string} link is clicked") do |string|
  click_link(string)
end

When("I click the {string} button") do |string|
  click_on(string)
end

Then("I should see {string}") do |string|
  expect(page).to have_content(string)
end