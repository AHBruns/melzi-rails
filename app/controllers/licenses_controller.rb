class LicensesController < ApplicationController
  before_action :set_license, only: %i[ show edit update destroy ]

  # GET /licenses or /licenses.json
  def index
    @licenses = @current_user.licenses
    if (params[:user_id].present?) then @licenses = @licenses.where(user_id: params[:user_id]) end
    if (params[:work_id].present?) then @licenses = @licenses.where(work_id: params[:work_id]) end
    if (params[:contract_id].present?) then @licenses = @licenses.where(contract_id: params[:contract_id]) end
    @licenses = @licenses.all
    p @licenses
  end

  # GET /licenses/1 or /licenses/1.json
  def show
  end

  # GET /licenses/new
  def new
    @license = License.new
  end

  # GET /licenses/1/edit
  def edit
  end

  # POST /licenses or /licenses.json
  def create
    @license = @current_user.licenses.create(license_params)

    respond_to do |format|
      if @license.save
        if params[:license][:new_files].present? then @license.files.attach(params[:license][:new_files]) end

        format.html { redirect_to @license, notice: "License was successfully created." }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1 or /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        if params[:license][:new_files].present? then @license.files.attach(params[:license][:new_files]) end
        if params[:license][:existing_files].present? then
          params[:license][:existing_files].each do |id, to_delete|
            if to_delete == "1" then
              @license.files.find(id.to_i).purge
            end
          end
        end
        
        format.html { redirect_to @license, notice: "License was successfully updated." }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenses/1 or /licenses/1.json
  def destroy
    @license.destroy
    respond_to do |format|
      format.html { redirect_to licenses_url, notice: "License was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = @current_user.licenses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def license_params
      params.fetch(:license, {}).permit(:work_id, :contract_id, existing_files: {}, new_files: [], files: [])
    end
end
