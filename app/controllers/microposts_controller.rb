class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
      @micropost = current_user.microposts.build(micropost_params)
      set_in_reply_to
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          @feed_items = []
          render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_back(fallback_location: root_url)
    end

    private
        #@replyがあればin_reply_toカラムに代入する
        def set_in_reply_to
          #リプライはひとりにしかつけれらない仕様
          reply_user = @micropost[:content].slice(/(?<=@)[^\s]+/)
          @micropost[:in_reply_to] = reply_user unless reply_user.nil?
        end

        def micropost_params
          params.require(:micropost).permit(:content, :picture, :in_reply_to)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
          end
end
