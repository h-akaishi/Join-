class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :user_name?, only: [:show]


  def show
    # current_user.user_name?
    @user = User.find_by(user_name: params[:user_name])
  end

  def edit
    if current_user != User.find_by(user_name: params[:user_name])
      flash[:error] = "このURLへのアクセス権限がありません"
      redirect_to user_path(current_user.user_name)
    end
  end

  def new_edit
  end

  def update
    if current_user.update(update_params)
      flash[:notice] = "プロフィールを保存しました。"
    else
      flash[:error] = "プロフィールの保存に失敗しました。"
    end
    redirect_to user_path(current_user.user_name)
  end

  private
  def update_params
    params.require(:user).permit(:avatar, :introduction, :affiliation)
  end
  # 新規ユーザ（FB）の場合プロフィール編集
  def user_name?
    redirect_to  new_edit_user_url(current_user.user_name) if current_user.user_name == "#{current_user.uid}#{current_user.provider}"
  end
end
