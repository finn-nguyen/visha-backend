class VideosController < ApiController
  def index
  end

  def create
    @video = Video.new(video_params)
    if @video.save
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
