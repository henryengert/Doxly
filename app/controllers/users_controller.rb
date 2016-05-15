class UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_super_admin!
  before_action :set_user, only: [:destroy, :update, :show]
  before_action :ensure_params_exist, only: [:update, :create]
  skip_before_action :verify_authenticity_token

  def index
    @users = User.page(@page).per(@per_page) rescue []
    success_response(
      {
        users: @users.map(&:to_hash)
      }
    )
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    if @user.save
      success_response(["User created successfully."])
    else
      error_response(@user.errors)
    end
  end

  def update
    if @user.update(user_params)
      success_response(["User updated successfully"])
    else
      error_response(@user.errors)
    end
  end

  def show
    success_response(
      {
        user: @user.to_hash
      }
    )
  end

  def destroy
    if @user.destroy
      success_response(["User destroyed successfully"])
    else
      error_response(@user.errors)
    end
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
    error_response(["User Not Found"]) if @user.blank?
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone,
      :address,
      :company
    )
  end

  protected
  def ensure_params_exist
    if params[:user].blank?
      error_response(["User related parameters not found."])
    end
  end
end