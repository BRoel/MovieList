class MoviesController < ApplicationController
    
    def index
        if params[:list_id] && @list = List.find_by_id(params[:list_id])
            @movies = @list.movies
        else 
            @movies = Movie.all
        end
    end

    def new
        if params[:list_id] && @list = List.find_by_id(params[:list_id])
            @movie = @list.movies.build
        else 
            @error = "That list doesn't exist" if params[:list_id]
            @movie = Movie.new
            #I want to remove this possibility at worst keep error coding
        end
    end
    
    def create
        list = list_movie
        @movie = list.movies.build(movie_params)
        if @movie.save
            redirect_to list
        else
            render :new
        end
    end

    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    def edit
    end

    def update
    end

    private

    def movie_params
        params.require(:movie).permit(:title,:rating,:release_date,:genre,:description)
    end

    def list_movie
        List.find(params["list_id"])
    end

end