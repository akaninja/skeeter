class AddFieldsToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :username, :string
    add_column :profiles, :name, :string
    add_column :profiles, :bio, :string
  end
end
