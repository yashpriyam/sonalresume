class Play < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :play_img, styles: { medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.jpg", validate_media_type: false
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
