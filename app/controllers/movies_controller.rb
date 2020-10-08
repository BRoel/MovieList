class MoviesController < ApplicationController
    
    def index
        if params[:list_id] && @list = List.find_by_id(params[:list_id])
            @movies = @list.movies
        else 
            @movies = Movie.all
        end
    end

    def new
        @movie = Movie.new
    end
    
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to movies_path
        else
            render :new
        end
    end
    
    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    def edit
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    def update
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
        if @movie.update(movie_params)
            redirect_to movie_path(@movie)
        else
            render :edit
        end
    end

    def destroy
        # binding.pry
        @movie = Movie.find_by_id(params[:id])
        @movie.destroy
        redirect_to movies_path
    end

    private

    def movie_params
        params.require(:movie).permit(:title,:rating,:release_date,:genre,:description)
    end

    def list_movie
        List.find(params["list_id"])
    end

end