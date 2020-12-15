class FaqHashtags < ActiveRecord::Base
  belongs_to :faq
  belongs_to :hashtag

  validates :faq_id, presence: true
  validates :hashtag_id, presence: true
end
