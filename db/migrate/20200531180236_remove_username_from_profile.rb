class RemoveUsernameFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :username, :string
  end
end
