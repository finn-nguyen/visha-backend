class YoutubeCrawler
  include Sidekiq::Worker

  def perform(video_id, video_link)
    agent = Mechanize.new
    page = agent.get(video_link)
    title = (page.search("h1 span.watch-title").try :text || "").strip
    description = (page.at("#watch-description-text").try :text || "").strip
    views = (page.at(".view-count").try :text || "").strip.split(" ").first
    video = Video.find(video_id)
    video.update(title: title, description: description, views: views)
  rescue Exception => error
    Rails.logger.error("Crawl #{video_link} failed, #{error}")
  end
end