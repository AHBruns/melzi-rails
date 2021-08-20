class WorksController < ApplicationController
  before_action :set_work, only: %i[ show edit update destroy ]

  def index
    @works = @current_user.works
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def create
    p work_params
    @work = @current_user.works.create_with_files(
      work_params,
      work_params[:new_files],
      work_params[:existing_files]
    )
    p @work

    if @work
      flash[:success] = "Work was successfully created."
      redirect_to @work
    else
      flash.now[:error] = "Work creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @work.update_with_files(
      work_params,
      work_params[:new_files],
      work_params[:existing_files]
    )
      flash[:success] = "Work was successfully updated."
      redirect_to @work
    else
      flash.now[:error] = "Work update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work.destroy

    if @work.destroyed?
      flash[:success] = "Work was successfully destroyed."
      redirect_to works_url
    else
      flash.now[:success] = "Work destruction failed."
      redirect_to works_url, status: :unprocessable_entity
    end
  end

  private

  def set_work
    @work = @current_user.works.find(params[:id])
  end

  def work_params
    params.fetch(:work, {}).permit(*Work.fields(@current_user))
  end
end
