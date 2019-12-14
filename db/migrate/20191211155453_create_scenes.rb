class CreateScenes < ActiveRecord::Migration[6.0]
  def change
    create_table :scenes do |t|
      t.string :name
      t.string :description
      t.integer :project_id
    end 
  end
end
