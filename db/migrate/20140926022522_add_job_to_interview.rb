class AddJobToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :job_id, :integer
  end
end
