class AddUpdatedByColumnToPostsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :updated_by, :bigint
  end
end
