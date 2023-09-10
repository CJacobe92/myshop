class Api::V1::AdminsController < ApplicationController
  before_action :set_admin, except: [:index, :create]

  def index
    @admins = Admin.all
    render json: { data: @admins },
    except: excluded_admin_json_attributes,
    status: :ok
  end

  def create
    @admin = Admin.new(admin_params)
    
    if @admin.save
      render json: { data: @admin },
      except: excluded_non_admin_json_attributes,
      status: :created
    else
      render json: { error: "Failed to create" }, status: :unprocessable_entity
    end
  end

  def show
    return unless @current_admin
    render json: {data: @current_admin},
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def update
    return unless @current_admin.update(admin_params)
    render json: { data: @current_admin },
    except: excluded_non_admin_json_attributes,
    status: :ok
  end

  def destroy
    return unless @current_admin.destroy
    head :no_content
  end

  private

  def admin_params
    params.require(:admin).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :address)
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

  def set_admin
    @current_admin ||= Admin.find(params[:id])
  end
end
