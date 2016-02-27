class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        #@micropost = Micropost.find(params[:id])
        #@favorite = current_user.favorites.build(micropost_id: params[:id])
        #saveする値 user_idとmicropost_id
        
        #favoriteモデルで作成したfavoriteメソッド
        #def favorite(micropost_id)
          #favorites.find_or_create_by(micropost_id: micropost_id)
        #end
        if current_user.favorite(params[:id])
	       redirect_to :back, notice: "お気に入りに登録しました"
	    else
	       redirect_to :back, alert: "登録できません"
        end
    end    
    
    def destroy
        micropost = Micropost.find_by(id: params[:id])
        #@favorite = current_user.favorites.find_by!(micropost_id: params[:micropost_id])
	    #@favorite.destroy
	    current_user.unfavorite(micropost)
	    redirect_to :back, notice: "解除しました"
    end    
end
