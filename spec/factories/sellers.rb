FactoryBot.define do

  initialize_with { type.present? && type.constantize.new(attributes)}

  factory :seller, class: 'Seller' do
    sequence(:firstname) {"test"}
    sequence(:lastname) {|n| "seller#{n}"}
    sequence(:email) {|n| "test.seller#{n}@email.com"}
    sequence(:username) {|n| "test.seller#{n}"}
    sequence(:address) {'address'}
    sequence(:password) {"password"}
    sequence(:password_confirmation) {"password"}
    type { "Seller" }
  end

end