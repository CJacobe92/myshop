class Api::V1::BuyersController < ApplicationController
  before_action :set_buyer, except: [:index, :create]

  def index
    @buyers = Buyer.all
    render json: { data: @buyers },
    except: excluded_admin_json_attributes,
    status: :ok
  end

  def create
    @buyer = Buyer.new(buyer_params)
    
    if @buyer.save
      render json: { data: @buyer },
      except: excluded_non_admin_json_attributes,
      status: :created
    else
      render json: { error: "Failed to create" }, status: :unprocessable_entity
    end
  end

  def show
    return unless @current_buyer
    render json: {data: @current_buyer},
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def update
    return unless @current_buyer.update(buyer_params)
    render json: { data: @current_buyer },
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def destroy
    return unless @current_buyer.destroy
    head :no_content
  end

  private

  def buyer_params
    params.require(:buyer).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :address)
  end

  def excluded_non_admin_json_attributes
    [
      :password_digest, 
      :token, 
      :reset_token, 
      :refresh_token, 
      :activation_token, 
      :otp_secret_key,
      :otp_required, 
      :otp_enabled, 
      :activated
    ]
  end

  def excluded_admin_json_attributes
    [
      :password_digest, 
      :token, 
      :reset_token, 
      :refresh_token, 
      :activation_token, 
      :otp_secret_key
    ]
  end

  def set_buyer
    @current_buyer ||= Buyer.find(params[:id])
  end
end
