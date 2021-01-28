class TopicsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
  
  def index
    @topics = Topic.all.order(post_created_at: "DESC")
    @topic = Topic.find_by(id: params[:id])
  end

  def new

  end

  def search
    if params[:title].present?
      @topics = Topic.where('title LIKE ?', "%#{params[:title]}%")
    else
      @topics = Topic.none
      redirect_to("/topics")
      flash[:notice] = "関連するトピックは見つかりませんでした"
    end
  end
 
  

  def show
    @topic = Topic.find_by(id: params[:id])
    @posts = Post.where(topic_id: params[:id])
  end

  def confirm
    @topic = Topic.find_by(id: params[:id])
  end

  def create
    @topic = Topic.new(
      title: params[:title],
      user_id: @current_user.id
    )
    if @topic.save
      redirect_to("/topics")
      flash[:notice] = "新しいスレッドが作成されました"

    end
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    @topic.title = params[:title]
    
    unless params[:youtube_url] == ""
      url = params[:youtube_url]
      url = url.last(11)
      @topic.youtube_url = url
    end

    if params[:image]
      @topic.topic_image_name = "#{@topic.id}.t.jpg"
      image = params[:image]
      File.binwrite("public/topic_images/#{@topic.topic_image_name}",image.read)
    end

    if @topic.save
      flash[:notice] = "更新しました"
      redirect_to("/topics/#{@topic.id}")
    else
      render("/topics/#{@topic.id}/edit")
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    @topic.destroy
    flash[:notice] = "削除しました"
    redirect_to("/topics")
  end

  def ensure_correct_user
    @topic = Topic.find_by(id: params[:id])
    if @topic.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/topics")
    end
  end
end
