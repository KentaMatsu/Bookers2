class RelationshipsController < ApplicationController
  
  #フォロー機能を作成・保存・削除する
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  #モデルで定義したfollow、unfollowメソッドを使っている
  
  #フォロー・フォロワー一覧を表示する
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  #userモデルで定義したアソシエーションを利用
  
end

