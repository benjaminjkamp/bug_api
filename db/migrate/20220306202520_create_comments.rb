class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :issue_id
      t.string :input

      t.timestamps
    end
  end
end
