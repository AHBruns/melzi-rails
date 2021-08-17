class ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show edit update destroy ]

  def index
    @contracts = @current_user.contracts
    @contracts = @contracts.find_by_buyer_id(params[:buyer_id]) if params[:buyer_id].present?
    @contracts = @contracts.find_by_submission_id(params[:submission_id]) if params[:submission_id].present?
  end

  def show; end

  def new
    @contract = Contract.new
  end

  def edit; end

  def create
    @contract = @current_user.contracts.create_with_files(
      contract_params,
      contract_params[:new_files],
      params[:contract][:existing_files]
    )

    if @contract
      flash[:success] = "Contract was successfully created."
      redirect_to @contract
    else
      flash.now[:error] = "Contract creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @contract.update_with_files(
      contract_params,
      contract_params[:new_files],
      contract_params[:existing_files]
    )
      flash[:success] = "Contract was successfully updated."
      redirect_to @contract
    else
      flash.now[:error] = "Contract update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy

    if @contract.destroyed?
      flash[:success] = "Contract was successfully destroyed."
      redirect_to contracts_url
    else
      flash[:error] = "Contract destruction failed."
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_contract
    @contract = @current_user.contracts.find(params[:id])
  end

  def contract_params
    params.fetch(:contract, {}).permit(*Contract.fields)
  end
end
