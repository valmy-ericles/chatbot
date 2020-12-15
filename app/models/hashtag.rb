class Hashtag < ActiveRecord::Base
  validates :name, presence: true

  has_many :faq_hashtags
  has_many :faqs, through: :faq_hashtags
end
