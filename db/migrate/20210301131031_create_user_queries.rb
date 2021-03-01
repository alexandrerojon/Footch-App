class CreateUserQueries < ActiveRecord::Migration[6.0]
  def change
    create_table :user_queries do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
