class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.jsonb :ingredients
      t.jsonb :instructions
      t.integer :api_id

      t.timestamps
    end
  end
end
