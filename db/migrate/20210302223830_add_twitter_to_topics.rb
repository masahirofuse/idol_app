class AddTwitterToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :twitter, :string
  end
end
