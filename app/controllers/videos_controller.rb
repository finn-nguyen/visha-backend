class VideosController < ApiController
  skip_before_action :authenticate, :only => [:index]

  def index
    @videos = Video.all.order(:updated_at)
    records = paginate(@videos)
    render_records(records)
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      YoutubeCrawler.perform_async(@video.id, @video.link)
      record_created(@video)
    else
      bad_request(@video.errors.messages)
    end
  end

  private
  def video_params
    params.require(:video).permit(:link, :user_id)
  end
end
