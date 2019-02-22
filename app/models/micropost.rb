class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # Railsチュートリアルの記述に従った実装
  # あまり呼ばれなさそうなので不要かも
  scope :including_replies, -> (user_name){ where(in_reply_to: user_name) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence:true
  validates :content, presence:true, length:{maximum:140}
  validate :picture_size

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
