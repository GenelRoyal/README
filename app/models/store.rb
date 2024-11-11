class Store < ApplicationRecord
  has_many :reviews, dependent: :destroy
  
  validates :name, presence: true
  validates :address, presence: true
  validates :tell_number, presence: true
  validates :price, presence: true
  validates :business_hours, presence: true
  validates :content, presence: true
  
  has_one_attached :image
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end
end
