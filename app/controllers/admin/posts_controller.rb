class Admin::PostsController < Admin::BaseController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]  

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    # @post = current_user.posts.build(post_params)  # Gán user_id từ current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

def report
  post = Post.find(params[:id])
  user = post.user
  
  puts "==== USER EMAIL: #{user.email}, POST ID: #{post.id}"  
  
  Rails.logger.info "Reporting post #{post.id} by user #{user.id} (#{user.email})"
  
  UserMailer.report_violation_email(user, post).deliver_later
  
  Rails.logger.info "====== EMAIL SENT DIRECTLY ======"
  
  # Redirect lại trang admin post với thông báo
  redirect_to admin_posts_path, notice: 'The post has been reported. The user will be notified shortly.'
end
  private

  def set_post
    @post = Post.find(params[:id])  # Lấy bài viết theo ID
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :published)  # Các tham số cho bài viết
  end

  def authorize_user
    # Kiểm tra nếu bài viết thuộc về người dùng hiện tại hay không
    unless @post.user_id == current_user.id
      redirect_to posts_path, alert: "Bạn không có quyền chỉnh sửa hoặc xóa bài viết này."
    end
  end
end