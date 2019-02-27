class Micropost < ApplicationRecord
  belongs_to :user
  has_many :reply_posts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  after_create :create_reply_post
  validates :user_id, presence:true
  validates :content, presence:true, length:{maximum:140}
  validate :picture_size

  def self.find_reply_post(user_id)
    reply_post_ids = ReplyPost.where(user_id: user_id).map(&:micropost_id)
    Micropost.where(id: reply_post_ids)
  end

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    #@replyがprimary_nameならばreply_postにレコード追加
    def create_reply_post
      reply_users = content.scan(/(?<=@)\w+/)
      if !reply_users.empty?
        reply_users.each do |reply_user|
          target_user = User.find_by(primary_name: reply_user)
          self.reply_posts.create!(user_id: target_user.id) unless target_user.nil?
        end
      end
    end
end