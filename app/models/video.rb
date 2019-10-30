class Video < ApplicationRecord
  belongs_to :user
  validates :link, presence: true
  after_create :crawl_video

  private
  def crawl_video
    YoutubeCrawler.perform_async(id, link)
  end
end
