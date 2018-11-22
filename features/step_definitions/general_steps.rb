When("I click the {string} link") do |string|
  click_link(string)
end

When("I click the {string} button") do |string|
  click_on(string)
end

When("I enter {string} into the {string} field") do |value, field_name|
  fill_in(field_name, with: value)
end

Then("I should see {string}") do |string|
  expect(page).to have_content(string)
end
