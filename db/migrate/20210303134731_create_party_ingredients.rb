class CreatePartyIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :party_ingredients do |t|
      t.string :name
      t.references :user_party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
