class ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show edit update destroy ]

  # GET /contracts or /contracts.json
  def index
    @contracts = @current_user.contracts
    if params[:user_id].present?
      @contracts.where(user_id: params[:user_id])
    end
    if params[:buyer_id].present?
      @contracts.where(buyer_id: params[:buyer_id])
    end
    if params[:submission_id].present?
      @contracts.where(submission_id: params[:submission_id])
    end
    @contracts = @contracts.all
  end

  # GET /contracts/1 or /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts or /contracts.json
  def create
    @contract = @current_user.contracts.create(contract_params)

    # @contract.files.attach(params[:files])

    respond_to do |format|
      if @contract.save
        if params[:contract][:new_files].present?
          @contract.files.attach(params[:contract][:new_files])
        end

        format.html { redirect_to @contract, notice: "Contract was successfully created." }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1 or /contracts/1.json
  def update
    p contract_params

    respond_to do |format|
      if @contract.update(contract_params)
        if params[:contract][:new_files].present?
          @contract.files.attach(params[:contract][:new_files])
        end
        if params[:contract][:existing_files].present?
          params[:contract][:existing_files].each do |id, to_delete|
            if to_delete == "1"
              @contract.files.find(id.to_i).purge
            end
          end
        end

        format.html { redirect_to @contract, notice: "Contract was successfully updated." }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1 or /contracts/1.json
  def destroy
    begin
      @contract.destroy
      respond_to do |format|
        format.html { redirect_to contracts_url, notice: "Contract was successfully destroyed." }
        format.json { head :no_content }
      end
    rescue
      respond_to do |format|
        format.html { redirect_to contracts_url, notice: "Destruction failed. You must destroy all dependent records before destroying that contract." }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = @current_user.contracts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contract_params
    params.fetch(:contract, {}).permit(:notes, :buyer_id, :submission_id, existing_files: {}, new_files: [], files: [])
  end
end
