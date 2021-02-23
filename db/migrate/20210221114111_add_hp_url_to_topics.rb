class AddHpUrlToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :hp_url, :string
  end
end
