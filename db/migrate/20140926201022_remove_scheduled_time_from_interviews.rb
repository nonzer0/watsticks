class RemoveScheduledTimeFromInterviews < ActiveRecord::Migration
  def change
    remove_column :interviews, :scheduled_time
  end
end
