class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @users = User.all.order(:created_at)
  end

  def show
  end

  def update
    if @user.update(user_params)
      @user.roles = Role.where(id: params[:user][:role_ids]) if params[:user][:role_ids]
      redirect_to admin_user_path(@user), notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  def toggle_role
    if @user.has_role?(:admin)
      @user.remove_role(:admin)
    else
      @user.add_role(:admin)
    end
    redirect_to admin_users_path, notice: 'User role updated.'
  end

  private
  
  def user_params
    params.require(:user).permit(:email, role_ids: [])
  end
end