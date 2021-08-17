class LicensesController < ApplicationController
  before_action :set_license, only: %i[ show edit update destroy ]

  def index
    @licenses = @current_user.licenses
    @licenses = @licenses.where(work_id: params[:work_id]) if params[:work_id].present?
    @licenses = @licenses.where(contract_id: params[:contract_id]) if params[:contract_id].present?
  end

  def show; end

  def new
    @license = License.new
  end

  def edit; end

  def create
    @license = @current_user.licenses.create_with_files(
      license_params,
      license_params[:new_files],
      license_params[:existing_files]
    )

    if @license
      flash[:success] = "License was successfully created."
      redirect_to @license
    else
      flash.now[:error] = "License creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    p license_params

    if @license.update_with_files(
      license_params,
      license_params[:new_files],
      license_params[:existing_files]
    )
      flash[:success] = "License was successfully updated."
      redirect_to @license
    else
      flash.now[:error] = "License update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @license.destroy

    if @license.destroyed?
      flash[:success] = "License was successfully destroyed."
      redirect_to licenses_url
    else
      flash.now[:error] = "License destruction failed."
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_license
    @license = @current_user.licenses.find(params[:id])
  end

  def license_params
    params.fetch(:license, {}).permit(*License.fields)
  end
end
