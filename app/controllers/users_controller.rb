class UsersController < ApplicationController
  before_action :authenticate_user,{only:[:index, :show, :edit, :update]}
  before_action:forbid_login_user,{only:[:create, :login, :login_form]}
  before_action :ensure_correct_user, {only:[:edit, :update]}

  def index
    @users = User.all
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/topics")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("login_form")
    end
      
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      image_name: "km172841740212130209300.png",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/topics")
    else
      render("signup")
    end
  end

  
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice] = "失敗"
      render("users/#{@user.id}/edit")
    end
  end

  def ensure_correct_user
    if  @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end
  
end
