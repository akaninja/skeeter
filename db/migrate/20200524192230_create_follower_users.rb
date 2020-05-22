class CreateFollowerUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :follower_users do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
