class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.date :scheduled_on
      t.time :scheduled_time

      t.timestamps
    end
  end
end
