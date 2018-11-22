When("I click the {string} link") do |link_text|
  click_link(link_text)
end

When("I click the {string} button") do |button_text|
  click_on(button_text)
end

When("I enter {string} into the {string} field") do |value, field_name|
  fill_in(field_name, with: value)
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

Then("I should not see {string}") do |text|
  expect(page).not_to have_content(text)
end
