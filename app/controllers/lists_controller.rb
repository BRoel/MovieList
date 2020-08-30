class ListsController < ApplicationController
    
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

    def edit
        @list = List.find_by(id: params[:id])
    end

    def update
        @list = List.find_by(id: params[:id])
    end

    private

    def list_params
        params.require(:list).permit(:name)
    end

end
