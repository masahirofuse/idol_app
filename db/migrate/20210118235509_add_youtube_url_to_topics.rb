class AddYoutubeUrlToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :youtube_url, :string
  end
end
