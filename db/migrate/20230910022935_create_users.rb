class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :address
      t.string :password_digest
      t.string :token
      t.string :reset_token
      t.string :refresh_token
      t.string :activation_token
      t.string :otp_secret_key
      t.boolean :otp_enabled, default: -> { false }
      t.boolean :otp_required, default: -> { true }
      t.boolean :activated, default: -> { false }
      t.string :type

      t.timestamps
    end
  end
end
