class AddContentAndLinkToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :content, :text
    add_column :posts, :link, :text
  end
end
