FactoryBot.define do

  initialize_with { type.present? && type.constantize.new(attributes)}

  factory :buyer do
    sequence(:firstname) {"test"}
    sequence(:lastname) {|n| "buyer#{n}"}
    sequence(:email) {|n| "test.buyer#{n}@email.com"}
    sequence(:username) {|n| "test.buyer#{n}"}
    sequence(:address) {'address'}
    sequence(:password) {"password"}
    sequence(:password_confirmation) {"password"}
    type { "Buyer" }
  end

end