class UsersController < ApplicationController

  before_action :authenticate_user!


  def show
    @user = User.find_by(user_name: params[:user_name])
  end

  def edit
    if current_user != User.find_by(user_name: params[:user_name])
      flash[:error] = "このURLへのアクセス権限がありません"
      redirect_to user_path(current_user.user_name)
    end
  end

  def update
    current_user.update(update_params)
    flash[:notice] = "プロフィールを編集しました。"
    redirect_to user_path(current_user.user_name)
  end

  private
  def update_params
    params.require(:user).permit(:avatar, :introduction, :affiliation)
  end
end
