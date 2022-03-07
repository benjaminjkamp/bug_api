class AddLocationToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :location_id, :integer
  end
end
