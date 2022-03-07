class AddInternalToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :internal, :boolean
  end
end
