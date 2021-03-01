class CreateQueryRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :query_recipes do |t|
      t.references :user_query, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
