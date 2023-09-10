require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    context 'initial validations' do
      it { is_expected.to validate_presence_of(:firstname) }
      it { is_expected.to validate_presence_of(:lastname) }
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.not_to validate_presence_of(:address) }
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
        expect { create(:admin)}.to change {Admin.count}.by(1)
      end
    end
    
    context 'read' do
      it 'successfully retrieves a record' do
        admin = create(:admin)
        retrieved_admin = Admin.find(admin.id)
   
        expect(retrieved_admin).to_not be_nil
      end
    end

    context 'update' do
      it 'successfully updates a record' do
        admin = create(:admin)
        admin.update(firstname: 'admin')
        
        expect(admin.firstname).to eq('admin')
      end
    end

    context 'delete' do
      it 'successfuly deletes a record' do
        admin = create(:admin)
        
        expect { admin.destroy }.to change {Admin.count}.by(-1)
      end
    end
  end
  
end
