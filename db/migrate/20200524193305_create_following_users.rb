class CreateFollowingUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :following_users do |t|
      t.references :following, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
