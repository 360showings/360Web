# == Schema Information
#
# Table name: contents
#
#  id            :integer          not null, primary key
#  listing_id    :integer
#  content_type  :string(255)
#  content_link  :string(255)
#  caption       :string(255)
#  content_group :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# CHARTER
#   Represent media content associated with a listing.
#
# USAGE
#
# NOTES AND WARNINGS
#   Can be regular images, 360 images, or 360 videos. Note that 360 content can consist of multiple files.
# Handle this by assigning each file to a common content_group for a given image. This can also capture ordering.
#
class Content < ActiveRecord::Base
  REGULAR_IMAGE = 'Image'
  REGULAR_VIDEO = 'Video'
  IMAGE_360 = '360 Image'
  VIDEO_360 = '360 Video'
  
  VALID_CONTENT_TYPES = [REGULAR_IMAGE, REGULAR_VIDEO, IMAGE_360, VIDEO_360]
  
  mount_uploader :content_link, ThreeSixtyUploader
  
  belongs_to :listing
  
  validates :content_type, :inclusion => { :in => VALID_CONTENT_TYPES }
  validates :content_group, :numericality => { :only_integer => true, :greater_than => 0 }, :allow_nil => true
end
