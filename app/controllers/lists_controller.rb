class ListsController < ApplicationController
    before_action :redirect_if_not_logged_in
    def index
        @lists = List.all
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
        @list = List.find_by_id(params[:id])
        redirect_to lists_path if !@list
        @comment = Comment.new
        @movies = Movie.all
    end

    def edit
        @list = List.find_by_id(params[:id])
        redirect_to lists_path if !@list || @list.user != current_user
    end
    
    def update
        @list = List.find_by(id: params[:id])
        redirect_to lists_path if !@list || @list.user != current_user
        if @list.update(list_params)
          redirect_to list_path(@list)
        else
          render :edit
        end
    end

    def destroy
        @list = List.find(params[:id])
        redirect_to lists_path if !@list || @list.user != current_user
        @list.destroy
        redirect_to lists_path
    end

    private

    def list_params
        params.require(:list).permit(:name)
    end

end
