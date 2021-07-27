class RenameUserIdColumnToCreatedByInPostsTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :user_id, :created_by
  end
end
