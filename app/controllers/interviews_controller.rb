class InterviewsController < ApplicationController
	before_action :signed_in_user

	def new
		@interview = Interview.new
	end

	def index
		@interviews = Interview.where("user_id = user_id AND scheduled_on >= scheduled_on",
		 user_id: current_user.id, scheduled_on: Date.today)
	end

  def show
    @interview = Interview.find(params[:id])
  end

	private

		def interview_params
			params.require(:interview).permit(:scheduled_on)
		end
end
