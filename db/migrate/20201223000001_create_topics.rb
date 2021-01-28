class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string :title
      t.timestamp :post_created_at

      t.timestamps
    end
  end
end
