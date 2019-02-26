class Micropost < ApplicationRecord
  belongs_to :user
  has_many :reply_posts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  # Railsチュートリアルの記述に従った実装
  # あまり呼ばれなさそうなので不要かも
  scope :including_replies, -> (primary_name){ where(in_reply_to: primary_name) }
  mount_uploader :picture, PictureUploader
  before_create :add_reply_column
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

    #@replyがあればin_reply_toに代入する
    def add_reply_column
      #複数リプライは未対応
      reply_user = content.slice(/(?<=@)\w+/)
      self.in_reply_to = reply_user unless reply_user.nil?
    end
end