class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.integer :app_id
      t.string :type
      t.string :severity
      t.string :summary
      t.text :description
      t.datetime :time
      t.string :char_name
      t.string :impact
      t.string :category
      t.boolean :internal
      t.string :status

      t.timestamps
    end
  end
end
