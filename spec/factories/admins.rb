FactoryBot.define do

  initialize_with { type.present? && type.constantize.new(attributes)}

  factory :admin, class: 'Admin' do
    sequence(:firstname) {"test"}
    sequence(:lastname) {|n| "Admin#{n}"}
    sequence(:email) {|n| "test.Admin#{n}@email.com"}
    sequence(:username) {|n| "test.Admin#{n}"}
    sequence(:address) {nil}
    sequence(:password) {"password"}
    sequence(:password_confirmation) {"password"}
    type { "Admin" }
  end

end
