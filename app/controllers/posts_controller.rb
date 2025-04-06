class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]  # Kiểm tra quyền sở hữu bài viết

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)  # Gán user_id từ current_user

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    # Bài viết sẽ được hiển thị cho tất cả người dùng
  end

  def edit
    # Phương thức này sẽ chỉ được thực hiện nếu người dùng là chủ sở hữu của bài viết
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
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