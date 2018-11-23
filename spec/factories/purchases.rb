FactoryBot.define do
  factory :purchase do
    day
    ingredient { 'milk' }
    quantity { 1 }
  end
end
