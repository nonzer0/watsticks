class AddFieldToInterviews < ActiveRecord::Migration
  def change
    change_column :interviews, :scheduled_on, :datetime
  end
end
