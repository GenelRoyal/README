class Review < ApplicationRecord
  belongs_to :store
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags

  validates :content, :title, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5, message: 'は1から5の範囲で指定してください' }
  
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end

  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = tags - current_tags
  
      # 古いタグを消す
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
  
      # 新しいタグを保存
      new_tags.each do |new_name|
        tag = Tag.find_or_create_by(name:new_name)
        self.tags << tag
      end
  end

end
