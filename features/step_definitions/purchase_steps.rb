Then("I should see {string} for the milk quantity") do |quantity|
  within('.milk-row .quantity') do
    expect(page).to have_content(quantity)
  end
end

Then("I should see {string} for the milk price") do |price|
  within('.milk-row .purchase-price') do
    expect(page).to have_content(price)
  end
end

Then("I should see {string} for the milk total cost") do |cost|
  within('.milk-row .total-cost') do
    expect(page).to have_content(cost)
  end
end

Then("I should see {string} for the sugar quantity") do |quantity|
  within('.sugar-row .quantity') do
    expect(page).to have_content(quantity)
  end
end

Then("I should see {string} for the sugar price") do |price|
  within('.sugar-row .purchase-price') do
    expect(page).to have_content(price)
  end
end

Then("I should see {string} for the sugar total cost") do |cost|
  within('.sugar-row .total-cost') do
    expect(page).to have_content(cost)
  end
end
