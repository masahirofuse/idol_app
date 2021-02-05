class PostsController < ApplicationController

  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
  before_action :authenticate_user
  

  def create
    @post = Post.new(
      content: params[:content], 
      user_id: @current_user.id,
      topic_id: params[:topic_id]
    )
    @topic = Topic.find(params[:topic_id])

    if params[:image]
      @post.post_image_name = "#{@post.id}.p.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.post_image_name}",image.read)
    end
    
    
    if @post.save
      @topic.update(post_created_at: @post.created_at)
      flash[:notice] ="コメントが追加されました"
      redirect_to("/topics/#{@post.topic_id}")
    else
      
      redirect_to("/topics/#{@post.topic_id}/confirm")
    end

  end

  

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]

    if params[:image]
      @post.post_image_name = "#{@post.id}.p.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.post_image_name}",image.read)
    end
    
    if @post.save
      flash[:notice] = "更新しましした"
      redirect_to("/topics/#{@post.topic_id}")
    else
      render("/topics/#{@post.topic_id}/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      flash[:notice] = "削除しました"
      redirect_to("/topics/#{@post.topic_id}")
    end
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/topics")
    end
  end
end
