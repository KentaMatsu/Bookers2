class SearchesController < ApplicationController

  def search
    @model = params["search"]["model"]
    #選択したmodelを@modelに代入
    @content = params["search"]["content"]
    #検索にかけた文字列(ここではcontent)を@contentに代入
    @method = params["search"]["method"]
    #選択した検索方法methodを@methodに代入
    @datas = search_for(@method, @model, @content)
    #binding.pry
    #search_forの引数にインスタンス変数を定義
    #@datasに最終的な検索結果が入る
  end

  private
  def search_for(method, model, content)
  #searchアクションで定義した情報が引数に入っている
    if model == 'user'
    # 選択したモデルがuserだったら
      if method == 'match'
      # 選択した検索方法がが完全一致だったら
        User.where(name: content)
      elsif
        method == 'forward'
        # 選択した検索方法がが前方一致だったら
        User.where('name LIKE ?', content+'%')
      elsif
        method == 'backward'
        # 選択した検索方法がが後方一致だったら
        User.where('name LIKE ?', '%'+content)
      elsif
        method == 'partical'
        # 選択した検索方法がが部分一致だったら
        User.where("name LIKE ?", '%'+content+'%')
      end
    elsif model == 'book'
    # 選択したモデルがbookだったら
      if method == 'match'
        Book.where(title: content)
      elsif
        method == 'forward'
        Book.where('title LIKE ?', content+'%')
        #前方一致→モデル名.where("カラム名 LIKE ?", "値%")
      elsif
        method == 'backward'
        Book.where('title LIKE ?', '%'+content)
        #後方一致→モデル名.where("カラム名 LIKE ?", "%値")
      elsif
        method == 'partical'
        Book.where("title LIKE ?", '%'+content+'%')
        #部分一致→モデル名.where("カラム名 LIKE ?", "%値%")
      end
    end
  end

end
