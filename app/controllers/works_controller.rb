class WorksController < ApplicationController
  before_action :set_work, only: %i[ show edit update destroy ]

  def index
    @works = @current_user.works
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    respond_to do |format|
      ApplicationRecord.transaction do
        @work = @current_user.works.build(work_params)

        if @work.save
          if params[:work][:new_files].present?
            @work.files.attach(params[:work][:new_files])
          end

          format.html { redirect_to @work, notice: "Work was successfully created." }
          format.json { render :show, status: :created, location: @work }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @work.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      ApplicationRecord.transaction do
        if @work.update(work_params)
          if params[:work][:new_files].present?
            @work.files.attach(params[:work][:new_files])
          end
          if params[:work][:existing_files].present?
            params[:work][:existing_files].each do |id, to_delete|
              if to_delete == "1"
                @work.files.find(id.to_i).purge
              end
            end
          end

          format.html { redirect_to @work, notice: "Work was successfully updated." }
          format.json { render :show, status: :ok, location: @work }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @work.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: "Work was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_work
    @work = @current_user.works.find(params[:id])
  end

  def work_params
    params.fetch(:work, {}).permit(:stage, :title, existing_files: {}, new_files: [], files: [])
  end
end
