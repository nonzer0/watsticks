class JobsController < ApplicationController
  def new
    @job = Job.new
  end

  def create
    @job = Job.new(jobs_params)

    @job.save
    redirect_to @job
  end

  def show
    @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.all
  end

  private
    def jobs_params
      params.require(:job).permit(:title, :company, :industry, :date_applied)
    end
end
