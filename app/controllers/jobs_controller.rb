class JobsController < ApplicationController
  before_action :signed_in_user

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      flash[:success] = "job saved"
      redirect_to @job
    else
      flash[:alert]
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.where(user_id: current_user.id)
  end

  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job deleted"
    redirect_to jobs_path
  end

  private
    def job_params
      params.require(:job).permit(:title, :company, :industry, :date_applied)
    end
end
