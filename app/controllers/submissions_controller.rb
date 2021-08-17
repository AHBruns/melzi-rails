class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]

  def index
    @submissions = @current_user.submissions
    @submissions = @submissions.where(buyer_id: params[:buyer_id]) if params[:buyer_id].present?
    @submissions = @submissions.where(work_id: params[:work_id]) if params[:work_id].present?
  end

  def show; end

  def new
    @submission = Submission.new
    @buyers = @current_user.buyers
    @works = @current_user.works
  end

  def edit
    @buyers = @current_user.buyers
    @works = @current_user.works
  end

  def create
    @submission = @current_user.submissions.create_with_files(
      submission_params,
      submission_params[:new_files],
      submission_params[:existing_files]
    )

    if @submission
      flash[:success] = "Submission was successfully created."
      redirect_to @submission
    else
      flash.now[:error] = "Submission creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @submission.update_with_files(
      submission_params,
      submission_params[:new_files],
      submission_params[:existing_files]
    )
      flash[:success] = "Submission was successfully updated."
      redirect_to @submission
    else
      flash.now[:error] = "Submission update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @submission.destroy

    if @submission.destroyed?
      flash[:success] = "Submission was successfully destroyed."
      redirect_to submissions_url
    else
      flash.now[:error] = "Submission destruction failed."
      redirect_to submissions_url, status: :unprocessable_entity
    end
  end

  private

  def set_submission
    @submission = @current_user.submissions.find(params[:id])
  end

  def submission_params
    params.fetch(:submission, {}).permit(:status, :buyer_id, :work_id, existing_files: {}, new_files: [], files: [])
  end
end
