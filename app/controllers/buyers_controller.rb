class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[ show edit update destroy ]

  def index
    @buyers = @current_user.buyers
  end

  def show; end

  def new
    @buyer = Buyer.new
  end

  def edit; end

  def create
    @buyer = @current_user.buyers.create_with_files(
      buyer_params,
      buyer_params[:new_files],
      buyer_params[:existing_files]
    )

    if @buyer
      flash[:success] = "Buyer was successfully created."
      redirect_to @buyer
    else
      flash.now[:error] = "Buyer creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @buyer.update_with_files(
      buyer_params,
      buyer_params[:new_files],
      buyer_params[:existing_files]
    )
      flash[:success] = "Buyer was successfully updated."
      redirect_to @buyer
    else
      flash.now[:error] = "Buyer update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @buyer.destroy

    if @buyer.destroyed?
      flash[:success] = "Buyer was successfully destroyed."
      redirect_to buyers_url
    else
      flash.now[:error] = "Buyer destruction failed."
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_buyer
    @buyer = @current_user.buyers.find(params[:id])
  end

  def buyer_params
    params.fetch(:buyer, {}).permit(*Buyer.fields(@current_user))
  end
end

