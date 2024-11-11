class Review < ApplicationRecord
  belongs_to :store
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg'). 
    end
      image.variant(resize_to_limit: [width,height]).processed
  end
end
end
