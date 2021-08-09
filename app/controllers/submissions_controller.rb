class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]

  def index
    @submissions = @current_user.submissions
    if params[:user_id].present?
      @submissions = @submissions.where(user_id: params[:user_id])
    end
    if params[:buyer_id].present?
      @submissions = @submissions.where(buyer_id: params[:buyer_id])
    end
    if params[:work_id].present?
      @submissions = @submissions.where(work_id: params[:work_id])
    end
    @submissions = @submissions.all
  end

  def show
  end

  def new
    @submission = Submission.new
    @buyers = @current_user.buyers.all
    @works = @current_user.works.all
  end

  def edit
    @buyers = @current_user.buyers.all
    @works = @current_user.works.all
  end

  def create
    @submission = @current_user.submissions.create(submission_params)

    respond_to do |format|
      if @submission.save
        if params[:submission][:new_files].present?
          @submission.files.attach(params[:submission][:new_files])
        end

        format.html { redirect_to @submission, notice: "Submission was successfully created." }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @submission.update(submission_params)
        if params[:submission][:new_files].present?
          @submission.files.attach(params[:submission][:new_files])
        end
        if params[:submission][:existing_files].present?
          params[:submission][:existing_files].each do |id, to_delete|
            if to_delete == "1"
              @submission.files.find(id.to_i).purge
            end
          end
        end

        format.html { redirect_to @submission, notice: "Submission was successfully updated." }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: "Submission was successfully destroyed." }
      format.json { head :no_content }
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
