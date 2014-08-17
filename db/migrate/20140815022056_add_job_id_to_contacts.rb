class AddJobIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :job_id, :integer
  end
end
