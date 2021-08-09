class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[ show edit update destroy ]

  def index
    @buyers = @current_user.buyers
  end

  def show
  end

  def new
    @buyer = Buyer.new
  end

  def edit
  end

  def create
    ApplicationRecord.transaction do
      @buyer = @current_user.buyers.create!(buyer_params)
      @buyer.files.attach(params[:buyer][:new_files]) if params[:buyer][:new_files].present?
    end

    respond_to do |format|
      format.html { redirect_to @buyer, notice: "Buyer was successfully created." }
      format.json { render :show, status: :created, location: @buyer }
    end
  rescue
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @buyer.errors, status: :unprocessable_entity }
    end
  end

  def update
    ApplicationRecord.transaction do
      @buyer.update!(buyer_params)
      @buyer.files.attach(params[:buyer][:new_files]) if params[:buyer][:new_files].present?
      if params[:buyer][:existing_files].present?
        params[:buyer][:existing_files].each do |id, to_delete|
          @buyer.files.find(id.to_i).purge if to_delete == "1"
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to @buyer, notice: "Buyer was successfully updated." }
      format.json { render :show, status: :ok, location: @buyer }
    end
  rescue
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @buyer.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @buyer.destroy
    respond_to do |format|
      format.html { redirect_to buyers_url, notice: "Buyer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_buyer
    @buyer = @current_user.buyers.find(params[:id])
  end

  def buyer_params
    params.fetch(:buyer, {}).permit(:name, existing_files: {}, new_files: [], files: [])
  end
end

