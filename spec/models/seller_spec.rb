require 'rails_helper'

RSpec.describe Seller, type: :model do
  describe 'validations' do
    context 'initial validations' do
      it { is_expected.to validate_presence_of(:firstname) }
      it { is_expected.to validate_presence_of(:lastname) }
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
      it { is_expected.to validate_confirmation_of(:password).with_message("Passwords do not match") }
    end
    
    context 'further validations' do
      it 'validates emails' do
        valid_email = 'valid.example@email.com'
        expect(valid_email).to match(URI::MailTo::EMAIL_REGEXP)
      end

      it 'invalidates emails' do
        invalid_email = 'invalid_email'
        expect(invalid_email).not_to match(URI::MailTo::EMAIL_REGEXP)
      end
    end
  end

  describe 'CRUD operations' do
    context 'create' do
      it 'successfully increases the record count to 1' do
        expect { create(:seller)}.to change {Seller.count}.by(1)
      end
    end
    
    context 'read' do
      it 'successfully retrieves a record' do
        seller = create(:seller)
        retrieved_seller = Seller.find(seller.id)
   
        expect(retrieved_seller).to_not be_nil
      end
    end

    context 'update' do
      it 'successfully updates a record' do
        seller = create(:seller)
        seller.update(firstname: 'seller')
        
        expect(seller.firstname).to eq('seller')
      end
    end

    context 'delete' do
      it 'successfuly deletes a record' do
        seller = create(:seller)
        
        expect { seller.destroy }.to change {Seller.count}.by(-1)
      end
    end
  end

end
