class CreateReplyPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :reply_posts do |t|
      t.integer :user_id
      t.references :micropost, foreign_key: true

      t.timestamps
    end
  end
end
