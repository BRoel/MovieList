class CommentsController < ApplicationController
    
    def index
        if params[:list_id] && @list = List.find_by_id(params[:list_id])
            @comments = @list.comments
        else
            @comments = Comment.all
        end
    end

    def create
        # binding.pry
        @comment = Comment.new(comment_params.merge(user_id: current_user.id))
        if @comment.save
            redirect_to list_path(id: comment_params[:list_id])
        else
            render :new
        end
    end

    def edit
    end

    def update
    end
    
    def destroy
        # binding.pry
        @comment = Comment.find_by_id(params.merge(user_id: current_user.id))
        if @comment.destroy
            redirect_to list_path(id: comment_params[:list_id])
        else
            binding.pry
        end
    end
    
    private

    def comment_params
        params.require(:comment).permit(:content)
        params[:comment].permit(:list_id,:movie_id,:content)
    end
end
