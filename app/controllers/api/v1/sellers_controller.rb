class Api::V1::SellersController < ApplicationController
  before_action :set_seller, except: [:index, :create]

  def index
    @sellers = Seller.all
    render json: { data: @sellers },
    except: excluded_admin_json_attributes,
    status: :ok
  end

  def create
    @seller = Seller.new(seller_params)
    
    if @seller.save
      render json: { data: @seller },
      except: excluded_non_admin_json_attributes,
      status: :created
    else
      render json: { error: "Failed to create" }, status: :unprocessable_entity
    end
  end

  def show
    return unless @current_seller
    render json: {data: @current_seller},
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def update
    return unless @current_seller.update(seller_params)
    render json: { data: @current_seller },
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def destroy
    return unless @current_seller.destroy
    head :no_content
  end

  private

  def seller_params
    params.require(:seller).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :address)
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

  def set_seller
    @current_seller ||= Seller.find(params[:id])
  end
end
