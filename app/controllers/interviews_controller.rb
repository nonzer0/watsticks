class InterviewsController < ApplicationController
  before_action :signed_in_user

  def new
    @interview = Interview.new
  end

  def index
    @interviews = Interview.where("user_id = user_id AND scheduled_on >= scheduled_on",
     user_id: current_user.id, scheduled_on: Date.today)
  end

  def create
    interview_time = DateTime.strptime(interview_params[:scheduled_on], '%m/%d/%Y %l:%M %p')
    puts "TIME: #{interview_time}"
    @interview = Interview.new(user_id: current_user.id, scheduled_on: interview_time, job_id: interview_params[:job_id])
    @user = current_user
    puts "user #{@user}"
    if @interview.save
      flash[:success] = 'interview saved!'
      redirect_to @interview.job
    else
      flash[:alert]
    end
  end

  def show
    @interview = Interview.find(params[:id])
  end

  def user_interviews
    @interviews = Interview.where(user_id: params[:user_id]).to_a
    render 'index'
  end

  private

    def interview_params
      params.require(:interview).permit(:scheduled_on, :user_id, :job_id)
    end
end
