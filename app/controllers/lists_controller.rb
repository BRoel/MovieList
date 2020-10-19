class ListsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_list, only: [:show, :edit, :update, :destroy]
     #nest under user index
     #Work on more complex scopes .where or .order
     #authentication be able to define properly
    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @lists = @user.lists.alpha
        else
           @error = "This user doesn't exist" if params[:user_id]
           @lists = List.all.alpha
        end
    end
    
    def new
        @list = List.new
    end
    
    def create
        @list = current_user.lists.build(list_params)
        if @list.save
            redirect_to lists_path
        else
            render :new
        end
    end

    def show
        redirect_to lists_path if !@list
        @comment = Comment.new
        @movies = Movie.all
    end

    def edit
        redirect_to lists_path if !@list || @list.user != current_user
    end
    
    def update
        redirect_to lists_path if !@list || @list.user != current_user
        if @list.update(list_params)
          redirect_to list_path(@list)
        else
          render :edit
        end
    end

    def destroy
        redirect_to lists_path if !@list || @list.user != current_user
        @list.destroy
        redirect_to lists_path
    end

    private
#set list 

    def set_list
        @list = List.find_by_id(params[:id])
    end
    def list_params
        params.require(:list).permit(:name)
    end

end
