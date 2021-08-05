class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[ show edit update destroy ]

  # GET /buyers or /buyers.json
  def index
    @buyers = @current_user.buyers
    if (params[:user_id].present?) then @buyers = @buyers.where(user_id: params[:user_id]) end
    @buyers = @buyers.all
  end

  # GET /buyers/1 or /buyers/1.json
  def show
  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
  end

  # GET /buyers/1/edit
  def edit
  end

  # POST /buyers or /buyers.json
  def create
    @buyer = @current_user.buyers.create(buyer_params)

    respond_to do |format|
      if @buyer.save
        if params[:buyer][:new_files].present? then @buyer.files.attach(params[:buyer][:new_files]) end

        format.html { redirect_to @buyer, notice: "Buyer was successfully created." }
        format.json { render :show, status: :created, location: @buyer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buyers/1 or /buyers/1.json
  def update
    respond_to do |format|
      if @buyer.update(buyer_params)
        if params[:buyer][:new_files].present? then @buyer.files.attach(params[:buyer][:new_files]) end
        if params[:buyer][:existing_files].present? then
          params[:buyer][:existing_files].each do |id, to_delete|
            if to_delete == "1" then
              @buyer.files.find(id.to_i).purge
            end
          end
        end
          
        format.html { redirect_to @buyer, notice: "Buyer was successfully updated." }
        format.json { render :show, status: :ok, location: @buyer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1 or /buyers/1.json
  def destroy
    @buyer.destroy
    respond_to do |format|
      format.html { redirect_to buyers_url, notice: "Buyer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = @current_user.buyers.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def buyer_params
      params.fetch(:buyer, {}).permit(:name, existing_files: {}, new_files: [], files: [])
    end
end
