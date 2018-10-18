FactoryBot.define do
  factory :day do
    game
    temperature { 20.0 }
    milk_price { 0.5 }
    sugar_price { 0.02 }
    ice_creams_made { 5 }
    ice_creams_sold { 4 }
    ice_cream_price { 1.0 }
    profit { 3.0 }
  end
end
