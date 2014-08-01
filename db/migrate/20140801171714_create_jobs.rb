class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :industry
      t.date :date_applied
      t.boolean :in_consideration

      t.timestamps
    end
  end
end
