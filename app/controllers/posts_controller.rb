class PostsController < ApplicationController
	before_action :find_post, only: [:show,:edit,:update,:destroy]

		def index
		  @posts = Post.all.order("created_at desc")
		  @post = Post.new
		end

		def new
		  @post = Post.new
		end

		def create
		  @post = Post.new post_params
		 	if @post.save
			  	redirect_to @post, notice:"Everything went allright, no need to worry"
			else
				render 'new', notice: "Oh no, How could we Screw up?!"
			end
		end

		def show
		  @post = Post.find_by(params[:id])
		  unless @post
		    render json: {error: "The post you are looking for doesn't seem to exist"},
		    status: 404
		    return
		  end
		end

		def update
			if @post.update post_params
				redirect_to @post, notice: "we have an update working"
			else
				render 'edit'
			end
		end

		def destroy
		  @post.destroy
		  redirect_to posts_path 
		end

		private

		def find_post
			@post = Post.find_by(params[:id])
		end

		def post_params
			params.require(:post).permit(:title, :content, :theme)
		end


end
