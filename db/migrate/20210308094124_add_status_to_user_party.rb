class AddStatusToUserParty < ActiveRecord::Migration[6.0]
  def change
    add_column :user_parties, :status, :string
  end
end
