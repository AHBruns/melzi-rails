require 'securerandom'
require 'digest'

class UsersController < ApplicationController
  skip_before_action :require_current_user, only: [:index, :show, :new, :create, :assume]
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    salt = SecureRandom.hex
    @user = User.new(
      email: user_params[:email],
      salt: salt,
      salted_password_hash: Digest::SHA2.new(512).hexdigest(salt + user_params[:password])
    )

    respond_to do |format|
      if @user.save
        if params[:user][:new_files].present?
          @user.files.attach(params[:user][:new_files])
        end

        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @current_user.id != @user.id
      respond_to do |format|
        format.html { redirect_to users_url, notice: "You can't edit a user you aren't logged into." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        if @user.update(
          email: user_params[:email],
          salted_password_hash: if !user_params[:password].blank?
                                  Digest::SHA2.new(512).hexdigest(@user.salt + user_params[:password])
                                else
                                  @user.salted_password_hash
                                end
        )
          if params[:user][:new_files].present?
            @user.files.attach(params[:user][:new_files])
          end
          if params[:user][:existing_files].present?
            params[:user][:existing_files].each do |id, to_delete|
              if to_delete == "1"
                @user.files.find(id.to_i).purge
              end
            end
          end

          format.html { redirect_to @user, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @current_user == @user
        @user.destroy
        session.delete(:user_id)
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      else
        format.html { redirect_to users_url, notice: "You can't destroy a user you aren't logged into." }
      end
      format.json { head :no_content } # TODO - handle failure case in JSON
    end
  end

  def assume
    old_user_id = session[:user_id]
    session[:user_id] = params[:id]
    set_current_user
    p @current_user
    respond_to do |format|
      if @current_user.present?
        format.html { redirect_to users_url, notice: "User was successfully logged in." }
        format.json { head :no_content }
      else
        session[:user_id] = old_user_id
        format.html { redirect_to users_url, notice: "Wrong email and/or password." }
        format.json { head :no_content }
      end
    end
  end

  def unassume
    session.delete(:user_id)
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully logged out." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :password, existing_files: {}, new_files: [], files: [])
  end
end
