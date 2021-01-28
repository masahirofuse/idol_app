class AddTopicImageNameToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :topic_image_name, :string
  end
end
