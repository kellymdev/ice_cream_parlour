FactoryBot.define do
  factory :inventory do
    game
    milk { 1 }
    sugar { 1 }
    balance { 5 }
  end
end
