class AddDefaultTrueToInConsideration < ActiveRecord::Migration
  def change
    change_column :jobs, :in_consideration, :boolean, default: true
  end
end
