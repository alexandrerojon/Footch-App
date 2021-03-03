class CreatePartyRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :party_recipes do |t|
      t.boolean :choosen
      t.references :party, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
