class Site < ApplicationRecord
  serialize :content, Array

  validates :url, presence: true, url: true
end
