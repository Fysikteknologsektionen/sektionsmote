FactoryBot.define do
  factory :adjustment do
    agenda_item
    user
    presence true
  end
end
