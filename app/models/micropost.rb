class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
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

    #replyに含まれているポストを返す
    # micropost投稿時に@の文字列をreplyカラムに保存する
    # replyされたポストを取得するメソッド
    # replyカラムの文字列と、名前が一致するポストを検索する
    # def including_replies
    #   where(:in_reply_to, self.user.name)
    # end
end
